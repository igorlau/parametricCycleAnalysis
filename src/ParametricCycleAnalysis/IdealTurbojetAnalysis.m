function [turbojet] = IdealTurbojetAnalysis(mach, flightRegimeType, flightRegimeValue, gamma, cp, hpr, Tt4, piC, varargin)
%   Parametric on-design cycle  analysis of ideal TURBOJET engine with or
%       without an afterburner
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
%       - gamma: heat capacity ratio [-]
%       - cp: heat capacity at constant pressure [J/(kg K)]
%       - hpr: termic energy released in combustion [J/kg]
%       - Tt4: stagnation temperature at combustion chaimber [K]
%           -- single number for one point analysis (e.g. 10)
%           -- multiple values for analysis (e.g. [10, 20, 30])
%       - piC: compression ratio at the compressor [-]
%       - varargin: inputs if the engine has afterburner
%           -- afterburner: boolean that indicates the presence of an
%           afterburner
%           -- Tt7: stagnation temperature at afterburner [K]
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
%       - optimum: optimum parameters for maximum specific thrust
%           -- tauC: optimum compressor temperature ratio [-]
%           -- piC: optimum compressor pressure ratio [-]
%           -- V9A0: optimum V9/a0 parameter [-]
%           -- specificThrust: optimum specific thrust [N/(kg/s)]
%           -- fuelAirRatio: optimum fuel-air mass flow ratio [-]
%           -- specificConsumption: optimum specific consumption [kg/(N s)]
%           -- efficiencies: struct with engine efficiencies
%                   --- thermal: thermal efficiency [-]
%                   --- propulsive: propulsive efficiency [-]
%                   --- total: total efficiency [-]
%
%   REFERENCE: MATTINGLY, J. D. Elements of Propulsion: Gas Trubines
%   and Rockets, AIAA - 2006.
%
%   AUTHOR: Igor Lau - Jul 2021

%% Check for afterburner
if(~isempty(varargin))
    afterburner = varargin{1};
    Tt7 = varargin{2};
else
    afterburner = false;
end

% Validation of minimum and maximum inputs
if(length(varargin) > 2)
    error("idealTurbojet:numberOfInputs", "Too many inputs arguments.")
end

%% Variable allocation
machLen = length(mach);
piCLen = length(piC);
cell_size = length(flightRegimeValue);

totalEff = NaN(piCLen, machLen);
thermalEff = NaN(piCLen, machLen);
propEff = NaN(piCLen, machLen);
f = NaN(piCLen, machLen);
S = NaN(piCLen, machLen);
specificThrust = NaN(piCLen, machLen);
tauC = NaN(1,piCLen);
tauR = NaN(piCLen, machLen);
tauT = NaN(piCLen, machLen);
V0 = NaN(piCLen, machLen);
V9a0 = NaN(piCLen, machLen);
optTotalEff = NaN(piCLen, machLen);
optThermalEff = NaN(piCLen, machLen);
optPropEff = NaN(piCLen, machLen);
optFuelAirRatio = NaN(piCLen, machLen);
optPiC = NaN(piCLen, machLen);
optTauC = NaN(piCLen, machLen);
optSpecConsumption = NaN(piCLen, machLen);
optSpecThrust = NaN(piCLen, machLen);
optV9a0 = NaN(piCLen, machLen);
mach9 = NaN(piCLen, machLen);
V9 = NaN(piCLen, machLen);

optThermalEff_cell = cell(1,cell_size);
optPropEff_cell = cell(1,cell_size);
optTotalEff_cell = cell(1,cell_size);
optPiC_cell = cell(1,cell_size);
optTauC_cell = cell(1,cell_size);
optSpecThrust_cell = cell(1,cell_size);
optFuelAirRatio_cell = cell(1,cell_size);
optSpecConsumption_cell = cell(1,cell_size);
thermalEff_cell = cell(1,cell_size);
propEff_cell = cell(1,cell_size);
totalEff_cell = cell(1,cell_size);
a0_cell = cell(1,cell_size);
V0_cell = cell(1,cell_size);
mach9_cell = cell(1,cell_size);
V9_cell = cell(1,cell_size);
specificThrust_cell = cell(1,cell_size);
f_cell = cell(1,cell_size);
S_cell = cell(1,cell_size);

%% Parametric analysis
% Auxiliar parameter
gammaRatio = (gamma-1)/gamma;

for k = 1:cell_size
    % Mach and piC independent parameters
    if (flightRegimeType == FlightRegimeInputType.Temperature)
        R = gammaRatio*cp;
        T0 = flightRegimeValue(k);
        a0 = sqrt(gamma*R*T0);
    else
        [ T0, ~, ~, a0 ] = USStandardAtmosphere( flightRegimeValue(k) );
    end
    tauLambda = Tt4/T0;
    
    if(afterburner)
        tau_lambdaAB = Tt7/T0;
    end
    
    for j = 1:piCLen
        % Mach independent and piC dependent parameter
        tauC(j) = piC(j)^gammaRatio;
        
        % Mach dependent parameters
        for i = 1:machLen
            
            V0(j,i) = a0*mach(i);
            
            tauR(j,i) = 1 + 0.5*(gamma-1)*mach(i)^2;
            tauT(j,i) = 1 - tauR(j,i)*(tauC(j) - 1)/tauLambda;
            
            mach9(j,i) = sqrt(2*(tauR(j,i)*tauC(j)*tauT(j,i) - 1)/(gamma-1));
            
            if(afterburner)
                V9a0(j,i) = sqrt(2*tau_lambdaAB*(1 - tauLambda/...
                    (tauR(j,i)*tauC(j)*(tauLambda - tauR(j,i)*(tauC(j)-1))))/(gamma-1));
                V9(j,i) = V9a0(j,i)*a0;
            else
                V9a0(j,i) = sqrt(2*tauLambda*(tauR(j,i)*tauC(j)*tauT(j,i) - 1)/...
                    ((gamma-1)*tauR(j,i)*tauC(j)));
                V9(j,i) = V9a0(j,i)*a0;
            end
            
            specificThrust(j,i) = a0*( V9a0(j,i) - mach(i) );
            
            if(afterburner)
                f(j,i) = cp*T0*(tau_lambdaAB - tauR(j,i))/hpr;
            else
                f(j,i) = cp*T0*(tauLambda - tauR(j,i)*tauC(j))/hpr;
            end
            
            S(j,i) = f(j,i)/specificThrust(j,i);
            
            if(afterburner)
                thermalEff(j,i) = (gamma-1)*cp*T0*(V9a0(j,i)^2 - mach(i)^2)/(2*f(j,i)*hpr);
            else
                thermalEff(j,i) = 1 - 1/( tauR(j,i)*tauC(j) );
            end
            
            propEff(j,i) = 2*mach(i)/( V9a0(j,i) + mach(i) );
            totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
            
            if(afterburner)
                optTauC(j,i) = 0.5*(tauLambda/tauR(j,i) + 1);
                optPiC(j,i) = optTauC(j,i)^(1/gammaRatio);
                optV9a0(j,i) = sqrt(2*tau_lambdaAB*(1 - 4*tauLambda/...
                    (tauLambda + tauR(j,i))^2)/(gamma-1));
                optSpecThrust(j,i) = a0*( optV9a0(j,i) - mach(i) );
                optFuelAirRatio(j,i) = f(j,i);
                optSpecConsumption(j,i) = optFuelAirRatio(j,i)/optSpecThrust(j,i);
                optThermalEff(j,i) = thermalEff(j,i);
                optPropEff(j,i) = propEff(j,i);
                optTotalEff(j,i) = totalEff(j,i);
            else
                optTauC(j,i) = sqrt(tauLambda)/tauR(j,i);
                optPiC(j,i) = optTauC(j,i)^(1/gammaRatio);
                optV9a0(j,i) = sqrt(2*( (sqrt(tauLambda) - 1)^2 + tauR(j,i) - 1 )/(gamma-1));
                optSpecThrust(j,i) = a0*( optV9a0(j,i) - mach(i) );
                optFuelAirRatio(j,i) = cp*T0*( tauLambda - sqrt(tauLambda) )/hpr;
                optSpecConsumption = optFuelAirRatio(j,i)/optSpecThrust(j,i);
                optThermalEff(j,i) = 1 - 1/( tauR(j,i)*optTauC(j,i) );
                optPropEff(j,i) = 2*mach(i)/( optV9a0(j,i) + mach(i) );
                optTotalEff(j,i) = optThermalEff(j,i)*optPropEff(j,i);
            end
            
        end
    end
    optThermalEff_cell{k} = optThermalEff;
    optPropEff_cell{k} = optPropEff;
    optTotalEff_cell{k} = optTotalEff;
    optPiC_cell{k} = optPiC;
    optTauC_cell{k} = optTauC;
    optSpecThrust_cell{k} = optSpecThrust;
    optFuelAirRatio_cell{k} = optFuelAirRatio;
    optSpecConsumption_cell{k} = optSpecConsumption;
    
    thermalEff_cell{k} = thermalEff;
    propEff_cell{k} = propEff;
    totalEff_cell{k} = totalEff;
    
    a0_cell{k} = a0;
    V0_cell{k} = V0;
    mach9_cell{k} = mach9;
    V9_cell{k} = V9;
    specificThrust_cell{k} = specificThrust;
    f_cell{k} = f;
    S_cell{k} = S;
end
%% Structs assembly for function outputs
optEfficiencies.thermal = optThermalEff_cell;
optEfficiencies.propulsive = optPropEff_cell;
optEfficiencies.total = optTotalEff_cell;

optimum.piC = optPiC_cell;
optimum.tauC = optTauC_cell;
optimum.specificThrust = optSpecThrust_cell;
optimum.fuelAirRatio = optFuelAirRatio_cell;
optimum.specificConsumption = optSpecConsumption_cell;
optimum.efficiencies = optEfficiencies;

efficiencies.thermal = thermalEff_cell;
efficiencies.propulsive = propEff_cell;
efficiencies.total = totalEff_cell;

turbojet.localSoundVelocity = a0_cell;
turbojet.freestreamVelocity = V0_cell;
turbojet.exitMach = mach9_cell;
turbojet.exitVelocity = V9_cell;
turbojet.specificThrust = specificThrust_cell;
turbojet.fuelAirRatio = f_cell;
turbojet.specificConsumption = S_cell;
turbojet.efficiencies = efficiencies;
turbojet.optimum = optimum;

end
