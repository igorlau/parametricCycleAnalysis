classdef IdealTurboprop
    properties (Access = public)
        Inputs = struct()
        Outputs = struct()
    end
    
    methods
        function obj = IdealTurboprop(mach,flightRegimeType,flightRegimeValue,gammaC,cpC,turbopropType)
            % Construct an instance of this class with engine inputs
            if nargin > 0
                obj.Inputs = struct('mach', mach,...
                    'flightRegimeType', flightRegimeType,...
                    'flightRegimeValue', flightRegimeValue,...
                    'gammaC', gammaC,...
                    'cpC', cpC,...
                    'turbopropType', turbopropType);
            else
                obj.Inputs = struct();
            end
        end
        
        function obj = set.Inputs(obj, inputStruct)
            % Set the inputs struct
            obj.Inputs = inputStruct;
        end
        
        function obj = set.Outputs(obj, outputStruct)
            % Set the outputs struct
            obj.Outputs = outputStruct;
        end
    end
end

