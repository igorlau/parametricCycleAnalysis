function HandlePlotEngineParameters(app)
% Function that handle the user selection and plot the engine data whithin the selected axes
%   The function checks which engines were selected and then plots its data in
%   a separate window with the axes defined by the user.

if (app.Results_IdealRamjetCheckBox.Selected)
end
if (app.Results_IdealTurbojetCheckBox.Selected)
end
if (app.Results_IdealTurbofanCheckBox.Selected)
end
if (app.Results_IdealTurbopropCheckBox.Selected)
end
if (app.Results_RealTurbojetCheckBox.Selected)
end
if (app.Results_RealTurbofanCheckBox.Selected)
end

end

