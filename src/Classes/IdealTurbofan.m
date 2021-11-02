classdef IdealTurbofan
    properties (Access = public)
        Inputs = struct()
        Outputs = struct()
    end
    
    methods
        function obj = IdealTurbofan(mach,flightRegimeType,flightRegimeValue,gammaC,cpC,hpr,Tt4,piC,piF,BPR)
            % Construct an instance of this class with engine inputs
            if nargin > 0
                obj.Inputs = struct('mach', mach,...
                    'flightRegimeType', flightRegimeType,...
                    'flightRegimeValue', flightRegimeValue,...
                    'gammaC', gammaC,...
                    'cpC', cpC,...
                    'hpr', hpr,...
                    'Tt4', Tt4,...
                    'piC', piC,...
                    'piF', piF,...
                    'BPR', BPR);
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

