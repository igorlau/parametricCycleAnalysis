function [turboprop] = IdealTurbopropAnalysis(mach, flightRegimeType, flightRegimeValue, gamma, cp, type)
% Parametric on-design cycle  analysis of ideal RAMJET engine
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
%       - type: enumerable for conventional(0) or advanced(1) turboprop
%   OUTPUT:
%       - localSoundVelocity: local sound velocity [m/s]
%       - freestreamVelocity: freestream velocity [m/s]
%       - specificThrust: specific thrust [N/(kg/s)]
%       - specificConsumption: specific fuel consumption [kg/(N s)]
%       - efficiencies: struct with engine efficiencies
%           -- propulsive: propulsive efficiency [-]
%
%   REFERENCE: These equations were obtained based on polynomial
%   fitting of known turboprop engine data
%
%   AUTHOR: Igor Lau - Jul 2021

%% Check for turboprop type
if(type == TurbopropInputType.Advanced)
    advanced = true;
else
    advanced = false;
end

%% Variable allocation
tam = length(mach);
cell_size = length(flightRegimeValue);

propEff = NaN(1,tam);
S = NaN(1,tam);
specificThrust = NaN(1,tam);
V0 = NaN(1,tam);

propEff_cell = cell(1,cell_size);
a0_cell = cell(1,cell_size);
V0_cell = cell(1,cell_size);
specificThrust_cell = cell(1,cell_size);
S_cell = cell(1,cell_size);

%% Parametric analysis

for k = 1:cell_size
    % Mach independent parameters
    if (flightRegimeType == FlightRegimeInputType.Temperature)
        R = (gamma-1)*cp/gamma;
        T0 = flightRegimeValue(k);
        a0 = sqrt(gamma*R*T0);
    else
        [ ~, ~, ~, a0 ] = USStandardAtmosphere( flightRegimeValue(k) );
    end
    
    % Mach dependent parameters
    for i = 1:tam
        
        V0(i) = a0*mach(i);
        
        if(~advanced)
            
            % Conventional turboprop
            if (mach(i) >= 0 && mach(i) <= 0.251)
                specificThrust(i) = -1139495.3746*mach(i)^6 + ...
                    818221.6923*mach(i)^5 - 222880.1806*mach(i)^4 + ...
                    28626.2409*mach(i)^3 - 1796.3389*mach(i)^2 + ...
                    72.4467*mach(i) + 73.1778;
            elseif (mach(i) > 0.251 && mach(i) <= 0.640)
                specificThrust(i) = 4005063.5123*mach(i)^8 - ...
                    14795384.9052*mach(i)^7 + 23589817.6461*mach(i)^6 - ...
                    21206570.9772*mach(i)^5 + 11756252.3237*mach(i)^4 - ...
                    4114460.72*mach(i)^3 + 887169.9677*mach(i)^2 - ...
                    107723.6948*mach(i) + 5717.2022;
            elseif mach(i) > 0.640
                specificThrust(i) = 0;
            end
            
            if (mach(i) >= 0 && mach(i) <= 0.571)
                S(i) = -0.0000653571*mach(i)^4 + 0.0000560203*mach(i)^3 + ...
                    2.4780708246602e-6*mach(i)^2 + 2.1932697879304e-6*mach(i) + ...
                    4.499999999999e-6;
            elseif (mach(i) > 0.571 && mach(i) <= 0.640)
                S(i) = - 0.000228108*mach(i)^3 + 0.000579156*mach(i)^2 - ...
                    0.000420689*mach(i) + 0.000103844;
            elseif mach(i) > 0.640
                S(i) = 0;
            end
            
            if (mach(i) >= 0 && mach(i) <= 0.477)
                propEff(i) = - 4.08531e4*mach(i)^9 + 1.08612e5*mach(i)^8 - ...
                    1.17604e5*mach(i)^7 + 6.71093e4*mach(i)^6 - ...
                    2.16155e4*mach(i)^5 + 3842.42*mach(i)^4 - 322.193*mach(i)^3 - ...
                    0.27872*mach(i)^2 + 4.455*mach(i);
            elseif (mach(i) > 0.477 && mach(i) <= 0.857)
                propEff(i) = - 41.5844*mach(i)^6 + 91.7373*mach(i)^5 - ...
                    29.7932*mach(i)^4 - 78.6025*mach(i)^3 + 85.6678*mach(i)^2 - ...
                    33.0095*mach(i) + 5.36627;
            end
        else
            
            % Advanced turboprop
            if (mach(i) >= 0 && mach(i) <= 0.251)
                specificThrust(i) = -1139495.3746*mach(i)^6 + ...
                    818221.6923*mach(i)^5 - 222880.1806*mach(i)^4 + ...
                    28626.2409*mach(i)^3 - 1796.3389*mach(i)^2 + ...
                    72.4467*mach(i) + 73.1778;
            elseif (mach(i) > 0.251 && mach(i) <= 0.552)
                specificThrust(i) = 456042*mach(i)^6 - 1.08057e6*mach(i)^5 + ...
                    1.0504e6*mach(i)^4 - 536276*mach(i)^3 + 151633*mach(i)^2 - ...
                    22540.5*mach(i) + 1454.61;
            elseif (mach(i) > 0.552 && mach(i) <= 0.703)
                specificThrust(i) = - 1298.8464*mach(i)^3 + 2186.5033*mach(i)^2 - ...
                    1307.0165*mach(i) + 335.5653;
            elseif (mach(i) > 0.703 && mach(i) <= 0.854)
                specificThrust(i) = - 90616.1485*mach(i)^4 + ...
                    283187.5309*mach(i)^3 - 331593.0744*mach(i)^2 + ...
                    172206.4965*mach(i) - 33394.0806;
            end
            
            
            if (mach(i) > 0.571 && mach(i) <= 0.857)
                S(i) = 0.00448021*mach(i)^4 - 0.0122065*mach(i)^3 + ...
                    0.0124425*mach(i)^2 - 0.00560261*mach(i) + 0.000948534;
            elseif (mach(i) < 0.571)
                S(i) = -0.0000653571*mach(i)^4 + 0.0000560203*mach(i)^3 + ...
                    2.4780708246602e-6*mach(i)^2 + 2.1932697879304e-6*mach(i) + ...
                    4.499999999999e-6;
            end
            
            if (mach(i) >= 0 && mach(i) <= 0.477)
                propEff(i) = - 4.08531e4*mach(i)^9 + 1.08612e5*mach(i)^8 - ...
                    1.17604e5*mach(i)^7 + 6.71093e4*mach(i)^6 - ...
                    2.16155e4*mach(i)^5 + 3842.42*mach(i)^4 - 322.193*mach(i)^3 -...
                    0.27872*mach(i)^2 + 4.455*mach(i);
            elseif (mach(i) > 0.477 && mach(i) <= 0.857)
                propEff(i) = - 41.5844*mach(i)^6 + 91.7373*mach(i)^5 - ...
                    29.7932*mach(i)^4 - 78.6025*mach(i)^3 + 85.6678*mach(i)^2 - ...
                    33.0095*mach(i) + 5.36627;
            end
        end
    end
    
    propEff_cell{k} = propEff;
    a0_cell{k} = a0;
    V0_cell{k} = V0;
    specificThrust_cell{k} = specificThrust;
    S_cell{k} = S;
end

%% Structs assembly for function outputs
efficiencies.propulsive = propEff_cell;

turboprop.localSoundVelocity = a0_cell;
turboprop.freestreamVelocity = V0_cell;
turboprop.specificThrust = specificThrust_cell;
turboprop.specificConsumption = S_cell;
turboprop.efficiencies = efficiencies;

end
