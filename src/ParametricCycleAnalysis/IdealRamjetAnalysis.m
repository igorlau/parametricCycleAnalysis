function [ramjet] = IdealRamjetAnalysis(mach, flightRegimeType, flightRegimeValue, gamma, cp, hpr, Tt4)
%   Parametric on-design cycle  analysis of ideal RAMJET engine
%
%   Below are the description of the variables of the function output and
%       its units
%
%   INPUT:
%       - mach: Mach number [-]
%           -- singel number for one point analysis (e.g. 0.8)
%           -- array for analysis as a mach function (e.g. [0, 2])
%       - flightRegimeType: enumeration defining which input is provided
%           (T0 or altitude)
%       - flightRegimeType: value corresponding to the respective flight regime
%           selected (T0: [K] / altitude: [m]
%       - gamma: heat capacity ratio [-]
%       - cp: heat capacity at constant pressure [J/(kg K)]
%       - hpr: termic energy released in combustion [J/kg]
%       - Tt4: stagnation temperature at combustion chaimber [K]
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
%       - optimal: optimal parameters for maximum specific thrust
%           -- mach: optimal Mach Number [-]
%
%   REFERENCE: MATTINGLY, J. D. Elements of Propulsion: Gas Trubines
%   and Rockets, AIAA - 2006.
%
%   AUTHOR: Igor Lau - Jul 2021

%% Variable allocation
mach_size = length(mach);
cell_size = length(flightRegimeValue);

totalEff = NaN(1,mach_size);
thermalEff = NaN(1,mach_size);
propEff = NaN(1,mach_size);
f = NaN(1,mach_size);
optMach = NaN(1,mach_size);
S = NaN(1,mach_size);
specificThrust = NaN(1,mach_size);
tauR = NaN(1,mach_size);
V0 = NaN(1,mach_size);
V9a0 = NaN(1,mach_size);
V9 = NaN(1,mach_size);
mach9 = NaN(1,mach_size);

V0_cell = cell(1,cell_size);
a0_cell = cell(1,cell_size);
V9_cell = cell(1,cell_size);
mach9_cell = cell(1,cell_size);
specificThrust_cell = cell(1,cell_size);
f_cell = cell(1,cell_size);
S_cell = cell(1,cell_size);
thermalEff_cell = cell(1,cell_size);
propEff_cell = cell(1,cell_size);
totalEff_cell = cell(1,cell_size);
optMach_cell = cell(1,cell_size);

%% Parametric analysis
for j = 1 : length(flightRegimeValue)
    
    % Mach independent parameters
    if (flightRegimeType == FlightRegimeInputType.Temperature)
        R = (gamma-1)*cp/gamma;
        T0 = flightRegimeValue(j);
        a0 = sqrt(gamma*R*T0);
    else
        [ T0, ~, ~, a0 ] = USStandardAtmosphere( flightRegimeValue(j) );
    end
    tauLambda = Tt4/T0;
    
    % Mach dependent parameters
    for i = 1:mach_size
        V0(i) = a0*mach(i);
        
        tauR(i) = 1 + 0.5*(gamma-1)*mach(i)^2 ;
        
        V9a0(i) = mach(i) * sqrt(tauLambda/tauR(i));
        V9(i) = V9a0(i)*a0;
        mach9(i) = mach(i);
        
        specificThrust(i) = a0*(V9a0(i) - mach(i));
        f(i) = cp*T0 *(tauLambda - tauR(i))/hpr;
        S(i) = f(i) / specificThrust(i);
        
        thermalEff(i) = 1 - 1 / tauR(i);
        propEff(i) = 2 / (sqrt( tauLambda/tauR(i) ) + 1);
        totalEff(i) = thermalEff(i) * propEff(i);
        
        optMach(i) = sqrt(2*(tauLambda^(1/3) - 1)/(gamma - 1));
    end
    
    V0_cell{j} = V0;
    a0_cell{j} = a0;
    V9_cell{j} = V9;
    mach9_cell{j} = mach9;
    specificThrust_cell{j} = specificThrust;
    f_cell{j} = f;
    S_cell{j} = S;
    thermalEff_cell{j} = thermalEff;
    propEff_cell{j} = propEff;
    totalEff_cell{j} = totalEff;
    optMach_cell{j} = optMach;
end

%% Structs assembly for function outputs
optimum.mach = optMach_cell;

efficiencies.thermal = thermalEff_cell;
efficiencies.propulsive = propEff_cell;
efficiencies.total = totalEff_cell;

ramjet.localSoundVelocity = a0_cell;
ramjet.freestreamVelocity = V0_cell;
ramjet.exitMach = mach9_cell;
ramjet.exitVelocity = V9_cell;
ramjet.specificThrust = specificThrust_cell;
ramjet.fuelAirRatio = f_cell;
ramjet.specificConsumption = S_cell;
ramjet.efficiencies = efficiencies;
ramjet.optimum = optimum;
end
