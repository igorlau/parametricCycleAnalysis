function [turbofan] = RealTurbofanAnalysis(mach, flightRegimeType, flightRegimeValue, gammaC, cpC, hpr, Tt4, ...
    gammaT, cpT, piC, piF, piDmax, piB, piN, piFN, polyEffC, polyEffT, polyEffF, etaB,...
    etaM, P0P9, P0P19, BPR)
%   Parametric on-design cycle  analysis of ideal TURBOFAN engine with
%       separete exhaust streams
%
%   Below are the description of the variables of the function input,
%       output and its units
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
%       - piC: compression ratio ate the compressor [-]
%       - piF: compression ratio ate the fan [-]
%       - piDmax: maximum compression ratio at the diffuser [-]
%       - piB: compression ratio at the burner [-]
%       - piN: compression ratio at the noizzle [-]
%       - piFN: compression ratio ate the fan nozzle [-]
%       - polyEffC: polytropic efficiency at the compressor [-]
%       - polyEffT: polytropic efficiency at the turbine [-]
%       - polyEffF: polytropic efficiency at the fan [-]
%       - etaB: burner efficiency [-]
%       - etaM: mechanical efficiency [-]
%       - P0P9: inlet-outlet pressure ratio [-]
%       - P0P19: inlet-outlet fan pressure ratio [-]
%       - BPR: turbofan bypass ratio [-]
%   OUTPUT:
%       - localSoundVelocity: local sound velocity [m/s]
%       - freestreamVelocity: freestream velocity [m/s]
%       - exitCoreVelocity: core exit velocity [m/s]
%       - exitFanVelocity: fan exit velocity [m/s]
%       - exitCoreMach: core exit mach [-]
%       - exitFanMach: fan exit mach [-]
%       - specificThrust: specific thrust [N/(kg/s)]
%       - specificConsumption: specific fuel consumption [kg/(N s)]
%       - fuelAirRatio: fuel-air mass flow ratio [-]
%       - thrustRatio: thrust per unit of mass flow in the core and fan [-]
%       - efficiencies: struct with engine efficiencies
%           -- thermal: thermal efficiency [-]
%           -- propulsive: propulsive efficiency [-]
%           -- total: total efficiency [-]
%           -- compressor: compressor efficiency [-]
%           -- turbine: turbine efficiency [-]
%           -- fan: fan efficiency [-]
%       - optimum: parameters for optimum bypass ratio (min specific consumption)
%           -- BPR: bypass ratio [-]
%           -- specificThrust: specific thrust [N/(kg/s)]
%           -- specificConsumption: specific fuel consumption [kg/(N s)]
%           -- efficiencies: struct with efficiencies for optimum BPR
%               --- thermal: thermal efficiency [-]
%               --- propulsive: propulsive efficiency [-]
%               --- total: total efficiency [-]
%
%   REFERENCE: MATTINGLY, J. D. Elements of Propulsion: Gas Trubines
%   and Rockets, AIAA - 2006.
%
%   AUTHOR: Igor Lau - Jul 2021

%% Variable allocation
machLen = length(mach);
piCLen = length(piC);
piFLen = length(piF);
piLen = max(piFLen, piCLen);
cell_size = length(flightRegimeValue);

V0 = NaN(piLen, machLen);
tauR = NaN(piLen, machLen);
piR = NaN(piLen, machLen);
etaR = NaN(piLen, machLen);
piD = NaN(piLen, machLen);
f = NaN(piLen, machLen);
tauT = NaN(piLen, machLen);
tauF = NaN(1, piFLen);
tauC = NaN(1, piCLen);
piT = NaN(piLen, machLen);
etaT = NaN(piLen, machLen);
etaF = NaN(piFLen, 1);
etaC = NaN(piCLen, 1);
Pt9P9 = NaN(piLen, machLen);
mach9 = NaN(piLen, machLen);
V9 = NaN(piLen, machLen);
T9T0 = NaN(piLen, machLen);
V9a0 = NaN(piLen, machLen);
Pt19P19 = NaN(piLen, machLen);
mach19 = NaN(piLen, machLen);
V19 = NaN(piLen, machLen);
T19T0 = NaN(piLen, machLen);
V19a0 = NaN(piLen, machLen);
specificThrust = NaN(piLen, machLen);
S = NaN(piLen, machLen);
FR = NaN(piLen, machLen);
thermalEff = NaN(piLen, machLen);
propEff = NaN(piLen, machLen);
totalEff = NaN(piLen, machLen);

thermalEff_cell = cell(1,cell_size);
propEff_cell = cell(1,cell_size);
totalEff_cell = cell(1,cell_size);
etaC_cell = cell(1,cell_size);
etaT_cell = cell(1,cell_size);
etaF_cell = cell(1,cell_size);
a0_cell = cell(1,cell_size);
V0_cell = cell(1,cell_size);
V9_cell = cell(1,cell_size);
V19_cell = cell(1,cell_size);
mach9_cell = cell(1,cell_size);
mach19_cell = cell(1,cell_size);
specificThrust_cell = cell(1,cell_size);
f_cell = cell(1,cell_size);
S_cell = cell(1,cell_size);
FR_cell = cell(1,cell_size);

%% Parametric analysis
% Auxiliar parameter
gammaCRatio = (gammaC-1)/gammaC;
gammaTRatio = (gammaT-1)/gammaT;

% Mach, piC and piF independent parameters
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
    
    if (piCLen == 1 && piFLen >= 1)
        tauC = piC ^ (gammaCRatio/polyEffC);
        etaC = (piC ^ gammaCRatio - 1)/(tauC - 1);
        
        for j = 1:piFLen
            tauF(j) = piF(j)^( gammaCRatio/polyEffF );
            etaF(j) = (piF(j)^gammaCRatio - 1)/(tauF(j) - 1);
            
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
                
                f(j,i) = (tauLambda - tauR(j,i)*tauC )/( hpr*etaB/(cpC*T0) - tauLambda);
                
                tauT(j,i) = 1 - tauR(j,i)*(tauC - 1 + BPR*(tauF(j)-1))/( etaM*tauLambda*(1+f(j,i)) );
                piT(j,i) = tauT(j,i)^( 1/(gammaTRatio*polyEffT) );
                etaT(j,i) = (1 - tauT(j,i))/(1 - tauT(j,i)^(1/polyEffT));
                
                Pt9P9(j,i) = P0P9*piR(j,i)*piD(j,i)*piC*piB*piT(j,i)*piN;
                mach9(j,i) = sqrt(2*(Pt9P9(j,i)^gammaTRatio - 1)/(gammaT-1));
                T9T0(j,i) = tauLambda*tauT(j,i)/(Pt9P9(j,i)^gammaTRatio)*(cpC/cpT);
                V9a0(j,i) = mach9(j,i)*sqrt(gammaT*Rt*T9T0(j,i)/(gammaC*Rc));
                V9(j,i) = V9a0(j,i)*a0;
                
                Pt19P19(j,i) = P0P19*piR(j,i)*piD(j,i)*piF(j)*piFN;
                
                mach19(j,i) = sqrt(2*(Pt19P19(j,i)^gammaCRatio - 1)/(gammaC-1));
                T19T0(j,i) = tauR(j,i)*tauF(j)/(Pt19P19(j,i)^gammaCRatio);
                V19a0(j,i) = mach19(j,i)*sqrt(T19T0(j,i));
                V19(j,i) = V19a0(j,i)*a0;
                
                specificThrust(j,i) = (a0/(1+BPR))*...
                    ((1+f(j,i))*V9a0(j,i) - mach(i) + ...
                    (1+f(j,i))*Rt*T9T0(j,i)*(1-P0P9)/(Rc*V9a0(j,i)*gammaC)) + (BPR*a0/(1+BPR))*...
                    (V19a0(j,i) - mach(i) + T19T0(j,i)*(1-P0P19)/(V19a0(j,i)*gammaC));
                S(j,i) = f(j,i)/((1+BPR)*specificThrust(j,i));
                FR(j,i) = ((1+f(j,i))*V9a0(j,i) - mach(i) + (1+f(j,i))*Rt*T9T0(j,i)*(1-P0P9)/...
                    (Rc*V9a0(j,i)*gammaC))/(V19a0(j,i) - mach(i) + T19T0(j,i)*(1-P0P19)/...
                    (V19a0(j,i)*gammaC));
                
                thermalEff(j,i) = a0^2*((1+f(j,i))*V9a0(j,i)^2 +BPR*V19a0(j,i)^2 - ...
                    (1+BPR)*mach(i)^2)/(2*f(j,i)*hpr);
                propEff(j,i) = 2*mach(i)*((1+f(j,i))*V9a0(j,i) + BPR*V19a0(j,i) - (1+BPR)*mach(i))/...
                    ((1+f(j,i))*V9a0(j,i)^2 + BPR*V19a0(j,i)^2 - (1+BPR)*mach(i)^2);
                totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
                
            end
        end
    elseif (piCLen >= 1 && piFLen == 1)
        tauF = piF^( gammaCRatio/polyEffF );
        etaF = (piF^gammaCRatio - 1)/(tauF - 1);
        
        for j = 1:piCLen
            tauC(j) = piC(j) ^ (gammaCRatio/polyEffC);
            etaC(j) = (piC(j) ^ gammaCRatio - 1)/(tauC(j) - 1);
            
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
                
                f(j,i) = (tauLambda - tauR(j,i)*tauC(j) )/( hpr*etaB/(cpC*T0) - tauLambda);
                
                tauT(j,i) = 1 - tauR(j,i)*(tauC(j) - 1 + BPR*(tauF-1))/( etaM*tauLambda*(1+f(j,i)) );
                piT(j,i) = tauT(j,i)^( 1/(gammaTRatio*polyEffT) );
                etaT(j,i) = (1 - tauT(j,i))/(1 - tauT(j,i)^(1/polyEffT));
                
                Pt9P9(j,i) = P0P9*piR(j,i)*piD(j,i)*piC(j)*piB*piT(j,i)*piN;
                mach9(j,i) = sqrt(2*(Pt9P9(j,i)^gammaTRatio - 1)/(gammaT-1));
                T9T0(j,i) = tauLambda*tauT(j,i)/(Pt9P9(j,i)^gammaTRatio)*(cpC/cpT);
                V9a0(j,i) = mach9(j,i)*sqrt(gammaT*Rt*T9T0(j,i)/(gammaC*Rc));
                V9(j,i) = V9a0(j,i)*a0;
                
                Pt19P19(j,i) = P0P19*piR(j,i)*piD(j,i)*piF*piFN;
                
                mach19(j,i) = sqrt(2*(Pt19P19(j,i)^gammaCRatio - 1)/(gammaC-1));
                T19T0(j,i) = tauR(j,i)*tauF/(Pt19P19(j,i)^gammaCRatio);
                V19a0(j,i) = mach19(j,i)*sqrt(T19T0(j,i));
                V19(j,i) = V19a0(j,i)*a0;
                
                specificThrust(j,i) = (a0/(1+BPR))*...
                    ((1+f(j,i))*V9a0(j,i) - mach(i) + ...
                    (1+f(j,i))*Rt*T9T0(j,i)*(1-P0P9)/(Rc*V9a0(j,i)*gammaC)) + (BPR*a0/(1+BPR))*...
                    (V19a0(j,i) - mach(i) + T19T0(j,i)*(1-P0P19)/(V19a0(j,i)*gammaC));
                S(j,i) = f(j,i)/((1+BPR)*specificThrust(j,i));
                FR(j,i) = ((1+f(j,i))*V9a0(j,i) - mach(i) + (1+f(j,i))*Rt*T9T0(j,i)*(1-P0P9)/...
                    (Rc*V9a0(j,i)*gammaC))/(V19a0(j,i) - mach(i) + T19T0(j,i)*(1-P0P19)/...
                    (V19a0(j,i)*gammaC));
                
                thermalEff(j,i) = a0^2*((1+f(j,i))*V9a0(j,i)^2 +BPR*V19a0(j,i)^2 - ...
                    (1+BPR)*mach(i)^2)/(2*f(j,i)*hpr);
                propEff(j,i) = 2*mach(i)*((1+f(j,i))*V9a0(j,i) + BPR*V19a0(j,i) - (1+BPR)*mach(i))/...
                    ((1+f(j,i))*V9a0(j,i)^2 + BPR*V19a0(j,i)^2 - (1+BPR)*mach(i)^2);
                totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
                
            end
        end
    elseif (piCLen > 1 && piFLen > 1)
        error("realTurbofan:lengthOfPressureRatio", "Either piC or piF must have a single value")
    end
    
    thermalEff_cell{k} = thermalEff;
    propEff_cell{k} = propEff;
    totalEff_cell{k} = totalEff;
    etaC_cell{k} = etaC;
    etaT_cell{k} = etaT;
    etaF_cell{k} = etaF;
    
    a0_cell{k} = a0;
    V0_cell{k} = V0;
    V9_cell{k} = V9;
    V19_cell{k} = V19;
    mach9_cell{k} = mach9;
    mach19_cell{k} = mach19;
    specificThrust_cell{k} = specificThrust;
    f_cell{k} = f;
    S_cell{k} = S;
    FR_cell{k} = FR;
end
%% Structs assembly for function outputs

efficiencies.thermal = thermalEff_cell;
efficiencies.propulsive = propEff_cell;
efficiencies.total = totalEff_cell;
efficiencies.compressor = etaC_cell;
efficiencies.turbine = etaT_cell;
efficiencies.fan = etaF_cell;

turbofan.localSoundVelocity = a0_cell;
turbofan.freestreamVelocity = V0_cell;
turbofan.exitCoreVelocity = V9_cell;
turbofan.exitFanVelocity = V19_cell;
turbofan.exitCoreMach = mach9_cell;
turbofan.exitFanMach = mach19_cell;
turbofan.specificThrust = specificThrust_cell;
turbofan.fuelAirRatio = f_cell;
turbofan.specificConsumption = S_cell;
turbofan.thrustRatio = FR_cell;
turbofan.efficiencies = efficiencies;

end


