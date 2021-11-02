function RunIdealTurbofanAnalysis(app)
% Function that runs when ideal turbofan is selected

% Get the field values
mach = app.ITf_MachNumberEditField.Value;
gammaC = app.ITf_GammaCEditField.Value;
cpC = app.ITf_CpcEditField.Value;
hpr = app.ITf_HprEditField.Value;
Tt4 = app.ITf_Tt4EditField.Value;
FR_value = app.ITf_FlightRegimeEditField.Value;
TempCheckbox = app.ITf_TemperatureCheckbox.Value;
AltCheckbox = app.ITf_AltitudeCheckbox.Value;
piC = app.ITf_PicEditField.Value;
piF = app.ITf_PifEditField.Value;
BPR = app.ITf_BPREditField.Value;

% Input Validation
validated_mach = ValidateInputsArray(mach, 'Mach', 'Ideal Turbofan');
validated_Tt4 = ValidateInputsArray(Tt4, 'Tt4', 'Ideal Turbofan');
validated_FR_value = ValidateInputsArray(FR_value, 'FlightRegimeValue', 'Ideal Turbofan');

% Conversion to the IS units
converted_cpC = cpC*1000;
converted_hpr = hpr*1000;

% Flight Regime Type Check
if (TempCheckbox && ~AltCheckbox)
    flightRegimeType = FlightRegimeInputType.Temperature;
elseif (~TempCheckbox && AltCheckbox)
    flightRegimeType = FlightRegimeInputType.Altitude;
else
    errordlg("Selecione um regime de voo válido", "Erro na seleção do regime de voo de Turbofan Ideal")
end

% Class assignment


idealTurbofan = IdealTurbofan(validated_mach,...
    flightRegimeType,...
    validated_FR_value,...
    gammaC,...
    converted_cpC,...
    converted_hpr,...
    validated_Tt4,...
    piC,...
    piF,...
    BPR);

% Run Analysis
Tt4_cellArray = num2cell(validated_Tt4);


for i = 1:length(Tt4_cellArray)
    currentTt4 = strcat('T', strrep(num2str(Tt4_cellArray{i}), '.', '_'), 'K');
    [turbofan] = IdealTurbofanAnalysis(validated_mach, ...
        flightRegimeType,...
        validated_FR_value,...
        gammaC,...
        converted_cpC,...
        converted_hpr,...
        validated_Tt4(i),...
        piC,...
        piF,...
        BPR);
    idealTurbofan.Outputs.(currentTt4) = turbofan;
end

app.idealTurbofanEngine = idealTurbofan;

end

