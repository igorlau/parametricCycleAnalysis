function UseCommonInputs(app, use)
% Function that checks for the first selected engine and disable the other
% engine common input fields
%   The function checks which tab is the first and sets the remaining tabs
%   common inputs disabled. This function is triggered when the Common Inputs
%   Checkbox is selected/unselected.

if (app.selectedEngines.IdealRamjet)
    % Get the values
    mach = app.IR_MachNumberEditField.Value;
    gammaC = app.IR_GammaCEditField.Value;
    cpC = app.IR_CpcEditField.Value;
    hpr = app.IR_HprEditField.Value;
    Tt4 = app.IR_Tt4EditField.Value;
    FR_value = app.IR_FlightRegimeEditField.Value;
    FR_label = app.IR_FlightRegimeEditFieldLabel.Text;
    TempCheckbox = app.IR_TemperatureCheckbox.Value;
    AltCheckbox = app.IR_AltitudeCheckbox.Value;
    
    % Copy the values
    CopyIdealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyIdealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyIdealTurbopropValues(app, mach, gammaC, cpC, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    
elseif (app.selectedEngines.IdealTurbojet)
    % Get the values
    mach = app.ITj_MachNumberEditField.Value;
    gammaC = app.ITj_GammaCEditField.Value;
    cpC = app.ITj_CpcEditField.Value;
    hpr = app.ITj_HprEditField.Value;
    Tt4 = app.ITj_Tt4EditField.Value;
    FR_value = app.ITj_FlightRegimeEditField.Value;
    FR_label = app.ITj_FlightRegimeEditFieldLabel.Text;
    TempCheckbox = app.ITj_TemperatureCheckbox.Value;
    AltCheckbox = app.ITj_AltitudeCheckbox.Value;
    
    % Copy the values
    CopyIdealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyIdealTurbopropValues(app, mach, gammaC, cpC, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    
elseif (app.selectedEngines.IdealTurbofan)
    % Get the values
    mach = app.ITf_MachNumberEditField.Value;
    gammaC = app.ITf_GammaCEditField.Value;
    cpC = app.ITf_CpcEditField.Value;
    hpr = app.ITf_HprEditField.Value;
    Tt4 = app.ITf_Tt4EditField.Value;
    FR_value = app.ITf_FlightRegimeEditField.Value;
    FR_label = app.ITf_FlightRegimeEditFieldLabel.Text;
    TempCheckbox = app.ITf_TemperatureCheckbox.Value;
    AltCheckbox = app.ITf_AltitudeCheckbox.Value;
    
    % Copy the values
    CopyIdealTurbopropValues(app, mach, gammaC, cpC, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    
elseif (app.selectedEngines.IdealTurboprop)
    % Get the values
    mach = app.ITp_MachNumberEditField.Value;
    gammaC = app.ITp_GammaCEditField.Value;
    cpC = app.ITp_CpcEditField.Value;
    FR_value = app.ITp_FlightRegimeEditField.Value;
    FR_label = app.ITp_FlightRegimeEditFieldLabel.Text;
    TempCheckbox = app.ITp_TemperatureCheckbox.Value;
    AltCheckbox = app.ITp_AltitudeCheckbox.Value;
    
    hpr = 0;
    Tt4 = '0';
    
    % Copy the values
    CopyRealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    CopyRealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    
elseif (app.selectedEngines.RealTurbojet)
    % Get the values
    mach = app.RTj_MachNumberEditField.Value;
    gammaC = app.RTj_GammaCEditField.Value;
    cpC = app.RTj_CpcEditField.Value;
    hpr = app.RTj_HprEditField.Value;
    Tt4 = app.RTj_Tt4EditField.Value;
    FR_value = app.RTj_FlightRegimeEditField.Value;
    FR_label = app.RTj_FlightRegimeEditFieldLabel.Text;
    TempCheckbox = app.RTj_TemperatureCheckbox.Value;
    AltCheckbox = app.RTj_AltitudeCheckbox.Value;
    
    % Copy the values
    CopyRealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox);
    
else
    return;
end


if (use)
    % Ideal Ramjet Fields
    app.IR_MachNumberEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_GammaCEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_CpcEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_HprEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_Tt4EditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_FlightRegimeEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_TemperatureCheckbox.Enable = app.selectedEngines.IdealRamjet;
    app.IR_AltitudeCheckbox.Enable = app.selectedEngines.IdealRamjet;
    
    % Ideal Turbojet Fields
    ITj_Enable = ~app.selectedEngines.IdealRamjet && ...
                  app.selectedEngines.IdealTurbojet;
              
    app.ITj_MachNumberEditField.Enable = ITj_Enable;
    app.ITj_GammaCEditField.Enable = ITj_Enable;
    app.ITj_CpcEditField.Enable = ITj_Enable;
    app.ITj_HprEditField.Enable = ITj_Enable;
    app.ITj_Tt4EditField.Enable = ITj_Enable;
    app.ITj_FlightRegimeEditField.Enable = ITj_Enable;
    app.ITj_TemperatureCheckbox.Enable = ITj_Enable;
    app.ITj_AltitudeCheckbox.Enable = ITj_Enable;
    
    % Ideal Turbofan Fields
    ITf_Enable = ~app.selectedEngines.IdealRamjet && ...
                 ~app.selectedEngines.IdealTurbojet && ...
                  app.selectedEngines.IdealTurbofan;
              
    app.ITf_MachNumberEditField.Enable = ITf_Enable;
    app.ITf_GammaCEditField.Enable = ITf_Enable;
    app.ITf_CpcEditField.Enable = ITf_Enable;
    app.ITf_HprEditField.Enable = ITf_Enable;
    app.ITf_Tt4EditField.Enable = ITf_Enable;
    app.ITf_FlightRegimeEditField.Enable = ITf_Enable;
    app.ITf_TemperatureCheckbox.Enable = ITf_Enable;
    app.ITf_AltitudeCheckbox.Enable = ITf_Enable;
    
    % Ideal Turboprop Fields
    ITp_Enable = ~app.selectedEngines.IdealRamjet && ...
                 ~app.selectedEngines.IdealTurbojet && ...
                 ~app.selectedEngines.IdealTurbofan && ...
                  app.selectedEngines.IdealTurboprop;
              
    app.ITp_MachNumberEditField.Enable = ITp_Enable;
    app.ITp_GammaCEditField.Enable = ITp_Enable;
    app.ITp_CpcEditField.Enable = ITp_Enable;
    app.ITp_FlightRegimeEditField.Enable = ITp_Enable;
    app.ITp_TemperatureCheckbox.Enable = ITp_Enable;
    app.ITp_AltitudeCheckbox.Enable = ITp_Enable;
    
    % Real Turbojet Fields
    RTj_EnableWithProp = ~app.selectedEngines.IdealRamjet && ...
                         ~app.selectedEngines.IdealTurbojet && ...
                         ~app.selectedEngines.IdealTurbofan && ...
                         ~app.selectedEngines.IdealTurboprop && ...
                          app.selectedEngines.RealTurbojet;
    RTj_Enable = ~app.selectedEngines.IdealRamjet && ...
                 ~app.selectedEngines.IdealTurbojet && ...
                 ~app.selectedEngines.IdealTurbofan && ...
                  app.selectedEngines.RealTurbojet;
              
    app.RTj_MachNumberEditField.Enable = RTj_EnableWithProp;
    app.RTj_GammaCEditField.Enable = RTj_EnableWithProp;
    app.RTj_CpcEditField.Enable = RTj_EnableWithProp;
    app.RTj_HprEditField.Enable = RTj_Enable;
    app.RTj_Tt4EditField.Enable = RTj_Enable;
    app.RTj_FlightRegimeEditField.Enable = RTj_EnableWithProp;
    app.RTj_TemperatureCheckbox.Enable = RTj_EnableWithProp;
    app.RTj_AltitudeCheckbox.Enable = RTj_EnableWithProp;
    
    % Real Turbofan Fields
    RTf_EnableWithProp = ~app.selectedEngines.IdealRamjet && ...
                         ~app.selectedEngines.IdealTurbojet && ...
                         ~app.selectedEngines.IdealTurbofan && ...
                         ~app.selectedEngines.IdealTurboprop && ...
                         ~app.selectedEngines.RealTurbojet && ...
                          app.selectedEngines.RealTurbofan;
    RTf_Enable = ~app.selectedEngines.IdealRamjet && ...
                 ~app.selectedEngines.IdealTurbojet && ...
                 ~app.selectedEngines.IdealTurbofan && ...
                 ~app.selectedEngines.RealTurbojet && ...
                  app.selectedEngines.RealTurbofan;
              
    app.RTf_MachNumberEditField.Enable = RTf_EnableWithProp;
    app.RTf_GammaCEditField.Enable = RTf_EnableWithProp;
    app.RTf_CpcEditField.Enable = RTf_EnableWithProp;
    app.RTf_HprEditField.Enable = RTf_Enable;
    app.RTf_Tt4EditField.Enable = RTf_Enable;
    app.RTf_FlightRegimeEditField.Enable = RTf_EnableWithProp;
    app.RTf_TemperatureCheckbox.Enable = RTf_EnableWithProp;
    app.RTf_AltitudeCheckbox.Enable = RTf_EnableWithProp;

else
    % Ideal Ramjet Fields
    app.IR_MachNumberEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_GammaCEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_CpcEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_HprEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_Tt4EditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_FlightRegimeEditField.Enable = app.selectedEngines.IdealRamjet;
    app.IR_TemperatureCheckbox.Enable = app.selectedEngines.IdealRamjet;
    app.IR_AltitudeCheckbox.Enable = app.selectedEngines.IdealRamjet;
    
    % Ideal Turbojet Fields
    app.ITj_MachNumberEditField.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_GammaCEditField.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_CpcEditField.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_HprEditField.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_Tt4EditField.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_FlightRegimeEditField.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_TemperatureCheckbox.Enable = app.selectedEngines.IdealTurbojet;
    app.ITj_AltitudeCheckbox.Enable = app.selectedEngines.IdealTurbojet;
    
    % Ideal Turbofan Fields
    app.ITf_MachNumberEditField.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_GammaCEditField.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_CpcEditField.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_HprEditField.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_Tt4EditField.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_FlightRegimeEditField.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_TemperatureCheckbox.Enable = app.selectedEngines.IdealTurbofan;
    app.ITf_AltitudeCheckbox.Enable = app.selectedEngines.IdealTurbofan;
    
    % Ideal Turboprop Fields
    app.ITp_MachNumberEditField.Enable = app.selectedEngines.IdealTurboprop;
    app.ITp_GammaCEditField.Enable = app.selectedEngines.IdealTurboprop;
    app.ITp_CpcEditField.Enable = app.selectedEngines.IdealTurboprop;
    app.ITp_FlightRegimeEditField.Enable = app.selectedEngines.IdealTurboprop;
    app.ITp_TemperatureCheckbox.Enable = app.selectedEngines.IdealTurboprop;
    app.ITp_AltitudeCheckbox.Enable = app.selectedEngines.IdealTurboprop;
    
    % Real Turbojet Fields
    app.RTj_MachNumberEditField.Enable = app.selectedEngines.RealTurbojet;
    app.RTj_GammaCEditField.Enable = app.selectedEngines.RealTurbojet;
    app.RTj_CpcEditField.Enable = app.selectedEngines.RealTurbojet;
    app.RTj_HprEditField.Enable = app.selectedEngines.RealTurbojet;
    app.RTj_Tt4EditField.Enable = app.selectedEngines.RealTurbojet;
    app.RTj_FlightRegimeEditField.Enable = app.selectedEngines.RealTurbojet;          
    app.RTj_TemperatureCheckbox.Enable = app.selectedEngines.RealTurbojet;
    app.RTj_AltitudeCheckbox.Enable = app.selectedEngines.RealTurbojet;
    
    % Real Turbofan Fields
    app.RTf_MachNumberEditField.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_GammaCEditField.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_CpcEditField.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_HprEditField.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_Tt4EditField.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_FlightRegimeEditField.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_TemperatureCheckbox.Enable = app.selectedEngines.RealTurbofan;
    app.RTf_AltitudeCheckbox.Enable = app.selectedEngines.RealTurbofan;
end
end

function CopyIdealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox)
    app.ITj_MachNumberEditField.Value = mach;
    app.ITj_GammaCEditField.Value = gammaC;
    app.ITj_CpcEditField.Value = cpC;
    app.ITj_HprEditField.Value = hpr;
    app.ITj_Tt4EditField.Value = Tt4;
    app.ITj_FlightRegimeEditField.Value = FR_value;
    app.ITj_TemperatureCheckbox.Value = TempCheckbox;
    app.ITj_AltitudeCheckbox.Value = AltCheckbox;
    app.ITj_FlightRegimeEditFieldLabel.Text = FR_label;
end

function CopyIdealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox)
    app.ITf_MachNumberEditField.Value = mach;
    app.ITf_GammaCEditField.Value = gammaC;
    app.ITf_CpcEditField.Value = cpC;
    app.ITf_HprEditField.Value = hpr;
    app.ITf_Tt4EditField.Value = Tt4;
    app.ITf_FlightRegimeEditField.Value = FR_value;
    app.ITf_TemperatureCheckbox.Value = TempCheckbox;
    app.ITf_AltitudeCheckbox.Value = AltCheckbox;
    app.ITf_FlightRegimeEditFieldLabel.Text = FR_label;
end

function CopyIdealTurbopropValues(app, mach, gammaC, cpC, FR_value, FR_label, TempCheckbox, AltCheckbox)
    app.ITp_MachNumberEditField.Value = mach;
    app.ITp_GammaCEditField.Value = gammaC;
    app.ITp_CpcEditField.Value = cpC;
    app.ITp_FlightRegimeEditField.Value = FR_value;
    app.ITp_TemperatureCheckbox.Value = TempCheckbox;
    app.ITp_AltitudeCheckbox.Value = AltCheckbox;
    app.ITp_FlightRegimeEditFieldLabel.Text = FR_label;
end

function CopyRealTurbojetValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox)
    app.RTj_MachNumberEditField.Value = mach;
    app.RTj_GammaCEditField.Value = gammaC;
    app.RTj_CpcEditField.Value = cpC;
    app.RTj_HprEditField.Value = hpr;
    app.RTj_Tt4EditField.Value = Tt4;
    app.RTj_FlightRegimeEditField.Value = FR_value;
    app.RTj_TemperatureCheckbox.Value = TempCheckbox;
    app.RTj_AltitudeCheckbox.Value = AltCheckbox;
    app.RTj_FlightRegimeEditFieldLabel.Text = FR_label;
end

function CopyRealTurbofanValues(app, mach, gammaC, cpC, hpr, Tt4, FR_value, FR_label, TempCheckbox, AltCheckbox)
    app.RTf_MachNumberEditField.Value = mach;
    app.RTf_GammaCEditField.Value = gammaC;
    app.RTf_CpcEditField.Value = cpC;
    app.RTf_HprEditField.Value = hpr;
    app.RTf_Tt4EditField.Value = Tt4;
    app.RTf_FlightRegimeEditField.Value = FR_value;
    app.RTf_TemperatureCheckbox.Value = TempCheckbox;
    app.RTf_AltitudeCheckbox.Value = AltCheckbox;
    app.RTf_FlightRegimeEditFieldLabel.Text = FR_label;
end