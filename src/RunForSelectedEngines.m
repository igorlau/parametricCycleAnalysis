function RunForSelectedEngines(app)
% Function that checks which engines were selected and calls their run
% scripts
%   The function checks if the engine was selected and if the inputs were valid.
%   Then it calls the respective engine scripts for the parametric
%   analysis run. The functions is triggered when the COMPILAR button is
%   pushed.

rowData = [];
rowName = {};
app.UITable.Data = [];
app.UITable.RowName = {};

if (app.selectedEngines.IdealRamjet)
    RunIdealRamjetAnalysis(app);
    assignin('base', 'idealRamjet', app.idealRamjetEngine);
    [IR_rowNames, IR_rowData] = PushEngineDataToTable(app, app.idealRamjetEngine.Inputs, app.idealRamjetEngine.Outputs, 'Ideal Ramjet');
    rowData = vertcat(rowData, IR_rowData);
    rowName = vertcat(rowName, IR_rowNames');
end

if (app.selectedEngines.IdealTurbojet)
    RunIdealTurbojetAnalysis(app);
    assignin('base', 'idealTurbojet', app.idealTurbojetEngine);
    [ITj_rowNames, ITj_rowData] = PushEngineDataToTable(app, app.idealTurbojetEngine.Inputs, app.idealTurbojetEngine.Outputs, 'Ideal Turbojet');
    rowData = vertcat(rowData,  ITj_rowData);
    rowName = vertcat(rowName, ITj_rowNames');
end

if (app.selectedEngines.IdealTurbofan)
    RunIdealTurbofanAnalysis(app);
    assignin('base', 'idealTurbofan', app.idealTurbofanEngine);
    [ITf_rowNames, ITf_rowData] = PushEngineDataToTable(app, app.idealTurbofanEngine.Inputs, app.idealTurbofanEngine.Outputs, 'Ideal Turbofan');
    rowData = vertcat(rowData,ITf_rowData);
    rowName = vertcat(rowName, ITf_rowNames');
end

if (app.selectedEngines.IdealTurboprop)
    RunIdealTurbopropAnalysis(app);
    assignin('base', 'idealTurboprop', app.idealTurbopropEngine);
    [ITp_rowNames, ITp_rowData] = PushEngineDataToTable(app, app.idealTurbopropEngine.Inputs, app.idealTurbopropEngine.Outputs, 'Ideal Turboprop');
    rowData = vertcat(rowData, ITp_rowData);
    rowName = vertcat(rowName, ITp_rowNames');
end

if (app.selectedEngines.RealTurbojet)
    RunRealTurbojetAnalysis(app);
    assignin('base', 'realTurbojet', app.realTurbojetEngine);
    [RTj_rowNames, RTj_rowData] = PushEngineDataToTable(app, app.realTurbojetEngine.Inputs, app.realTurbojetEngine.Outputs, 'Real Turbojet');
    rowData = vertcat(rowData, RTj_rowData);
    rowName = vertcat(rowName, RTj_rowNames');
end

if (app.selectedEngines.RealTurbofan)
    RunRealTurbofanAnalysis(app);
    assignin('base', 'realTurbofan', app.realTurbofanEngine);
    [RTf_rowNames, RTf_rowData] = PushEngineDataToTable(app, app.realTurbofanEngine.Inputs, app.realTurbofanEngine.Outputs, 'Real Turbofan');
    rowData = vertcat(rowData, RTf_rowData);
    rowName = vertcat(rowName, RTf_rowNames');
end

if (length(rowData) <= 1000)
    app.TextArea.Visible = false;
    app.UITable.Visible = true;
else
    app.TextArea.Visible = true;
    app.UITable.Visible = false;
end

app.UITable.Data = rowData;
app.UITable.RowName = rowName;

end

