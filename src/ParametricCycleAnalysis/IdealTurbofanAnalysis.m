function [turbofan] = IdealTurbofanAnalysis(mach, flightRegimeType, flightRegimeValue, gamma, cp, hpr, Tt4, piC, piF, BPR)
% Parametric on-design cycle  analysis of ideal TURBIFAN engine
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
%       - piC: compression ratio ate the compressor [-]
%       - piF: compression ratio ate the fan [-]
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
%       - FR: thrust per unit of mass flow in the core and fan [-]
%       - fuelAirRatio: fuel-air mass flow ratio [-]
%       - efficiencies: struct with engine efficiencies
%           -- thermal: thermal efficiency [-]
%           -- propulsive: propulsive efficiency [-]
%           -- total: total efficiency [-]
%       - optimum: optimum parameters for
%           -- optimum bypass ratio (minimum specific fuel consumption)
%               --- bypass ratio
%               --- specific thrust
%               --- fuel-air mass flow ratio
%               --- specific consumption
%               --- propulsive efficiency
%               --- total efficiency
%               --- thrust per unit of mass flow in the core and fan
%           -- optimum fan pressure ratio (maximum thrust per unit mass
%                   flow and minimum thrust specific fuel consumption)
%               --- temperature ratio at the fan
%               --- pressure ratio at the fan
%               --- specific thrust
%               --- specific consumption
%               --- propulsive efficiency
%               --- total efficiency
%               --- thrust per unit of mass flow in the core and fan
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

totalEff = NaN(piLen, machLen);
thermalEff = NaN(piLen, machLen);
propEff = NaN(piLen, machLen);
f = NaN(piLen, machLen);
thrustRatio = NaN(piLen, machLen);
S = NaN(piLen, machLen);
specificThrust = NaN(piLen, machLen);
tauR = NaN(piLen, machLen);
tauT = NaN(piLen, machLen);
tauF = NaN(1, piFLen);
tauC = NaN(1, piCLen);
V0 = NaN(piLen, machLen);
V9 = NaN(piLen, machLen);
V19 = NaN(machLen,piLen);
mach9 = NaN(piLen, machLen);
mach19 = NaN(piLen, machLen);
V9a0 = NaN(piLen, machLen);
V19a0 = NaN(piLen, machLen);
optBPR_BPR = NaN(piLen, machLen);
optBPR_V9 = NaN(piLen, machLen);
optBPR_V9a0 = NaN(piLen, machLen);
optBPR_V19 = NaN(piLen, machLen);
optBPR_specificThrust = NaN(piLen, machLen);
optBPR_f = NaN(piLen, machLen);
optBPR_S = NaN(piLen, machLen);
optBPR_propEff = NaN(piLen, machLen);
optBPR_totalEff = NaN(piLen, machLen);
optPiF_tauF = NaN(piLen, machLen);
optPiF_piF = NaN(piLen, machLen);
optPiF_V19a0 = NaN(piLen, machLen);
optPiF_V9 = NaN(piLen, machLen);
optPiF_V9a0 = NaN(piLen, machLen);
optPiF_V19 = NaN(piLen, machLen);
optPiF_specificThrust = NaN(piLen, machLen);
optPiF_f = NaN(piLen, machLen);
optPiF_S = NaN(piLen, machLen);
optPiF_propEff = NaN(piLen, machLen);
optPiF_totalEff = NaN(piLen, machLen);

optBPR_thermalEff_cell = cell(1,cell_size);
optBPR_propEff_cell = cell(1,cell_size);
optBPR_totalEff_cell = cell(1,cell_size);
optPiF_thermalEff_cell = cell(1,cell_size);
optPiF_propEff_cell = cell(1,cell_size);
optPiF_totalEff_cell = cell(1,cell_size);
optBPR_BPR_cell = cell(1,cell_size);
optBPR_V9_cell = cell(1,cell_size);
optBPR_V19_cell = cell(1,cell_size);
optBPR_specificThrust_cell = cell(1,cell_size);
optBPR_f_cell = cell(1,cell_size);
optBPR_S_cell = cell(1,cell_size);
optBPR_FR_cell = cell(1,cell_size);
optPiF_tauF_cell = cell(1,cell_size);
optPiF_piF_cell = cell(1,cell_size);
optPiF_V9_cell = cell(1,cell_size);
optPiF_V19_cell = cell(1,cell_size);
optPiF_specificThrust_cell = cell(1,cell_size);
optPiF_f_cell = cell(1,cell_size);
optPiF_S_cell = cell(1,cell_size);
optPiF_FR_cell = cell(1,cell_size);
thermalEff_cell = cell(1,cell_size);
propEff_cell = cell(1,cell_size);
totalEff_cell = cell(1,cell_size);
a0_cell = cell(1,cell_size);
V0_cell = cell(1,cell_size);
V9_cell = cell(1,cell_size);
V19_cell = cell(1,cell_size);
mach9_cell = cell(1,cell_size);
mach19_cell = cell(1,cell_size);
specificThrust_cell = cell(1,cell_size);
f_cell = cell(1,cell_size);
S_cell = cell(1,cell_size);
thrustRatio_cell = cell(1,cell_size);

%% Parametric analysis
% Auxiliar parameter
gammaRatio = (gamma-1)/gamma;

for k = 1:cell_size
    % Mach and piC/piF independent parameters
    if (flightRegimeType == FlightRegimeInputType.Temperature)
        R = gammaRatio*cp;
        T0 = flightRegimeValue(k);
        a0 = sqrt(gamma*R*T0);
    else
        [ T0, ~, ~, a0 ] = USStandardAtmosphere( flightRegimeValue(k) );
    end
    tauLambda = Tt4/T0;
    optBPR_FR = 0.5;
    optPiF_FR = 1;
    
    
    if (piCLen == 1 && piFLen >= 1)
        % Mach and piF dependent and piC independent parameters
        tauC = piC ^ gammaRatio;
        
        for j = 1:piFLen
            tauF(j) = piF(j)^gammaRatio;
            
            for i = 1:machLen
                
                V0(j,i) = a0*mach(i);
                
                tauR(j,i) = 1 + 0.5*(gamma-1)*mach(i)^2;
                tauT(j,i) = 1 - tauR(j,i)*(tauC - 1 + BPR*(tauF(j) - 1))/tauLambda;
                
                V9a0(j,i) = sqrt(2*(tauLambda - tauR(j,i)*(tauC - 1 + BPR*(tauF(j)-1)) - ...
                    tauLambda/(tauR(j,i)*tauC))/(gamma-1));
                V19a0(j,i) = sqrt(2*(tauR(j,i)*tauF(j) - 1)/(gamma-1));
                V9(j,i) = V9a0(j,i)*a0;
                V19(j,i) = V19a0(j,i)*a0;
                
                mach9(j,i) = sqrt(2*(tauR(j,i)*tauC*tauT(i) - 1)/(gamma-1));
                mach19(j,i) = V19a0(j,i);
                
                specificThrust(j,i) = a0*(V9a0(j,i) - mach(i) + ...
                    BPR*(V19a0(j,i) - mach(i)))/(1+BPR);
                f(j,i) = cp*T0*(tauLambda - tauR(j,i)*tauC)/hpr;
                S(j,i) = f(j,i)/((1+BPR)*specificThrust(j,i));
                
                thermalEff(j,i) = 1 - 1/(tauR(j,i)*tauC);
                propEff(j,i) = 2*mach(i)*(V9a0(j,i) - mach(i) + BPR*(V19a0(j,i) - mach(i)))/...
                    (V9a0(j,i)^2 - mach(i)^2 + BPR*(V19a0(j,i)^2 - mach(i)^2));
                totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
                
                thrustRatio(j,i) = (V9a0(j,i) - mach(i))/(V19a0(j,i) - mach(i));
                
                % Optimum parameter values for optimum bypass ratio
                optBPR_BPR(j,i) = (tauLambda - tauR(j,i)*(tauC-1) - ...
                    tauLambda/(tauR(j,i)*tauC) - 0.25*(sqrt(tauR(j,i)*tauF(j) - 1) + ...
                    sqrt(tauR(j,i) - 1))^2 )/(tauR(j,i)*(tauF(j)-1));
                optBPR_V9a0(j,i) = sqrt(2*(tauLambda - tauR(j,i)*(tauC - 1 + optBPR_BPR(j,i)*(tauF(j)-1)) - ...
                    tauLambda/(tauR(j,i)*tauC))/(gamma-1));
                optBPR_V9(j,i) = optBPR_V9a0(j,i)*a0;
                optBPR_V19(j,i) = V19(j,i);
                optBPR_specificThrust(j,i) = a0*(1 + 2*optBPR_BPR(j,i))*(V19a0(j,i) - ...
                    mach(i))/(2*(1 + optBPR_BPR(j,i)));
                optBPR_f(j,i) = f(j,i);
                optBPR_S(j,i) = optBPR_f(j,i)/((1 + optBPR_BPR(j,i))*optBPR_specificThrust(j,i));
                optBPR_propEff(j,i) = 4*(1 + 2*optBPR_BPR(j,i))*mach(i)/((3 + ...
                    4*optBPR_BPR(j,i))*mach(i) + (1 + 4*optBPR_BPR(j,i))*V19a0(j,i));
                optBPR_totalEff(j,i) = thermalEff(j,i)*optBPR_propEff(j,i);
                
                % Optimum parameter values for optimum fan pressure ratio
                optPiF_tauF(j,i) = (tauLambda - tauR(j,i)*(tauC - 1) - tauLambda/...
                    (tauR(j,i)*tauC) + BPR*tauR(j,i) + 1)/( tauR(j,i)*(1+BPR));
                optPiF_piF(j,i) = optPiF_tauF(j,i) ^ (1/gammaRatio);
                optPiF_V9a0(j,i) = sqrt(2*(tauLambda - tauR(j,i)*(tauC - 1 + BPR*(optPiF_tauF(j,i)-1)) - ...
                    tauLambda/(tauR(j,i)*tauC))/(gamma-1));
                optPiF_V9(j,i) = optPiF_V9a0(j,i)*a0;
                optPiF_V19a0(j,i) = sqrt(2*(tauR(j,i)*optPiF_tauF(j,i) - 1)/(gamma-1));
                optPiF_V19(j,i) = optPiF_V19a0(j,i)*a0;
                optPiF_specificThrust(j,i) = a0*(optPiF_V19a0(j,i) - mach(i) );
                optPiF_f(j,i) = f(j,i);
                optPiF_S(j,i) = optPiF_f(i)/((1 + BPR)*optPiF_specificThrust(j,i));
                optPiF_propEff(j,i) = 2*mach(i)/(optPiF_V19a0(j,i) + mach(i));
                optPiF_totalEff(j,i) = thermalEff(j,i)*optPiF_propEff(j,i);
                
            end
        end
    elseif (piCLen >= 1 && piFLen == 1)
        % Mach and piC dependent and piF independent parameters
        tauF = piF^gammaRatio;
        
        for j = 1:piCLen
            tauC(j) = piC(j)^gammaRatio;
            
            for i = 1:machLen
                
                V0(j,i) = a0*mach(i);
                
                tauR(j,i) = 1 + 0.5*(gamma-1)*mach(i)^2;
                tauT(j,i) = 1 - tauR(j,i)*(tauC(j) - 1 + BPR*(tauF - 1))/tauLambda;
                
                V9a0(j,i) = sqrt(2*(tauLambda - tauR(j,i)*(tauC(j) - 1 + BPR*(tauF-1)) - ...
                    tauLambda/(tauR(j,i)*tauC(j)))/(gamma-1));
                V19a0(j,i) = sqrt(2*(tauR(j,i)*tauF - 1)/(gamma-1));
                V9(j,i) = V9a0(j,i)*a0;
                V19(j,i) = V19a0(j,i)*a0;
                
                mach9(j,i) = sqrt(2*(tauR(j,i)*tauC(j)*tauT(i) - 1)/(gamma-1));
                mach19(j,i) = V19a0(j,i);
                
                specificThrust(j,i) = a0*(V9a0(j,i) - mach(i) + ...
                    BPR*(V19a0(j,i) - mach(i)))/(1+BPR);
                f(j,i) = cp*T0*(tauLambda - tauR(j,i)*tauC(j))/hpr;
                S(j,i) = f(j,i)/((1+BPR)*specificThrust(j,i));
                
                thermalEff(j,i) = 1 - 1/(tauR(j,i)*tauC(j));
                propEff(j,i) = 2*mach(i)*(V9a0(j,i) - mach(i) + BPR*(V19a0(j,i) - mach(i)))/...
                    (V9a0(j,i)^2 - mach(i)^2 + BPR*(V19a0(j,i)^2 - mach(i)^2));
                totalEff(j,i) = thermalEff(j,i)*propEff(j,i);
                
                thrustRatio(j,i) = (V9a0(j,i) - mach(i))/(V19a0(j,i) - mach(i));
                
                % Optimum parameter values for optimum bypass ratio
                optBPR_BPR(j,i) = (tauLambda - tauR(j,i)*(tauC(j)-1) - ...
                    tauLambda/(tauR(j,i)*tauC(j)) - 0.25*(sqrt(tauR(j,i)*tauF - 1) + ...
                    sqrt(tauR(j,i) - 1))^2 )/(tauR(j,i)*(tauF-1));
                optBPR_V9a0(j,i) = sqrt(2*(tauLambda - tauR(j,i)*(tauC(j) - 1 + optBPR_BPR(j,i)*(tauF-1)) - ...
                    tauLambda/(tauR(j,i)*tauC(j)))/(gamma-1));
                optBPR_V9(j,i) = optBPR_V9a0(j,i)*a0;
                optBPR_V19(j,i) = V19(j,i);
                optBPR_specificThrust(j,i) = a0*(1 + 2*optBPR_BPR(j,i))*(V19a0(j,i) - ...
                    mach(i))/(2*(1 + optBPR_BPR(j,i)));
                optBPR_f(j,i) = f(j,i);
                optBPR_S(j,i) = optBPR_f(j,i)/((1 + optBPR_BPR(j,i))*optBPR_specificThrust(j,i));
                optBPR_propEff(j,i) = 4*(1 + 2*optBPR_BPR(j,i))*mach(i)/((3 + ...
                    4*optBPR_BPR(j,i))*mach(i) + (1 + 4*optBPR_BPR(j,i))*V19a0(j,i));
                optBPR_totalEff(j,i) = thermalEff(j,i)*optBPR_propEff(j,i);
                
                % Optimum parameter values for optimum fan pressure ratio
                optPiF_tauF(j,i) = (tauLambda - tauR(j,i)*(tauC(j) - 1) - tauLambda/...
                    (tauR(j,i)*tauC(j)) + BPR*tauR(j,i) + 1)/( tauR(j,i)*(1+BPR));
                optPiF_piF(j,i) = optPiF_tauF(j,i) ^ (1/gammaRatio);
                optPiF_V9a0(j,i) = sqrt(2*(tauLambda - tauR(j,i)*(tauC(j) - 1 + BPR*(optPiF_tauF(j,i)-1)) - ...
                    tauLambda/(tauR(j,i)*tauC(j)))/(gamma-1));
                optPiF_V9(j,i) = optPiF_V9a0(j,i)*a0;
                optPiF_V19a0(j,i) = sqrt(2*(tauR(j,i)*optPiF_tauF(j,i) - 1)/(gamma-1));
                optPiF_V19(j,i) = optPiF_V19a0(j,i)*a0;
                optPiF_specificThrust(j,i) = a0*(optPiF_V19a0(j,i) - mach(i) );
                optPiF_f(j,i) = f(j,i);
                optPiF_S(j,i) = optPiF_f(i)/((1 + BPR)*optPiF_specificThrust(j,i));
                optPiF_propEff(j,i) = 2*mach(i)/(optPiF_V19a0(j,i) + mach(i));
                optPiF_totalEff(j,i) = thermalEff(j,i)*optPiF_propEff(j,i);
            end
        end
    elseif (piCLen > 1 && piFLen > 1)
        error("idealTurbofan:lengthOfPressureRatio", "Either piC or piF must have a single value")
    end
    
    optBPR_thermalEff_cell{k} = thermalEff;
    optBPR_propEff_cell{k} = optBPR_propEff;
    optBPR_totalEff_cell{k} = optBPR_totalEff;
    
    optPiF_thermalEff_cell{k} = thermalEff;
    optPiF_propEff_cell{k} = optPiF_propEff;
    optPiF_totalEff_cell{k} = optPiF_totalEff;
    
    optBPR_BPR_cell{k} = optBPR_BPR;
    optBPR_V9_cell{k} = optBPR_V9;
    optBPR_V19_cell{k} = optBPR_V19;
    optBPR_specificThrust_cell{k} = optBPR_specificThrust;
    optBPR_f_cell{k} = optBPR_f;
    optBPR_S_cell{k} = optBPR_S;
    optBPR_FR_cell{k} = optBPR_FR;
    
    
    optPiF_tauF_cell{k} = optPiF_tauF;
    optPiF_piF_cell{k} = optPiF_piF;
    optPiF_V9_cell{k} = optPiF_V9;
    optPiF_V19_cell{k} = optPiF_V19;
    optPiF_specificThrust_cell{k} = optPiF_specificThrust;
    optPiF_f_cell{k} = optPiF_f;
    optPiF_S_cell{k} = optPiF_S;
    optPiF_FR_cell{k} = optPiF_FR;
    
    thermalEff_cell{k} = thermalEff;
    propEff_cell{k} = propEff;
    totalEff_cell{k} = totalEff;
    
    a0_cell{k} = a0;
    V0_cell{k} = V0;
    V9_cell{k} = V9;
    V19_cell{k} = V19;
    mach9_cell{k} = mach9;
    mach19_cell{k} = mach19;
    specificThrust_cell{k} = specificThrust;
    f_cell{k} = f;
    S_cell{k} = S;
    thrustRatio_cell{k} = thrustRatio;
end
%% Structs assembly for function outputs

optBPR_efficiencies.thermal = optBPR_thermalEff_cell;
optBPR_efficiencies.propulsive = optBPR_propEff_cell;
optBPR_efficiencies.total = optBPR_totalEff_cell;

optPiF_efficiencies.thermal = optPiF_thermalEff_cell;
optPiF_efficiencies.propulsive = optPiF_propEff_cell;
optPiF_efficiencies.total = optPiF_totalEff_cell;

optBPR.BPR = optBPR_BPR_cell;
optBPR.exitCoreVelocity = optBPR_V9_cell;
optBPR.exitFanVelocity = optBPR_V19_cell;
optBPR.specificThrust = optBPR_specificThrust_cell;
optBPR.fuelAirRatio = optBPR_f_cell;
optBPR.specificConsumption = optBPR_S_cell;
optBPR.efficiencies = optBPR_efficiencies;
optBPR.thrustRatio = optBPR_FR_cell;

optPiF.tauF = optPiF_tauF_cell;
optPiF.piF = optPiF_piF_cell;
optPiF.exitCoreVelocity = optPiF_V9_cell;
optPiF.exitFanVelocity = optPiF_V19_cell;
optPiF.specificThrust = optPiF_specificThrust_cell;
optPiF.fuelAirRatio = optPiF_f_cell;
optPiF.specificConsumption = optPiF_S_cell;
optPiF.efficiencies = optPiF_efficiencies;
optPiF.thrustRatio = optPiF_FR_cell;

optimum.BPR = optBPR;
optimum.piF = optPiF;

efficiencies.thermal = thermalEff_cell;
efficiencies.propulsive = propEff_cell;
efficiencies.total = totalEff_cell;

turbofan.localSoundVelocity = a0_cell;
turbofan.freestreamVelocity = V0_cell;
turbofan.exitCoreVelocity = V9_cell;
turbofan.exitFanVelocity = V19_cell;
turbofan.exitCoreMach = mach9_cell;
turbofan.exitFanMach = mach19_cell;
turbofan.specificThrust = specificThrust_cell;
turbofan.fuelAirRatio = f_cell;
turbofan.specificConsumption = S_cell;
turbofan.thrustRatio = thrustRatio_cell;
turbofan.efficiencies = efficiencies;
turbofan.optimum = optimum;

end


