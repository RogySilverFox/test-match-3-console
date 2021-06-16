---------------------------------------------------------------------------------------------------
-- CrystalType module:
---------------------------------------------------------------------------------------------------


CrystalType = {}
CrystalType.__index = CrystalType

function CrystalType:new(crystalTypeName)
    local self = setmetatable({}, self)

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Private variables:
    local _name = crystalTypeName

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Public methods:
    function self.getName()
        return _name
    end

    -- end new()
    return self
end