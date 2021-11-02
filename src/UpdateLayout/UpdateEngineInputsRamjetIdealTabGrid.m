function UpdateEngineInputsRamjetIdealTabGrid(app, appColumns)
% Change the Ideal Ramjet Tab grid size and the field displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size
if (appColumns == 1)
    % Set a 7x7 grid on the tab
    app.RamjetIdealTabGrid.RowHeight = repmat({'1x'},1,7);
    app.RamjetIdealTabGrid.ColumnWidth = repmat({'1x'},1,7);
    
    % Flight regime checkbox grid positioning
    app.IR_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.IR_FlightRegimeGridCheckbox.Layout.Column = [5 6];
elseif (appColumns == 2)
    % Set a 20x5 grid on the tab
    app.RamjetIdealTabGrid.RowHeight = repmat({'1x'},1,20);
    app.RamjetIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.IR_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.IR_FlightRegimeGridCheckbox.Layout.Column = 5;
elseif (appColumns == 3)
    % Set a 15x5 grid on the tab
    app.RamjetIdealTabGrid.RowHeight = repmat({'1x'},1,15);
    app.RamjetIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.IR_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.IR_FlightRegimeGridCheckbox.Layout.Column = 5;
end

%% Common input fields displacement
% Mach number field
app.IR_MachNumberEditFieldLabel.Layout.Row = 2;
app.IR_MachNumberEditFieldLabel.Layout.Column = 1;
app.IR_MachNumberEditField.Layout.Row = 2;
app.IR_MachNumberEditField.Layout.Column = 2;

% gamma_C field
app.IR_GammaCEditFieldLabel.Layout.Row = 3;
app.IR_GammaCEditFieldLabel.Layout.Column = 1;
app.IR_GammaCEditField.Layout.Row = 3;
app.IR_GammaCEditField.Layout.Column = 2;

% c_pc field
app.IR_CpcEditFieldLabel.Layout.Row = 4;
app.IR_CpcEditFieldLabel.Layout.Column = 1;
app.IR_CpcEditField.Layout.Row = 4;
app.IR_CpcEditField.Layout.Column = 2;

% h_pr field
app.IR_HprEditFieldLabel.Layout.Row = 5;
app.IR_HprEditFieldLabel.Layout.Column = 1;
app.IR_HprEditField.Layout.Row = 5;
app.IR_HprEditField.Layout.Column = 2;

% T_t4 field
app.IR_Tt4EditFieldLabel.Layout.Row = 6;
app.IR_Tt4EditFieldLabel.Layout.Column = 1;
app.IR_Tt4EditField.Layout.Row = 6;
app.IR_Tt4EditField.Layout.Column = 2;

% Flight regime checkboxes (inside app.RI_FlightRegimeGridCheckbox)
app.IR_TemperatureCheckbox.Layout.Row = 1;
app.IR_TemperatureCheckbox.Layout.Column = 1;
app.IR_AltitudeCheckbox.Layout.Row = 2;
app.IR_AltitudeCheckbox.Layout.Column = 1;

% Flight regime field
app.IR_FlightRegimeEditFieldLabel.Layout.Row = 2;
app.IR_FlightRegimeEditFieldLabel.Layout.Column = 3;
app.IR_FlightRegimeEditField.Layout.Row = 2;
app.IR_FlightRegimeEditField.Layout.Column = 4;

end

