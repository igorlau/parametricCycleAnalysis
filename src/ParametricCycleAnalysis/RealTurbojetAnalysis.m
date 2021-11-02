function [turbojet] = RealTurbojetAnalysis(mach, flightRegimeType, flightRegimeValue, gammaC, cpC, hpr, Tt4,...
    gammaT, cpT, piC, piDmax, piB, piN, polyEffC, polyEffT, etaB, etaM, P0P9, varargin)
% Parametric on-design cycle  analysis of real TURBOJET engine with or
%   without afterburner
%
%   INPUT:
%       - mach: Mach number [-]
%           -- single number for one point analysis (e.g. 0.8)
%           -- array for analysis as a mach function (e.g. [0, 2])
%       - flightRegimeType: enumeration defining which input is provided
%           (T0 or altitude)
%       - flightRegimeType: value corresponding to the respective flight regime
%           selected (T0: [K] / altitude: [m]
%       - gammaC: heat capacity ratio at compressor [-]
%       - cpC: heat capacity at constant pressure at compressor
%               [J/(kg K)]
%       - gammaT: heat capacity ratio at turbine [-]
%       - cpT: heat capacity at constant pressure at turbine
%               [J/(kg K)]
%       - hpr: termic energy released in combustion [J/kg]
%       - Tt4: stagnation temperature at combustion chaimber [K]
%       - piC: compression ratio at the compressor [-]
%       - piDmax: maximum compression ratio at the diffuser [-]
%       - piB: compression ratio at the burner [-]
%       - piN: compression ratio at the noizzle [-]
%       - polyEffC: polytropic efficiency at the compressor [-]
%       - polyEffT: polytropic efficiency at the turbine [-]
%       - etaB: burner efficiency [-]
%       - etaM: mechanical efficiency [-]
%       - P0P9: inlet-outlet pressure ratio [-]
%       - varargin: inputs if the engine has afterburner
%           -- afterburner: boolean that indicates the presence of an
%           afterburner
%           -- Tt7: stagnation temperature at afterburner [K]
%           -- gammaAB: heat capacity ratio at afterburner [-]
%           -- cpAB: heat capacity at constant pressure at afterburner
%                     [J/(kg K)]
%           -- piAB: compression rate at the afterburner [-]
%           -- etaAB: afterburner efficiency [-]
%   OUTPUT:
%       - localSoundVelocity: local sound velocity [m/s]
%       - freestreamVelocity: freestream velocity [m/s]
%       - exitMach: engine exit Mach number [-]
%       - exitVelocity: engine exit velocity [m/s]
%       - specificThrust: specific thrust [N/(kg/s)]
%       - specificConsumption: specific fuel consumption [kg/(N s)]
%       - fuelAirRatio: fuel-air mass flow ratio [-]
%       - efficiencies: struct with engine efficiencies
%           -- thermal: thermal efficiency [-]
%           -- propulsive: propulsive efficiency [-]
%           -- total: total efficiency [-]
%           -- compressor: compressor efficiency [-]
%           -- turbine: turbine efficiency [-]
%
%   REFERENCE: MATTINGLY, J. D. Elements of Propulsion: Gas Trubines
%   and Rockets, AIAA - 2006.
%
%   AUTHOR: Igor Lau - Jul 2021

%% Check for afterburner
if(~isempty(varargin))
    afterburner = varargin{1};
    Tt7 = varargin{2};
    gammaAB = varargin{3};
    cpAB = varargin{4};
    piAB = varargin{5};
    etaAB = varargin{6};
else
    afterburner = false;
end

% Validation of minimum and maximum inputs
if(length(varargin) > 6)
    error("realTurbojet:numberOfInputs", "Too many inputs arguments.")
end

%% Variable allocation
machLen = length(mach);
piCLen = length(piC);
cell_size = length(flightRegimeValue);

V0 = NaN(piCLen, machLen);
tauR = NaN(piCLen, machLen);
piR = NaN(piCLen, machLen);
etaR = NaN(piCLen, machLen);
piD = NaN(piCLen, machLen);
f = NaN(piCLen, machLen);
fAB = NaN(piCLen, machLen);
tauT = NaN(piCLen, machLen);
tauC = NaN(piCLen, 1);
etaC = NaN(piCLen, 1);
piT = NaN(piCLen, machLen);
etaT = NaN(piCLen, machLen);
Pt9P9 = NaN(piCLen, machLen);
T9T0 = NaN(piCLen, machLen);
mach9 = NaN(piCLen, machLen);
V9a0 = NaN(piCLen, machLen);
V9 = NaN(piCLen, machLen);
specificThrust = NaN(piCLen, machLen);
S = NaN(piCLen, machLen);
thermalEff = NaN(piCLen, machLen);
propEff = NaN(piCLen, machLen);
totalEff = NaN(piCLen, machLen);

thermalEff_cell = cell(1,cell_size);
propEff_cell = cell(1,cell_size);
totalEff_cell = cell(1,cell_size);
etaC_cell = cell(1,cell_size);
etaT_cell = cell(1,cell_size);
a0_cell = cell(1,cell_size);
V0_cell = cell(1,cell_size);
mach9_cell = cell(1,cell_size);
V9_cell = cell(1,cell_size);
specificThrust_cell = cell(1,cell_size);
f_cell = cell(1,cell_size);
S_cell = cell(1,cell_size);

%% Parametric analysis
% Auxiliar parameter
gammaCRatio = (gammaC-1)/gammaC;
gammaTRatio = (gammaT-1)/gammaT;

if(afterburner)
    gammaABRatio = (gammaAB-1)/gammaAB;
end

% Mach and piC independent parameters
Rc = gammaCRatio*cpC;
Rt = gammaTRatio*cpT;

for k = 1:cell_size
    if (flightRegimeType == FlightRegimeInputType.Temperature)
        T0 = flightRegimeValue(k);
        a0 = sqrt(gammaC*Rc*T0);
    else
        [ T0, ~, ~, a0 ] = USStandardAtmosphere( flightRegimeValue(k) );
    end
    
    tauLambda = cpT*Tt4/(cpC*T0);
    
    if(afterburner)
        R_AB = gammaABRatio*cpAB;
        tauLambdaAB = cpAB*Tt7/(cpC*T0);
    end
    
    for j = 1:piCLen
        % Mach independent and piC dependent parameters
        tauC(j) = piC(j) ^ (gammaCRatio/polyEffC);
        etaC(j) = (piC(j) ^ gammaCRatio - 1)/(tauC(j) - 1);
        
        % Mach and piC dependent parameters
        for i = 1:machLen
            
            V0(j,i) = a0*mach(i);
            
            tauR(j,i) = 1 + 0.5*(gammaC-1)*mach(i)^2;
            piR(j,i) = tauR(j,i) ^ (1/gammaCRatio);
            
            if mach(i) <= 1
                etaR(j,i) = 1;
            elseif (mach(i) > 1 && mach(i) <= 5)
                etaR(j,i) = 1 - 0.075*(mach(i)-1)^1.35;
            elseif mach(i) > 5
                etaR(j,i) = 800/(mach(i)^4 + 935);
            end
            
            piD(j,i) = piDmax*etaR(j,i);
            
            f(j,i) = (tauLambda - tauR(j,i)*tauC(j))/(hpr*etaB/(cpC*T0) - tauLambda);
            
            tauT(j,i) = 1 - tauR(j,i)*(tauC(j)-1)/(etaM*tauLambda*(1+f(j,i)));
            piT(j,i) = tauT(j,i) ^ (1/(gammaTRatio*polyEffT));
            etaT(j,i) =  (1 - tauT(j,i))/(1 - tauT(j,i)^(1/polyEffT));
            
            if(afterburner)
                fAB(j,i) = (1+f(j,i))*(tauLambdaAB - tauLambda*tauT(j,i))/...
                    (etaAB*hpr/(cpC*T0) - tauLambdaAB);
                Pt9P9(j,i) = P0P9*piR(j,i)*piD(j,i)*piC(j)*piB*piT(j,i)*piAB*piN;
                T9T0(j,i) = (Tt7/T0)/(Pt9P9(j,i)^gammaABRatio);
                mach9(j,i) = sqrt(2*( Pt9P9(j,i)^gammaABRatio - 1 )/(gammaAB - 1));
                V9a0(j,i) = mach9(j,i)*sqrt(gammaAB*R_AB*T9T0(j,i)/(gammaC*Rc));
                V9(j,i) = V9a0(j,i)*a0;
                
                specificThrust(j,i) = a0*((1+f(j,i)+fAB(j,i))*V9a0(j,i) - mach(i) + ...
                    (1+f(j,i)+fAB(j,i))*(R_AB*T9T0(j,i)*(1-P0P9))/(Rc*V9a0(j,i)*gammaC));
                S(j,i) = (f(j,i) + fAB(j,i))/specificThrust(j,i);
                
                thermalEff(j,i) = a0^2*((1+f(j,i)+fAB(j,i))*V9a0(j,i)^2 - mach(i)^2 )/...
                    ( 2*(f(j,i)+fAB(j,i))*hpr );
                propEff(j,i) = 2*V0(j,i)*specificThrust(j,i)/...
                    (a0^2*((1+f(j,i)+fAB(j,i))*V9a0(j,i)^2 - mach(i)^2));
                totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
            else
                Pt9P9(j,i) = P0P9*piR(j,i)*piD(j,i)*piC(j)*piB*piT(j,i)*piN;
                T9T0(j,i) = tauLambda*tauT(j,i)/(Pt9P9(j,i)^gammaTRatio)*(cpC/cpT);
                mach9(j,i) = sqrt( 2*(Pt9P9(j,i)^gammaTRatio - 1)/(gammaT-1) );
                V9a0(j,i) = mach9(j,i)*sqrt(gammaT*Rt*T9T0(j,i)/(gammaC*Rc));
                V9(j,i) = V9a0(j,i)*a0;
                
                specificThrust(j,i) = a0*((1+f(j,i))*V9a0(j,i) - mach(i) + ...
                    (1+f(j,i))*(Rt*T9T0(j,i)*(1 - P0P9)/(Rc*V9a0(j,i)*gammaC)));
                S(j,i) = f(j,i)/specificThrust(j,i);
                
                thermalEff(j,i) = a0^2*((1+f(j,i))*V9a0(j,i)^2 - mach(i)^2 )/( 2*f(j,i)*hpr );
                propEff(j,i) = 2*V0(j,i)*specificThrust(j,i)/...
                    (a0^2*((1+f(j,i))*V9a0(j,i)^2 - mach(i)^2));
                totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
                
            end
            
        end
    end
    
    if (afterburner)
        f_tot = f + fAB;
    else
        f_tot = f;
    end
    
    thermalEff_cell{k} = thermalEff;
    propEff_cell{k} = propEff;
    totalEff_cell{k} = totalEff;
    etaC_cell{k} = etaC;
    etaT_cell{k} = etaT;
    
    a0_cell{k} = a0;
    V0_cell{k} = V0;
    mach9_cell{k} = mach9;
    V9_cell{k} = V9;
    specificThrust_cell{k} = specificThrust;
    f_cell{k} = f_tot;
    S_cell{k} = S;
end

%% Structs assembly for function outputs
efficiencies.thermal = thermalEff_cell;
efficiencies.propulsive = propEff_cell;
efficiencies.total = totalEff_cell;
efficiencies.compressor = etaC_cell;
efficiencies.turbine = etaT_cell;

turbojet.localSoundVelocity = a0_cell;
turbojet.freestreamVelocity = V0_cell;
turbojet.exitMach = mach9_cell;
turbojet.exitVelocity = V9_cell;
turbojet.specificThrust = specificThrust_cell;
turbojet.fuelAirRatio = f_cell;
turbojet.specificConsumption = S_cell;
turbojet.efficiencies = efficiencies;

end
