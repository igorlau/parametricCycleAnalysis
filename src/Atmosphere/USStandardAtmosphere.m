function [ T, P, rho, a ] = USStandardAtmosphere( height )
% USStandardAtmosphere Calculate Tempereature, Pressure and Air density as
%                       function of height
%   INPUT:
%       - height: meters
%   OUTPUT:
%       - temperature (T): Kelvin
%       - pressure (P): pascal
%       - density (rho): kg/m^3
%
%   All units in SI

%% Constants
dTdh = -6.5*10^-3;      % [K/m]
stratoTemperature = 216.69;

%% Standard Properties
AirProps = struct('R', 287.05307, 'gamma', 1.4);

AtmosphereMSL = struct(...
    'pressure',101325, ...
    'temperature', 288.15, ...
    'density', 1.225, ...
    'viscosity', 1.78938*10^-5, ...
    'gravity', 9.80665...
    );


%% Functions
tropoTemperature = @(height) AtmosphereMSL.temperature + dTdh*height;

tropoPressure = @(height) AtmosphereMSL.pressure * (...
    (dTdh * height / AtmosphereMSL.temperature + 1)^...
    (-AtmosphereMSL.gravity / (dTdh * AirProps.R)));

tropoDensity = @(height) AtmosphereMSL.density * (...
    (dTdh * height / AtmosphereMSL.temperature + 1)^...
    (-(AtmosphereMSL.gravity / (dTdh * AirProps.R) + 1)));

stratoPressure = @(height) tropoPressure(11000) * (...
    exp(-AtmosphereMSL.gravity * (height - 11000) / ...
    (AirProps.R * tropoTemperature(11000))));

stratoDensity = @(height) tropoDensity(11000) * (...
    exp(-AtmosphereMSL.gravity * (height - 11000) / ...
    (AirProps.R*tropoTemperature(11000))));

%% Calculation
if height <= 11000
    T = tropoTemperature(height);
    P = tropoPressure(height);
    rho = tropoDensity(height);
elseif height > 11000 && height <= 25000
    T = stratoTemperature;
    P = stratoPressure(height);
    rho = stratoDensity(height);
end

a = sqrt( AirProps.gamma*AirProps.R*T );

end