classdef IdealTurbojet
    properties (Access = public)
        Inputs = struct()
        Outputs = struct()
    end
    
    methods
        function obj = IdealTurbojet(mach,flightRegimeType,flightRegimeValue,gammaC,cpC,hpr,Tt4,piC,afterburner,Tt7)
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
                    'afterburner', afterburner,...
                    'Tt7', Tt7);
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

