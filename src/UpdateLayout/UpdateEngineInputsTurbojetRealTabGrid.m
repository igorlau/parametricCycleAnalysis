function UpdateEngineInputsTurbojetRealTabGrid(app, appColumns)
% Change the Real Turbojet Tab grid size and the field displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size
if (appColumns == 1)
    % Set a 7x9 grid on the tab
    app.TurbojetRealTabGrid.RowHeight = repmat({'1x'},1,7);
    app.TurbojetRealTabGrid.ColumnWidth = repmat({'1x'},1,9);
    
    % c_pt field positioning
    app.RTj_CptEditFieldLabel.Layout.Row = 1;
    app.RTj_CptEditFieldLabel.Layout.Column = 4;
    app.RTj_CptEditField.Layout.Row = 1;
    app.RTj_CptEditField.Layout.Column = 5;
    
    % P0/P9 field positioning
    app.RTj_P0P9EditFieldLabel.Layout.Row = 2;
    app.RTj_P0P9EditFieldLabel.Layout.Column = 4;
    app.RTj_P0P9EditField.Layout.Row = 2;
    app.RTj_P0P9EditField.Layout.Column = 5;
    
    % pi_C field positioning
    app.RTj_PicEditFieldLabel.Layout.Row = 3;
    app.RTj_PicEditFieldLabel.Layout.Column = 4;
    app.RTj_PicEditField.Layout.Row = 3;
    app.RTj_PicEditField.Layout.Column = 5;
    
    % pi_Dmax field positioning
    app.RTj_PidmaxEditFieldLabel.Layout.Row = 4;
    app.RTj_PidmaxEditFieldLabel.Layout.Column = 4;
    app.RTj_PidmaxEditField.Layout.Row = 4;
    app.RTj_PidmaxEditField.Layout.Column = 5;
    
    % pi_B field positioning
    app.RTj_PibEditFieldLabel.Layout.Row = 5;
    app.RTj_PibEditFieldLabel.Layout.Column = 4;
    app.RTj_PibEditField.Layout.Row = 5;
    app.RTj_PibEditField.Layout.Column = 5;
    
    % pi_N field positioning
    app.RTj_PinEditFieldLabel.Layout.Row = 6;
    app.RTj_PinEditFieldLabel.Layout.Column = 4;
    app.RTj_PinEditField.Layout.Row = 6;
    app.RTj_PinEditField.Layout.Column = 5;
    
    % e_C field positioning
    app.RTj_EcEditFieldLabel.Layout.Row = 7;
    app.RTj_EcEditFieldLabel.Layout.Column = 4;
    app.RTj_EcEditField.Layout.Row = 7;
    app.RTj_EcEditField.Layout.Column = 5;
    
    % e_T field positioning
    app.RTj_EtEditFieldLabel.Layout.Row = 1;
    app.RTj_EtEditFieldLabel.Layout.Column = 6;
    app.RTj_EtEditField.Layout.Row = 1;
    app.RTj_EtEditField.Layout.Column = 7;
    
    % eta_B field positioning
    app.RTj_EtabEditFieldLabel.Layout.Row = 2;
    app.RTj_EtabEditFieldLabel.Layout.Column = 6;
    app.RTj_EtabEditField.Layout.Row = 2;
    app.RTj_EtabEditField.Layout.Column = 7;
    
    % eta_M field positioning
    app.RTj_EtamEditFieldLabel.Layout.Row = 3;
    app.RTj_EtamEditFieldLabel.Layout.Column = 6;
    app.RTj_EtamEditField.Layout.Row = 3;
    app.RTj_EtamEditField.Layout.Column = 7;
    
    % Afterburner panel positioning
    app.RTj_AfterburnerPanel.Layout.Row = [1 7];
    app.RTj_AfterburnerPanel.Layout.Column = [8 9];
    
    % Afterbuner Panel Grid sizing
    app.RTj_AfterburnerPanelGrid.RowHeight = repmat({'1x'},1,6);
    app.RTj_AfterburnerPanelGrid.ColumnWidth = repmat({'1x'},1,2);
    
    % c_pAB field (inside app.RTj_AfterburnerPanelGrid)
    app.RTj_CpabEditFieldLabel.Layout.Row = 4;
    app.RTj_CpabEditFieldLabel.Layout.Column = 1;
    app.RTj_CpabEditField.Layout.Row = 4;
    app.RTj_CpabEditField.Layout.Column = 2;
    
    % pi_AB field (inside app.RTj_AfterburnerPanelGrid)
    app.RTj_PiabEditFieldLabel.Layout.Row = 5;
    app.RTj_PiabEditFieldLabel.Layout.Column = 1;
    app.RTj_PiabEditField.Layout.Row = 5;
    app.RTj_PiabEditField.Layout.Column = 2;
    
    % eta_AB field (inside app.RTj_AfterburnerPanelGrid)
    app.RTj_EtaabEditFieldLabel.Layout.Row = 6;
    app.RTj_EtaabEditFieldLabel.Layout.Column = 1;
    app.RTj_EtaabEditField.Layout.Row = 6;
    app.RTj_EtaabEditField.Layout.Column = 2;
    
elseif (appColumns == 2 || appColumns ==3)
    if (appColumns == 2)
        % Set a 20x5 grid on the tab
        app.TurbojetRealTabGrid.RowHeight = repmat({'1x'},1,20);
        app.TurbojetRealTabGrid.ColumnWidth = repmat({'1x'},1,5);
        
        % Afterburner panel positioning
        app.RTj_AfterburnerPanel.Layout.Row = [11 14];
        app.RTj_AfterburnerPanel.Layout.Column = [1 5];
        
    else
        % Set a 15x5 grid on the tab
        app.TurbojetRealTabGrid.RowHeight = repmat({'1x'},1,15);
        app.TurbojetRealTabGrid.ColumnWidth = repmat({'1x'},1,5);
        
        % Afterburner panel positioning
        app.RTj_AfterburnerPanel.Layout.Row = [12 15];
        app.RTj_AfterburnerPanel.Layout.Column = [1 5];
    end
    
    % c_pt field positioning
    app.RTj_CptEditFieldLabel.Layout.Row = 8;
    app.RTj_CptEditFieldLabel.Layout.Column = 1;
    app.RTj_CptEditField.Layout.Row = 8;
    app.RTj_CptEditField.Layout.Column = 2;
    
    % P0/P9 field positioning
    app.RTj_P0P9EditFieldLabel.Layout.Row = 9;
    app.RTj_P0P9EditFieldLabel.Layout.Column = 1;
    app.RTj_P0P9EditField.Layout.Row = 9;
    app.RTj_P0P9EditField.Layout.Column = 2;
    
    % pi_C field positioning
    app.RTj_PicEditFieldLabel.Layout.Row = 10;
    app.RTj_PicEditFieldLabel.Layout.Column = 1;
    app.RTj_PicEditField.Layout.Row = 10;
    app.RTj_PicEditField.Layout.Column = 2;
    
    % pi_Dmax field positioning
    app.RTj_PidmaxEditFieldLabel.Layout.Row = 1;
    app.RTj_PidmaxEditFieldLabel.Layout.Column = 4;
    app.RTj_PidmaxEditField.Layout.Row = 1;
    app.RTj_PidmaxEditField.Layout.Column = 5;
    
    % pi_B field positioning
    app.RTj_PibEditFieldLabel.Layout.Row = 2;
    app.RTj_PibEditFieldLabel.Layout.Column = 4;
    app.RTj_PibEditField.Layout.Row = 2;
    app.RTj_PibEditField.Layout.Column = 5;
    % pi_N field positioning
    app.RTj_PinEditFieldLabel.Layout.Row = 3;
    app.RTj_PinEditFieldLabel.Layout.Column = 4;
    app.RTj_PinEditField.Layout.Row = 3;
    app.RTj_PinEditField.Layout.Column = 5;
    
    % e_C field positioning
    app.RTj_EcEditFieldLabel.Layout.Row = 4;
    app.RTj_EcEditFieldLabel.Layout.Column = 4;
    app.RTj_EcEditField.Layout.Row = 4;
    app.RTj_EcEditField.Layout.Column = 5;
    
    % e_T field positioning
    app.RTj_EtEditFieldLabel.Layout.Row = 5;
    app.RTj_EtEditFieldLabel.Layout.Column = 4;
    app.RTj_EtEditField.Layout.Row = 5;
    app.RTj_EtEditField.Layout.Column = 5;
    
    % eta_B field positioning
    app.RTj_EtabEditFieldLabel.Layout.Row = 6;
    app.RTj_EtabEditFieldLabel.Layout.Column = 4;
    app.RTj_EtabEditField.Layout.Row = 6;
    app.RTj_EtabEditField.Layout.Column = 5;
    
    % eta_M field positioning
    app.RTj_EtamEditFieldLabel.Layout.Row = 7;
    app.RTj_EtamEditFieldLabel.Layout.Column = 4;
    app.RTj_EtamEditField.Layout.Row = 7;
    app.RTj_EtamEditField.Layout.Column = 5;
    
    % Afterbuner Panel Grid sizing
    app.RTj_AfterburnerPanelGrid.RowHeight = repmat({'1x'},1,3);
    app.RTj_AfterburnerPanelGrid.ColumnWidth = repmat({'1x'},1,4);
    
    % c_pAB field (inside app.RTj_AfterburnerPanelGrid)
    app.RTj_CpabEditFieldLabel.Layout.Row = 1;
    app.RTj_CpabEditFieldLabel.Layout.Column = 3;
    app.RTj_CpabEditField.Layout.Row = 1;
    app.RTj_CpabEditField.Layout.Column = 4;
    
    % pi_AB field (inside app.RTj_AfterburnerPanelGrid)
    app.RTj_PiabEditFieldLabel.Layout.Row = 2;
    app.RTj_PiabEditFieldLabel.Layout.Column = 3;
    app.RTj_PiabEditField.Layout.Row = 2;
    app.RTj_PiabEditField.Layout.Column = 4;
    
    % eta_AB field (inside app.RTj_AfterburnerPanelGrid)
    app.RTj_EtaabEditFieldLabel.Layout.Row = 3;
    app.RTj_EtaabEditFieldLabel.Layout.Column = 3;
    app.RTj_EtaabEditField.Layout.Row = 3;
    app.RTj_EtaabEditField.Layout.Column = 4;
end

%% Common input fields displacement
% Mach number field
app.RTj_MachNumberEditFieldLabel.Layout.Row = 1;
app.RTj_MachNumberEditFieldLabel.Layout.Column = 1;
app.RTj_MachNumberEditField.Layout.Row = 1;
app.RTj_MachNumberEditField.Layout.Column = 2;

% gamma_C field
app.RTj_GammaCEditFieldLabel.Layout.Row = 2;
app.RTj_GammaCEditFieldLabel.Layout.Column = 1;
app.RTj_GammaCEditField.Layout.Row = 2;
app.RTj_GammaCEditField.Layout.Column = 2;

% c_pc field
app.RTj_CpcEditFieldLabel.Layout.Row = 3;
app.RTj_CpcEditFieldLabel.Layout.Column = 1;
app.RTj_CpcEditField.Layout.Row = 3;
app.RTj_CpcEditField.Layout.Column = 2;

% h_pr field
app.RTj_HprEditFieldLabel.Layout.Row = 4;
app.RTj_HprEditFieldLabel.Layout.Column = 1;
app.RTj_HprEditField.Layout.Row = 4;
app.RTj_HprEditField.Layout.Column = 2;

% T_t4 field
app.RTj_Tt4EditFieldLabel.Layout.Row = 5;
app.RTj_Tt4EditFieldLabel.Layout.Column = 1;
app.RTj_Tt4EditField.Layout.Row = 5;
app.RTj_Tt4EditField.Layout.Column = 2;

% Flight regime field
app.RTj_FlightRegimeEditFieldLabel.Layout.Row = 6;
app.RTj_FlightRegimeEditFieldLabel.Layout.Column = 1;
app.RTj_FlightRegimeEditField.Layout.Row = 6;
app.RTj_FlightRegimeEditField.Layout.Column = 2;

% Flight regime checkbox grid positioning
app.RTj_FlightRegimeGridCheckbox.Layout.Row = 6;
app.RTj_FlightRegimeGridCheckbox.Layout.Column = 3;

% Flight regime checkboxes (inside app.RTj_FlightRegimeGridCheckbox)
app.RTj_TemperatureCheckbox.Layout.Row = 1;
app.RTj_TemperatureCheckbox.Layout.Column = 1;
app.RTj_AltitudeCheckbox.Layout.Row = 2;
app.RTj_AltitudeCheckbox.Layout.Column = 1;

% gamma_T field
app.RTj_GammaTEditFieldLabel.Layout.Row = 7;
app.RTj_GammaTEditFieldLabel.Layout.Column = 1;
app.RTj_GammaTEditField.Layout.Row = 7;
app.RTj_GammaTEditField.Layout.Column = 2;

% Afterburner checkbox (inside app.RTj_AfterburnerPanelGrid)
app.RTj_AfterburnerCheckbox.Layout.Row = 1;
app.RTj_AfterburnerCheckbox.Layout.Column = [1 2];

% Tt7 field (inside app.RTj_AfterburnerPanelGrid)
app.RTj_Tt7EditFieldLabel.Layout.Row = 2;
app.RTj_Tt7EditFieldLabel.Layout.Column = 1;
app.RTj_Tt7EditField.Layout.Row = 2;
app.RTj_Tt7EditField.Layout.Column = 2;

% gamma_AB field (inside app.RTj_AfterburnerPanelGrid)
app.RTj_GammaABEditFieldLabel.Layout.Row = 3;
app.RTj_GammaABEditFieldLabel.Layout.Column = 1;
app.RTj_GammaABEditField.Layout.Row = 3;
app.RTj_GammaABEditField.Layout.Column = 2;
end

