function [appTableRowNames, appTableRowData] = PushEngineDataToTable(app, engineInputData, engineData, engineName)
% Function that adds the engine data to table.
%   The function adds the data from the engine struct for each varying parameter.

numberOfTableRows = length(app.UITable.RowName);

if (isfield(engineInputData, 'Tt4'))
    
    Tt4_values = engineInputData.Tt4;
    Tt4_fields = fieldnames(engineData);
    flightRegime_size = length(engineInputData.flightRegimeValue);
    
    if (isfield(engineInputData, 'piC'))
        piC_values = engineInputData.piC;
    else
        piC_values = NaN(1);
    end
    
    if (isfield(engineInputData, 'piF'))
        piF_values = engineInputData.piF;
    else
        piF_values = NaN(1);
    end
    
    piC_len = length(piC_values);
    piF_len = length(piF_values);
    piLen = max(piC_len, piF_len);
    
    mach_values = engineInputData.mach;
    
    for i = 1:length(Tt4_values)
        for j = 1:flightRegime_size
            for k = 1:piLen
                for m = 1:length(mach_values)
                    rowData = [Tt4_values(i), ...
                        engineInputData.flightRegimeValue(j), ...
                        piC_values(k),...
                        piF_values(k),...
                        engineInputData.mach(m),...
                        engineData.(Tt4_fields{i}).specificThrust{1,j}(k,m),...
                        engineData.(Tt4_fields{i}).specificConsumption{1,j}(k,m),...
                        engineData.(Tt4_fields{i}).fuelAirRatio{1,j}(k,m),...
                        engineData.(Tt4_fields{i}).efficiencies.thermal{1,j}(k,m),...
                        engineData.(Tt4_fields{i}).efficiencies.propulsive{1,j}(k,m),...
                        engineData.(Tt4_fields{i}).efficiencies.total{1,j}(k,m)...
                        ];
                    appTableRowNames{numberOfTableRows+1} = engineName;
                    appTableRowData(numberOfTableRows+1, :) = rowData;
                    numberOfTableRows = numberOfTableRows + 1;
                end
            end
        end
    end
    
else
    flightRegime_size = length(engineInputData.flightRegimeValue);
    
    if (isfield(engineInputData, 'piC'))
        pi_values = engineInputData.piC;
    elseif (isfield(engineInputData, 'piF'))
        pi_values = engineInputData.piF;
    else
        pi_values = NaN(1);
    end
    
    mach_values = engineInputData.mach;
    for j = 1:flightRegime_size
        for k = 1:length(pi_values)
            for m = 1:mach_values
                rowData = ['-', ...
                    engineInputData.flightRegimeValue(j), ...
                    pi_values(k),...
                    engineInputData.mach(m),...
                    engineData.specificThrust{j,k}(m),...
                    engineData.specificConsumption{j,k}(m),...
                    engineData.fuelAirRatio{j,k}(m),...
                    engineData.efficiencies.thermal{j,k}(m),...
                    engineData.efficiencies.propulsive{j,k}(m),...
                    engineData.efficiencies.total{j,k}(m)...
                    ];
                appTableRowNames{numberOfTableRows+1} = engineName;
                appTableRowData(numberOfTableRows+1, :) = rowData;
                numberOfTableRows = numberOfTableRows + 1;
            end
        end
    end
end


end

