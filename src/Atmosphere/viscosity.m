%% Viscosity
muRef = 1.827*10^-5;
TRef = 291.15;
C = 120;
mu = muRef*((T0 + C)*(T/TRef)^1.5)/(T+C);