function RunIdealRamjetAnalysis(app)
% Function that runs when ideal ramjet is selected

% Get the field values
mach = app.IR_MachNumberEditField.Value;
gammaC = app.IR_GammaCEditField.Value;
cpC = app.IR_CpcEditField.Value;
hpr = app.IR_HprEditField.Value;
Tt4 = app.IR_Tt4EditField.Value;
FR_value = app.IR_FlightRegimeEditField.Value;
TempCheckbox = app.IR_TemperatureCheckbox.Value;
AltCheckbox = app.IR_AltitudeCheckbox.Value;

% Input Validation
validated_mach = ValidateInputsArray(mach, 'Mach', 'Ideal Ramjet');
validated_Tt4 = ValidateInputsArray(Tt4, 'Tt4', 'Ideal Ramjet');
validated_FR_value = ValidateInputsArray(FR_value, 'FlightRegimeValue', 'Ideal Ramjet');

% Conversion to the IS units
converted_cpC = cpC*1000;
converted_hpr = hpr*1000;

% Flight Regime Type Check
if (TempCheckbox && ~AltCheckbox)
    flightRegimeType = FlightRegimeInputType.Temperature;
elseif (~TempCheckbox && AltCheckbox)
    flightRegimeType = FlightRegimeInputType.Altitude;
else
    errordlg("Selecione um regime de voo válido", "Erro na seleção do regime de voo de Ramjet Ideal")
end

% Class assignment
idealRamjet = IdealRamjet(validated_mach,...
                          flightRegimeType,...
                          validated_FR_value,...
                          gammaC,...
                          converted_cpC,...
                          converted_hpr,...
                          validated_Tt4);

% Run Analysis
Tt4_cellArray = num2cell(validated_Tt4);


for i = 1:length(Tt4_cellArray)
    currentTt4 = strcat('T', strrep(num2str(Tt4_cellArray{i}), '.', '_'), 'K');
    [ramjet] = IdealRamjetAnalysis(validated_mach, ...
                                   flightRegimeType,...
                                   validated_FR_value,...
                                   gammaC,...
                                   converted_cpC,...
                                   converted_hpr,...
                                   validated_Tt4(i));
    idealRamjet.Outputs.(currentTt4) = ramjet;
end

app.idealRamjetEngine = idealRamjet;

end

