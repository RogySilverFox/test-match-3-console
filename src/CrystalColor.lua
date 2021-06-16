---------------------------------------------------------------------------------------------------
-- CrystalColor module:
---------------------------------------------------------------------------------------------------


CrystalColor = {}
CrystalColor.__index = CrystalColor

function CrystalColor:new(crystalColorName)
    local self = setmetatable({}, self)

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Private variables:
    local _name = crystalColorName

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Public methods:
    function self.getName()
        return _name
    end

    -- end new()
    return self
end