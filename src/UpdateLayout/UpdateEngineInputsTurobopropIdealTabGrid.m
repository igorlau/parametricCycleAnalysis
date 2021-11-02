function UpdateEngineInputsTurobopropIdealTabGrid(app, appColumns)
% Change the Ideal Turboprop Tab grid size and the field displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size
if (appColumns == 1)
    % Set a 7x7 grid on the tab
    app.TurbopropIdealTabGrid.RowHeight = repmat({'1x'},1,7);
    app.TurbopropIdealTabGrid.ColumnWidth = repmat({'1x'},1,7);
    
    % Flight regime checkbox grid positioning
    app.ITp_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITp_FlightRegimeGridCheckbox.Layout.Column = [5 6];
    
    % Conventional/Advanced button positioning
    app.ITp_ConventionalAdvancedButton.Layout.Row = 7;
    app.ITp_ConventionalAdvancedButton.Layout.Column = 7;
    
elseif (appColumns == 2)
    % Set a 20x5 grid on the tab
    app.TurbopropIdealTabGrid.RowHeight = repmat({'1x'},1,20);
    app.TurbopropIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.ITp_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITp_FlightRegimeGridCheckbox.Layout.Column = 5;
    
    % Conventional/Advanced button positioning
    app.ITp_ConventionalAdvancedButton.Layout.Row = 20;
    app.ITp_ConventionalAdvancedButton.Layout.Column = 5;
    
elseif (appColumns == 3)
    % Set a 15x5 grid on the tab
    app.TurbopropIdealTabGrid.RowHeight = repmat({'1x'},1,15);
    app.TurbopropIdealTabGrid.ColumnWidth = repmat({'1x'},1,5);
    
    % Flight regime checkbox grid positioning
    app.ITp_FlightRegimeGridCheckbox.Layout.Row = 2;
    app.ITp_FlightRegimeGridCheckbox.Layout.Column = 5;
    
    % Conventional/Advanced button positioning
    app.ITp_ConventionalAdvancedButton.Layout.Row = 15;
    app.ITp_ConventionalAdvancedButton.Layout.Column = 5;
end

%% Common input fields displacement
% Mach number field
app.ITp_MachNumberEditFieldLabel.Layout.Row = 2;
app.ITp_MachNumberEditFieldLabel.Layout.Column = 1;
app.ITp_MachNumberEditField.Layout.Row = 2;
app.ITp_MachNumberEditField.Layout.Column = 2;

% Flight regime checkboxes (inside app.TpI_FlightRegimeGridCheckbox)
app.ITp_TemperatureCheckbox.Layout.Row = 1;
app.ITp_TemperatureCheckbox.Layout.Column = 1;
app.ITp_AltitudeCheckbox.Layout.Row = 2;
app.ITp_AltitudeCheckbox.Layout.Column = 1;

% Flight regime field
app.ITp_FlightRegimeEditFieldLabel.Layout.Row = 2;
app.ITp_FlightRegimeEditFieldLabel.Layout.Column = 3;
app.ITp_FlightRegimeEditField.Layout.Row = 2;
app.ITp_FlightRegimeEditField.Layout.Column = 4;

end

