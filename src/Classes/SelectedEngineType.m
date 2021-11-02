classdef SelectedEngineType
    
    properties (Access = public)
        IdealRamjet = false
        IdealTurbojet = false
        RealTurbojet = false
        IdealTurbofan = false
        RealTurbofan = false
        IdealTurboprop = false
    end
    methods
        
        function obj = SelectedEngineType(idealRamjet, idealTurbojet, realTurbojet, idealTurbofan, realTurbofan, idealTurboprop)
            if nargin > 0
                obj.IdealRamjet = idealRamjet;
                obj.IdealTurbojet = idealTurbojet;
                obj.RealTurbojet = realTurbojet;
                obj.IdealTurbofan = idealTurbofan;
                obj.RealTurbofan = realTurbofan;
                obj.IdealTurboprop = idealTurboprop;
            else
                obj.IdealRamjet = false;
                obj.IdealTurbojet = false;
                obj.RealTurbojet = false;
                obj.IdealTurbofan = false;
                obj.RealTurbofan = false;
                obj.IdealTurboprop = false;
            end
        end
        
        function obj = set.IdealRamjet(obj, value)
            obj.IdealRamjet = value;
        end
        
        function obj = set.IdealTurbojet(obj, value)
            obj.IdealTurbojet = value;
        end
        function obj = set.RealTurbojet(obj, value)
            obj.RealTurbojet = value;
        end
        
        function obj = set.IdealTurbofan(obj, value)
            obj.IdealTurbofan = value;
        end
        
        function obj = set.RealTurbofan(obj, value)
            obj.RealTurbofan = value;
        end
        
        function obj = set.IdealTurboprop(obj, value)
            obj.IdealTurboprop = value;
        end
        
        function anySelected = CheckIfAnyIsSelected(obj)
            anySelected = obj.IdealRamjet || obj.IdealTurbojet || ...
                obj.RealTurbojet || obj.IdealTurbofan || obj.RealTurbofan ||...
                obj.IdealTurboprop;
        end
        
        function idealSelected = CheckIfAnyIdealIsSelected(obj)
            idealSelected = obj.IdealRamjet || ...
                obj.IdealTurbojet || ...
                obj.IdealTurbofan || ...
                obj.IdealTurboprop;
        end
        
        function realSelected = CheckIfAnyRealIsSelected(obj)
            realSelected = obj.RealTurbojet || obj.RealTurbofan;
        end
    end
end

