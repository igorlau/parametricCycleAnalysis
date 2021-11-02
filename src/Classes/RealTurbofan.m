classdef RealTurbofan
    properties (Access = public)
        Inputs = struct()
        Outputs = struct()
    end
    
    methods
        function obj = RealTurbofan(mach,flightRegimeType,flightRegimeValue,gammaC,cpC,hpr,Tt4,cpT,gammaT,BPR,P0P9,P0P19,piC,piF,piDmax,piB,piN,piFN,eC,eT,eF,etaB,etaM)
            % Construct an instance of this class with engine inputs
            if nargin > 0
                obj.Inputs = struct('mach', mach,...
                    'flightRegimeType', flightRegimeType,...
                    'flightRegimeValue', flightRegimeValue,...
                    'gammaC', gammaC,...
                    'cpC', cpC,...
                    'hpr', hpr,...
                    'Tt4', Tt4,...
                    'cpT', cpT,...
                    'gammaT', gammaT,...
                    'BPR', BPR,...
                    'P0P9',P0P9,...
                    'P0P19', P0P19,...
                    'piC', piC,...
                    'piF', piF,...
                    'piDmax', piDmax,...
                    'piB', piB,...
                    'piN', piN,...
                    'piFN', piFN,...
                    'eC', eC,...
                    'eT', eT,...
                    'eF', eF,...
                    'etaB', etaB,...
                    'etaM', etaM);
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
