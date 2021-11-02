function UpdateAppGridLayout(app, appColumns)
% Change the APP grid size and the panel displacement in it
%   Based on the screensize, the app generates the number of columns to
%   show in the window. So with the number of columns this function changes
%   the grid and position the panels in it

switch appColumns
    case 1
        % Set app 3x1 grid
        app.GridLayout.RowHeight = {176, 480, 480};
        app.GridLayout.ColumnWidth = {'1x'};
        
        % Set engine selection panel displacement
        app.EngineSelectionPanel.Layout.Row = 1;
        app.EngineSelectionPanel.Layout.Column = 1;
        
        % Set engine inputs displacement
        app.EngineInputsPanel.Layout.Row = 2;
        app.EngineInputsPanel.Layout.Column = 1;
        
        % Set analysis results displacement
        app.AnalysisResultPanel.Layout.Row = 3;
        app.AnalysisResultPanel.Layout.Column = 1;
        
    case 2
        % Set app 3x3 grid
        app.GridLayout.RowHeight = {176, 480, 480};
        app.GridLayout.ColumnWidth = {'1x', '1x'};
        
        % Set engine selection panel displacement
        app.EngineSelectionPanel.Layout.Row = 1;
        app.EngineSelectionPanel.Layout.Column = 1;
        
        % Set engine inputs displacement
        app.EngineInputsPanel.Layout.Row = [1 3];
        app.EngineInputsPanel.Layout.Column = 2;
        
        % Set analysis results displacement
        app.AnalysisResultPanel.Layout.Row = [2 3];
        app.AnalysisResultPanel.Layout.Column = 1;
        
    case 3
        % Set app 1x3 grid
        app.GridLayout.RowHeight = {'1x'};
        app.GridLayout.ColumnWidth = {'0.5x', '2x', '1.5x'};
        
        % Set engine selection panel displacement
        app.EngineSelectionPanel.Layout.Row = 1;
        app.EngineSelectionPanel.Layout.Column = 1;
        
        % Set engine inputs displacement
        app.EngineInputsPanel.Layout.Row = 1;
        app.EngineInputsPanel.Layout.Column = 2;
        
        % Set analysis results displacement
        app.AnalysisResultPanel.Layout.Row = 1;
        app.AnalysisResultPanel.Layout.Column = 3;
end

end

