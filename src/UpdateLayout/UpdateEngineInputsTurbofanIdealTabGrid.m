function UpdateEngineInputsTurbofanIdealTabGrid(app, appColumns)
% Change the Ideal Turbofan Tab grid size and the field displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size
if (appColumns == 1)
    % Set a 7x7 grid on the tab
    app.TurbofanIdealTabGrid.RowHeight = repmat({'1x'},1,7);
    app.TurbofanIdealTabGrid.ColumnWidth = repmat({'1x'},1,7);
    
    % Flight regime checkbox grid positioning
    app.ITf_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITf_FlightRegimeGridCheckbox.Layout.Column = [5 6];
elseif (appColumns == 2)
    % Set a 20x5 grid on the tab
    app.TurbofanIdealTabGrid.RowHeight = repmat({'1x'},1,20);
    app.TurbofanIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.ITf_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITf_FlightRegimeGridCheckbox.Layout.Column = 5;
elseif (appColumns == 3)
    % Set a 15x5 grid on the tab
    app.TurbofanIdealTabGrid.RowHeight = repmat({'1x'},1,15);
    app.TurbofanIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.ITf_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITf_FlightRegimeGridCheckbox.Layout.Column = 5;
end

%% Common input fields displacement
% Mach number field
app.ITf_MachNumberEditFieldLabel.Layout.Row = 2;
app.ITf_MachNumberEditFieldLabel.Layout.Column = 1;
app.ITf_MachNumberEditField.Layout.Row = 2;
app.ITf_MachNumberEditField.Layout.Column = 2;

% gamma_C field
app.ITf_GammaCEditFieldLabel.Layout.Row = 3;
app.ITf_GammaCEditFieldLabel.Layout.Column = 1;
app.ITf_GammaCEditField.Layout.Row = 3;
app.ITf_GammaCEditField.Layout.Column = 2;

% c_pc field
app.ITf_CpcEditFieldLabel.Layout.Row = 4;
app.ITf_CpcEditFieldLabel.Layout.Column = 1;
app.ITf_CpcEditField.Layout.Row = 4;
app.ITf_CpcEditField.Layout.Column = 2;

% h_pr field
app.ITf_HprEditFieldLabel.Layout.Row = 5;
app.ITf_HprEditFieldLabel.Layout.Column = 1;
app.ITf_HprEditField.Layout.Row = 5;
app.ITf_HprEditField.Layout.Column = 2;

% T_t4 field
app.ITf_Tt4EditFieldLabel.Layout.Row = 6;
app.ITf_Tt4EditFieldLabel.Layout.Column = 1;
app.ITf_Tt4EditField.Layout.Row = 6;
app.ITf_Tt4EditField.Layout.Column = 2;

% Flight regime checkboxes (inside app.ITf_FlightRegimeGridCheckbox)
app.ITf_TemperatureCheckbox.Layout.Row = 1;
app.ITf_TemperatureCheckbox.Layout.Column = 1;
app.ITf_AltitudeCheckbox.Layout.Row = 2;
app.ITf_AltitudeCheckbox.Layout.Column = 1;

% Flight regime field
app.ITf_FlightRegimeEditFieldLabel.Layout.Row = 2;
app.ITf_FlightRegimeEditFieldLabel.Layout.Column = 3;
app.ITf_FlightRegimeEditField.Layout.Row = 2;
app.ITf_FlightRegimeEditField.Layout.Column = 4;

% pi_C field
app.ITf_PicEditFieldLabel.Layout.Row = 3;
app.ITf_PicEditFieldLabel.Layout.Column = 3;
app.ITf_PicEditField.Layout.Row = 3;
app.ITf_PicEditField.Layout.Column = 4;

% pi_F field
app.ITf_PifEditFieldLabel.Layout.Row = 4;
app.ITf_PifEditFieldLabel.Layout.Column = 3;
app.ITf_PifEditField.Layout.Row = 4;
app.ITf_PifEditField.Layout.Column = 4;

% Bypass Ratio field
app.ITf_BPREditFieldLabel.Layout.Row = 5;
app.ITf_BPREditFieldLabel.Layout.Column = 3;
app.ITf_BPREditField.Layout.Row = 5;
app.ITf_BPREditField.Layout.Column = 4;
end

