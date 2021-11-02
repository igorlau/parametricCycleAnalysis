function [ P,T,rho,a ] = GetAtmUSA( H )
% ----------------------------------------------------------------------
% Rotine for USA Atmosphere
% Version 05/01/2016
% by Mautone & Gabaldo
% Te.Co.S srl
% ----------------------------------------------------------------------
% Structure Declarations
%
Air = struct('gamma', 1.4, 'R', 286.2, 'M', 29.05, 'cp', 1003.0, ...
    'Pref', 101325, 'Tref', 288.15);
%
% ----------------------------------------------------------------------
%

if ( H <= 11000 )
    % for less of 11,000 meters
    T = Air.Tref- 0.00649 * H ;
    P = (Air.Pref * (T/Air.Tref)^5.256);
elseif  ( 11000 < H ) && ( H <= 25000 )
    % between 11000 and 25000 meters
    T = -56.46+273.15 ;
    P = 22650 * exp(1.73 - 0.000157 * H) ;
else
    % above  25,000 meters
    T = (-131.21 + 0.00299 * H) + 273.16;
    P = 2488 * (T/ 216.6)^(-11.388);
end
rho = (P/(Air.R*T));
a = sqrt( Air.gamma*T*Air.R);
end