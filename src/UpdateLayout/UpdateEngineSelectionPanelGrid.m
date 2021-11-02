function UpdateEngineSelectionPanelGrid(app, appColumns)
% Change the Engine Selection Panel grid size and the checkboxes displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the fields in it

%% Grid size and checkbox displacements
if (appColumns == 1 || appColumns == 2)
    
    % Set a 3x4 grid on the tab
    app.EngineSelectionPanelGrid.RowHeight = repmat({'1x'},1,3);
    app.EngineSelectionPanelGrid.ColumnWidth = repmat({'1x'},1,4);
    
    % Ramjet Ideal Checkbox positioning
    app.RamjetIdealCheckbox.Layout.Row = 1;
    app.RamjetIdealCheckbox.Layout.Column = [1 2];
    
    % Turbojet Ideal Checkbox positioning
    app.TurbojetIdealCheckbox.Layout.Row = 2;
    app.TurbojetIdealCheckbox.Layout.Column = [1 2];
    
    % Turbofan Ideal Checkbox positioning
    app.TurbofanIdealCheckbox.Layout.Row = 3;
    app.TurbofanIdealCheckbox.Layout.Column = [1 2];
    
    % Turboprop Ideal Checkbox positioning
    app.TurbopropIdealCheckbox.Layout.Row = 1;
    app.TurbopropIdealCheckbox.Layout.Column = [3 4];
    
    % Turbojet Real Checkbox positioning
    app.TurbojetRealCheckbox.Layout.Row = 2;
    app.TurbojetRealCheckbox.Layout.Column = [3 4];
    
    % Turbofan Real Checkbox positioning
    app.TurbofanRealCheckbox.Layout.Row = 3;
    app.TurbofanRealCheckbox.Layout.Column = [3 4];
    
    % Select All Checkbox positioning
    app.SelecionarTodosCheckbox.Layout.Row = 2;
    app.SelecionarTodosCheckbox.Layout.Column = [5 6];
    
    % Save Button positioning
    app.SaveSelectionButton.Layout.Row = 3;
    app.SaveSelectionButton.Layout.Column = [5 6];
    
elseif ( appColumns ==3)
    
    % Set a 8x4 grid on the tab
    app.EngineSelectionPanelGrid.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '0.25x'};
    app.EngineSelectionPanelGrid.ColumnWidth = {'1x', '1x', '1x', '1x'};
    
    % Ramjet Ideal Checkbox positioning
    app.RamjetIdealCheckbox.Layout.Row = 1;
    app.RamjetIdealCheckbox.Layout.Column = [2 4];
    
    % Turbojet Ideal Checkbox positioning
    app.TurbojetIdealCheckbox.Layout.Row = 2;
    app.TurbojetIdealCheckbox.Layout.Column = [2 4];
    
    % Turbofan Ideal Checkbox positioning
    app.TurbofanIdealCheckbox.Layout.Row = 3;
    app.TurbofanIdealCheckbox.Layout.Column = [2 4];
    
    % Turboprop Ideal Checkbox positioning
    app.TurbopropIdealCheckbox.Layout.Row = 4;
    app.TurbopropIdealCheckbox.Layout.Column = [2 4];
    
    % Turbojet Real Checkbox positioning
    app.TurbojetRealCheckbox.Layout.Row = 5;
    app.TurbojetRealCheckbox.Layout.Column = [2 4];
    
    % Turbofan Real Checkbox positioning
    app.TurbofanRealCheckbox.Layout.Row = 6;
    app.TurbofanRealCheckbox.Layout.Column = [2 4];
    
    % Select All Checkbox positioning
    app.SelecionarTodosCheckbox.Layout.Row = 7;
    app.SelecionarTodosCheckbox.Layout.Column = [2 4];
    
    % Save Button positioning
    app.SaveSelectionButton.Layout.Row = 8;
    app.SaveSelectionButton.Layout.Column = [3 4];
end

end

