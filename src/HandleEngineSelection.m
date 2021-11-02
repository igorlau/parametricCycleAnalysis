function HandleEngineSelection(app)
% Function that enables the fields for the selected engines
%   The function sets the enable property of the respective engine fields
%   with the selection/unselection of the engine in the Engine Inputs
%   panel. The function is trigerred when the SAVE Button is pushed.

%% Ideal Ramjet Fields
IR_TabGridChildren = get(app.RamjetIdealTabGrid, 'Children');
IR_FlightRegimeCheckboxGridChildren = get(app.IR_FlightRegimeGridCheckbox, 'Children');

enableTabChildren = IR_TabGridChildren(isprop(IR_TabGridChildren, 'Enable'));
enableFlightRegimeChildren = IR_FlightRegimeCheckboxGridChildren(isprop(IR_FlightRegimeCheckboxGridChildren, 'Enable'));

if (app.selectedEngines.IdealRamjet)
    enable = 'on';
else
    enable = 'off';
end

set(enableTabChildren, 'Enable', enable);
set(enableFlightRegimeChildren, 'Enable', enable);

%% Ideal Turbojet Fields
ITj_TabGridChildren = get(app.TurbojetIdealTabGrid, 'Children');
ITj_FlightRegimeCheckboxGridChildren = get(app.ITj_FlightRegimeGridCheckbox, 'Children');

enableTabChildren = ITj_TabGridChildren(isprop(ITj_TabGridChildren, 'Enable'));
enableFlightRegimeChildren = ITj_FlightRegimeCheckboxGridChildren(isprop(ITj_FlightRegimeCheckboxGridChildren, 'Enable'));

if (app.selectedEngines.IdealTurbojet)
    enable = 'on';
else
    enable = 'off';
end

set(enableTabChildren, 'Enable', enable);
set(enableFlightRegimeChildren, 'Enable', enable);

%% Ideal Turbofan Fields
ITf_TabGridChildren = get(app.TurbofanIdealTabGrid, 'Children');
ITf_FlightRegimeCheckboxGridChildren = get(app.ITf_FlightRegimeGridCheckbox, 'Children');

enableTabChildren = ITf_TabGridChildren(isprop(ITf_TabGridChildren, 'Enable'));
enableFlightRegimeChildren = ITf_FlightRegimeCheckboxGridChildren(isprop(ITf_FlightRegimeCheckboxGridChildren, 'Enable'));

if (app.selectedEngines.IdealTurbofan)
    enable = 'on';
else
    enable = 'off';
end

set(enableTabChildren, 'Enable', enable);
set(enableFlightRegimeChildren, 'Enable', enable);

%% Ideal Turboprop Fields
ITp_TabGridChildren = get(app.TurbopropIdealTabGrid, 'Children');
ITp_FlightRegimeCheckboxGridChildren = get(app.ITp_FlightRegimeGridCheckbox, 'Children');

enableTabChildren = ITp_TabGridChildren(isprop(ITp_TabGridChildren, 'Enable'));
enableFlightRegimeChildren = ITp_FlightRegimeCheckboxGridChildren(isprop(ITp_FlightRegimeCheckboxGridChildren, 'Enable'));

if (app.selectedEngines.IdealTurboprop)
    enable = 'on';
else
    enable = 'off';
end

set(enableTabChildren, 'Enable', enable);
set(enableFlightRegimeChildren, 'Enable', enable);

%% Real Turbojet Fields
RTj_TabGridChildren = get(app.TurbojetRealTabGrid, 'Children');
RTj_FlightRegimeCheckboxGridChildren = get(app.RTj_FlightRegimeGridCheckbox, 'Children');
Rtj_AfterbunerPanelGrid = get(app.RTj_AfterburnerPanelGrid, 'Children');

enableTabChildren = RTj_TabGridChildren(isprop(RTj_TabGridChildren, 'Enable'));
enableFlightRegimeChildren = RTj_FlightRegimeCheckboxGridChildren(isprop(RTj_FlightRegimeCheckboxGridChildren, 'Enable'));
enablePanelChildren = Rtj_AfterbunerPanelGrid(isprop(Rtj_AfterbunerPanelGrid, 'Enable'));

if (app.selectedEngines.RealTurbojet)
    enable = 'on';
else
    enable = 'off';
end

set(enableTabChildren, 'Enable', enable);
set(enableFlightRegimeChildren, 'Enable', enable);
set(enablePanelChildren, 'Enable', enable);

%% Real Turbofan Fields
RTf_TabGridChildren = get(app.TurbofanRealTabGrid,'Children');
RTf_FlightRegimeCheckboxGridChildren = get(app.RTf_FlightRegimeGridCheckbox,'Children');

enableTabChildren = RTf_TabGridChildren(isprop(RTf_TabGridChildren, 'Enable'));
enableFlightRegimeChildren = RTf_FlightRegimeCheckboxGridChildren(isprop(RTf_FlightRegimeCheckboxGridChildren, 'Enable'));

if (app.selectedEngines.RealTurbofan)
    enable = 'on';
else
    enable = 'off';
end

set(enableTabChildren, 'Enable', enable);
set(enableFlightRegimeChildren, 'Enable', enable);

end

