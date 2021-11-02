function RunIdealTurbopropAnalysis(app)
% Function that runs when ideal turbopop is selected

% Get the field values
mach = app.ITp_MachNumberEditField.Value;
gammaC = app.ITp_GammaCEditField.Value;
cpC = app.ITp_CpcEditField.Value;
FR_value = app.ITp_FlightRegimeEditField.Value;
TempCheckbox = app.ITp_TemperatureCheckbox.Value;
AltCheckbox = app.ITp_AltitudeCheckbox.Value;
advancedProp = app.ITp_ConventionalAdvancedButton.Value;

% Input Validation
validated_mach = ValidateInputsArray(mach, 'Mach', 'Ideal Turboprop');
validated_FR_value = ValidateInputsArray(FR_value, 'FlightRegimeValue', 'Ideal Turboprop');

% Conversion to the IS units
converted_cpC = cpC*1000;

% Flight Regime Type Check
if (TempCheckbox && ~AltCheckbox)
    flightRegimeType = FlightRegimeInputType.Temperature;
elseif (~TempCheckbox && AltCheckbox)
    flightRegimeType = FlightRegimeInputType.Altitude;
else
    errordlg("Selecione um regime de voo válido", "Erro na seleção do regime de voo de Turboprop Ideal")
end

% Turboprop Type Check
if (advancedProp)
    turbopropType = TurbopropInputType.Advanced;
else
    turbopropType = TurbopropInputType.Conventional;
end

% Class assignment
idealTurboprop = IdealTurboprop(validated_mach,...
    flightRegimeType,...
    validated_FR_value,...
    gammaC,...
    converted_cpC,...
    turbopropType);


[turboprop] = IdealTurbopropAnalysis(validated_mach,...
    flightRegimeType,...
    validated_FR_value,...
    gammaC,...
    converted_cpC,...
    turbopropType);

idealTurboprop.Outputs = turboprop;


app.idealTurbopropEngine = idealTurboprop;

end

