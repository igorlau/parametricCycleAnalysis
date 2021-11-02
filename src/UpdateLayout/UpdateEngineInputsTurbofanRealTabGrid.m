function UpdateEngineInputsTurbofanRealTabGrid(app, appColumns)
% Change the Real Turbofan Tab grid size and the field displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size
if (appColumns == 1)
    % Set a 7x9 grid on the tab
    app.TurbofanRealTabGrid.RowHeight = repmat({'1x'},1,7);
    app.TurbofanRealTabGrid.ColumnWidth = repmat({'1x'},1,9);
    
    % c_pt field positioning
    app.RTf_CptEditFieldLabel.Layout.Row = 1;
    app.RTf_CptEditFieldLabel.Layout.Column = 4;
    app.RTf_CptEditField.Layout.Row = 1;
    app.RTf_CptEditField.Layout.Column = 5;
    
    % P0/P9 field positioning
    app.RTf_P0P9EditFieldLabel.Layout.Row = 2;
    app.RTf_P0P9EditFieldLabel.Layout.Column = 4;
    app.RTf_P0P9EditField.Layout.Row = 2;
    app.RTf_P0P9EditField.Layout.Column = 5;
    
    % P0/P19 field positioning
    app.RTf_P0P19EditFieldLabel.Layout.Row = 3;
    app.RTf_P0P19EditFieldLabel.Layout.Column = 4;
    app.RTf_P0P19EditField.Layout.Row = 3;
    app.RTf_P0P19EditField.Layout.Column = 5;
    
    % Bypass Ratio field positioning
    app.RTf_BPREditFieldLabel.Layout.Row = 4;
    app.RTf_BPREditFieldLabel.Layout.Column = 4;
    app.RTf_BPREditField.Layout.Row = 4;
    app.RTf_BPREditField.Layout.Column = 5;
    
    % pi_C field positioning
    app.RTf_PicEditFieldLabel.Layout.Row = 5;
    app.RTf_PicEditFieldLabel.Layout.Column = 4;
    app.RTf_PicEditField.Layout.Row = 5;
    app.RTf_PicEditField.Layout.Column = 5;
    
    % pi_F field positioning
    app.RTf_PifEditFieldLabel.Layout.Row = 6;
    app.RTf_PifEditFieldLabel.Layout.Column = 4;
    app.RTf_PifEditField.Layout.Row = 6;
    app.RTf_PifEditField.Layout.Column = 5;
    
    % pi_Dmax field positioning
    app.RTf_PidmaxEditFieldLabel.Layout.Row = 7;
    app.RTf_PidmaxEditFieldLabel.Layout.Column = 4;
    app.RTf_PidmaxEditField.Layout.Row = 7;
    app.RTf_PidmaxEditField.Layout.Column = 5;
    
    % pi_B field positioning
    app.RTf_PibEditFieldLabel.Layout.Row = 1;
    app.RTf_PibEditFieldLabel.Layout.Column = 6;
    app.RTf_PibEditField.Layout.Row = 1;
    app.RTf_PibEditField.Layout.Column = 7;
    
    % pi_N field positioning
    app.RTf_PinEditFieldLabel.Layout.Row = 2;
    app.RTf_PinEditFieldLabel.Layout.Column = 6;
    app.RTf_PinEditField.Layout.Row = 2;
    app.RTf_PinEditField.Layout.Column = 7;
    
    % pi_FN field positioning
    app.RTf_PifnEditFieldLabel.Layout.Row = 3;
    app.RTf_PifnEditFieldLabel.Layout.Column = 6;
    app.RTf_PifnEditField.Layout.Row = 3;
    app.RTf_PifnEditField.Layout.Column = 7;
    
    % e_C field positioning
    app.RTf_EcEditFieldLabel.Layout.Row = 4;
    app.RTf_EcEditFieldLabel.Layout.Column = 6;
    app.RTf_EcEditField.Layout.Row = 4;
    app.RTf_EcEditField.Layout.Column = 7;
    
    % e_T field positioning
    app.RTf_EtEditFieldLabel.Layout.Row = 5;
    app.RTf_EtEditFieldLabel.Layout.Column = 6;
    app.RTf_EtEditField.Layout.Row = 5;
    app.RTf_EtEditField.Layout.Column = 7;
    
    % e_F field positioning
    app.RTf_EfEditFieldLabel.Layout.Row = 6;
    app.RTf_EfEditFieldLabel.Layout.Column = 6;
    app.RTf_EfEditField.Layout.Row = 6;
    app.RTf_EfEditField.Layout.Column = 7;
    
    % eta_B field positioning
    app.RTf_EtabEditFieldLabel.Layout.Row = 7;
    app.RTf_EtabEditFieldLabel.Layout.Column = 6;
    app.RTf_EtabEditField.Layout.Row = 7;
    app.RTf_EtabEditField.Layout.Column = 7;
    
    % eta_M field positioning
    app.RTf_EtamEditFieldLabel.Layout.Row = 1;
    app.RTf_EtamEditFieldLabel.Layout.Column = 8;
    app.RTf_EtamEditField.Layout.Row = 1;
    app.RTf_EtamEditField.Layout.Column = 9;
    
elseif (appColumns == 2 || appColumns ==3)
    if (appColumns == 2)
        % Set a 20x5 grid on the tab
        app.TurbofanRealTabGrid.RowHeight = repmat({'1x'},1,20);
        app.TurbofanRealTabGrid.ColumnWidth = repmat({'1x'},1,5);
        
    else
        % Set a 15x5 grid on the tab
        app.TurbofanRealTabGrid.RowHeight = repmat({'1x'},1,15);
        app.TurbofanRealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    end
    
    % c_pt field positioning
    app.RTf_CptEditFieldLabel.Layout.Row = 8;
    app.RTf_CptEditFieldLabel.Layout.Column = 1;
    app.RTf_CptEditField.Layout.Row = 8;
    app.RTf_CptEditField.Layout.Column = 2;
    
    
    % P0/P9 field positioning
    app.RTf_P0P9EditFieldLabel.Layout.Row = 9;
    app.RTf_P0P9EditFieldLabel.Layout.Column = 1;
    app.RTf_P0P9EditField.Layout.Row = 9;
    app.RTf_P0P9EditField.Layout.Column = 2;
    
    % P0/P19 field positioning
    app.RTf_P0P19EditFieldLabel.Layout.Row = 10;
    app.RTf_P0P19EditFieldLabel.Layout.Column = 1;
    app.RTf_P0P19EditField.Layout.Row = 10;
    app.RTf_P0P19EditField.Layout.Column = 2;
    
    % Bypass Ratio field positioning
    app.RTf_BPREditFieldLabel.Layout.Row = 11;
    app.RTf_BPREditFieldLabel.Layout.Column = 1;
    app.RTf_BPREditField.Layout.Row = 11;
    app.RTf_BPREditField.Layout.Column = 2;
    
    % pi_C field positioning
    app.RTf_PicEditFieldLabel.Layout.Row = 1;
    app.RTf_PicEditFieldLabel.Layout.Column = 4;
    app.RTf_PicEditField.Layout.Row = 1;
    app.RTf_PicEditField.Layout.Column = 5;
    
    % pi_F field positioning
    app.RTf_PifEditFieldLabel.Layout.Row = 2;
    app.RTf_PifEditFieldLabel.Layout.Column = 4;
    app.RTf_PifEditField.Layout.Row = 2;
    app.RTf_PifEditField.Layout.Column = 5;
    
    % pi_Dmax field positioning
    app.RTf_PidmaxEditFieldLabel.Layout.Row = 3;
    app.RTf_PidmaxEditFieldLabel.Layout.Column = 4;
    app.RTf_PidmaxEditField.Layout.Row = 3;
    app.RTf_PidmaxEditField.Layout.Column = 5;
    
    % pi_B field positioning
    app.RTf_PibEditFieldLabel.Layout.Row = 4;
    app.RTf_PibEditFieldLabel.Layout.Column = 4;
    app.RTf_PibEditField.Layout.Row = 4;
    app.RTf_PibEditField.Layout.Column = 5;
    
    % pi_N field positioning
    app.RTf_PinEditFieldLabel.Layout.Row = 5;
    app.RTf_PinEditFieldLabel.Layout.Column = 4;
    app.RTf_PinEditField.Layout.Row = 5;
    app.RTf_PinEditField.Layout.Column = 5;
    
    % pi_FN field positioning
    app.RTf_PifnEditFieldLabel.Layout.Row = 6;
    app.RTf_PifnEditFieldLabel.Layout.Column = 4;
    app.RTf_PifnEditField.Layout.Row = 6;
    app.RTf_PifnEditField.Layout.Column = 5;
    
    % e_C field positioning
    app.RTf_EcEditFieldLabel.Layout.Row = 7;
    app.RTf_EcEditFieldLabel.Layout.Column = 4;
    app.RTf_EcEditField.Layout.Row = 7;
    app.RTf_EcEditField.Layout.Column = 5;
    
    % e_T field positioning
    app.RTf_EtEditFieldLabel.Layout.Row = 8;
    app.RTf_EtEditFieldLabel.Layout.Column = 4;
    app.RTf_EtEditField.Layout.Row = 8;
    app.RTf_EtEditField.Layout.Column = 5;
    
    % e_F field positioning
    app.RTf_EfEditFieldLabel.Layout.Row = 9;
    app.RTf_EfEditFieldLabel.Layout.Column = 4;
    app.RTf_EfEditField.Layout.Row = 9;
    app.RTf_EfEditField.Layout.Column = 5;
    
    % eta_B field positioning
    app.RTf_EtabEditFieldLabel.Layout.Row = 10;
    app.RTf_EtabEditFieldLabel.Layout.Column = 4;
    app.RTf_EtabEditField.Layout.Row = 10;
    app.RTf_EtabEditField.Layout.Column = 5;
    
    % eta_M field positioning
    app.RTf_EtamEditFieldLabel.Layout.Row = 11;
    app.RTf_EtamEditFieldLabel.Layout.Column = 4;
    app.RTf_EtamEditField.Layout.Row = 11;
    app.RTf_EtamEditField.Layout.Column = 5;
end

%% Common input fields displacement
% Mach number field
app.RTf_MachNumberEditFieldLabel.Layout.Row = 1;
app.RTf_MachNumberEditFieldLabel.Layout.Column = 1;
app.RTf_MachNumberEditField.Layout.Row = 1;
app.RTf_MachNumberEditField.Layout.Column = 2;

% gamma_C field
app.RTf_GammaCEditFieldLabel.Layout.Row = 2;
app.RTf_GammaCEditFieldLabel.Layout.Column = 1;
app.RTf_GammaCEditField.Layout.Row = 2;
app.RTf_GammaCEditField.Layout.Column = 2;

% c_pc field
app.RTf_CpcEditFieldLabel.Layout.Row = 3;
app.RTf_CpcEditFieldLabel.Layout.Column = 1;
app.RTf_CpcEditField.Layout.Row = 3;
app.RTf_CpcEditField.Layout.Column = 2;

% h_pr field
app.RTf_HprEditFieldLabel.Layout.Row = 4;
app.RTf_HprEditFieldLabel.Layout.Column = 1;
app.RTf_HprEditField.Layout.Row = 4;
app.RTf_HprEditField.Layout.Column = 2;

% T_t4 field
app.RTf_Tt4EditFieldLabel.Layout.Row = 5;
app.RTf_Tt4EditFieldLabel.Layout.Column = 1;
app.RTf_Tt4EditField.Layout.Row = 5;
app.RTf_Tt4EditField.Layout.Column = 2;

% Flight regime checkbox grid
app.RTf_FlightRegimeGridCheckbox.Layout.Row = 6;
app.RTf_FlightRegimeGridCheckbox.Layout.Column = 3;

% Flight regime checkboxes (inside app.TfR_FlightRegimeGridCheckbox)
app.RTf_TemperatureCheckbox.Layout.Row = 1;
app.RTf_TemperatureCheckbox.Layout.Column = 1;
app.RTf_AltitudeCheckbox.Layout.Row = 2;
app.RTf_AltitudeCheckbox.Layout.Column = 1;

% Flight regime field
app.RTf_FlightRegimeEditFieldLabel.Layout.Row = 6;
app.RTf_FlightRegimeEditFieldLabel.Layout.Column = 1;
app.RTf_FlightRegimeEditField.Layout.Row = 6;
app.RTf_FlightRegimeEditField.Layout.Column = 2;

% gamma_T field
app.RTf_GammaTEditFieldLabel.Layout.Row = 7;
app.RTf_GammaTEditFieldLabel.Layout.Column = 1;
app.RTf_GammaTEditField.Layout.Row = 7;
app.RTf_GammaTEditField.Layout.Column = 2;

end

