function UpdateEngineInputsTurbojetIdealTabGrid(app,appColumns)
% Change the Ideal Turbojet Tab grid size and the field displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size
if (appColumns == 1)
    % Set a 7x7 grid on the tab
    app.TurbojetIdealTabGrid.RowHeight = repmat({'1x'},1,7);
    app.TurbojetIdealTabGrid.ColumnWidth = repmat({'1x'},1,7);
    
    % Flight regime checkbox grid positioning
    app.ITj_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITj_FlightRegimeGridCheckbox.Layout.Column = [5 6];
elseif (appColumns == 2)
    % Set a 20x5 grid on the tab
    app.TurbojetIdealTabGrid.RowHeight = repmat({'1x'},1,20);
    app.TurbojetIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.ITj_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITj_FlightRegimeGridCheckbox.Layout.Column = 5;
elseif (appColumns == 3)
    % Set a 15x5 grid on the tab
    app.TurbojetIdealTabGrid.RowHeight = repmat({'1x'},1,15);
    app.TurbojetIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.ITj_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITj_FlightRegimeGridCheckbox.Layout.Column = 5;
end

%% Common input fields displacement
% Mach number field
app.ITj_MachNumberEditFieldLabel.Layout.Row = 2;
app.ITj_MachNumberEditFieldLabel.Layout.Column = 1;
app.ITj_MachNumberEditField.Layout.Row = 2;
app.ITj_MachNumberEditField.Layout.Column = 2;

% gamma_C field
app.ITj_GammaCEditFieldLabel.Layout.Row = 3;
app.ITj_GammaCEditFieldLabel.Layout.Column = 1;
app.ITj_GammaCEditField.Layout.Row = 3;
app.ITj_GammaCEditField.Layout.Column = 2;

% c_pc field
app.ITj_CpcEditFieldLabel.Layout.Row = 4;
app.ITj_CpcEditFieldLabel.Layout.Column = 1;
app.ITj_CpcEditField.Layout.Row = 4;
app.ITj_CpcEditField.Layout.Column = 2;

% h_pr field
app.ITj_HprEditFieldLabel.Layout.Row = 5;
app.ITj_HprEditFieldLabel.Layout.Column = 1;
app.ITj_HprEditField.Layout.Row = 5;
app.ITj_HprEditField.Layout.Column = 2;

% T_t4 field
app.ITj_Tt4EditFieldLabel.Layout.Row = 6;
app.ITj_Tt4EditFieldLabel.Layout.Column = 1;
app.ITj_Tt4EditField.Layout.Row = 6;
app.ITj_Tt4EditField.Layout.Column = 2;

% Flight regime checkboxes (inside app.ITj_FlightRegimeGridCheckbox)
app.ITj_TemperatureCheckbox.Layout.Row = 1;
app.ITj_TemperatureCheckbox.Layout.Column = 1;
app.ITj_AltitudeCheckbox.Layout.Row = 2;
app.ITj_AltitudeCheckbox.Layout.Column = 1;

% Flight regime field
app.ITj_FlightRegimeEditFieldLabel.Layout.Row = 2;
app.ITj_FlightRegimeEditFieldLabel.Layout.Column = 3;
app.ITj_FlightRegimeEditField.Layout.Row = 2;
app.ITj_FlightRegimeEditField.Layout.Column = 4;

% pi_C field
app.ITj_PiCEditFieldLabel.Layout.Row = 3;
app.ITj_PiCEditFieldLabel.Layout.Column = 3;
app.ITj_PiCEditField.Layout.Row = 3;
app.ITj_PiCEditField.Layout.Column = 4;

% T_t7 field
app.ITj_Tt7EditFieldLabel.Layout.Row = 4;
app.ITj_Tt7EditFieldLabel.Layout.Column = 3;
app.ITj_Tt7EditField.Layout.Row = 4;
app.ITj_Tt7EditField.Layout.Column = 4;

% Afterburner checkbox
app.ITj_AfterburnerCheckbox.Layout.Row = 4;
app.ITj_AfterburnerCheckbox.Layout.Column = 5;
end

