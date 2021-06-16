---------------------------------------------------------------------------------------------------
-- Crystal module:
--
-- Игровая фишка(кристалл)
---------------------------------------------------------------------------------------------------


Crystal = {}
Crystal.__index = Crystal

function Crystal:new(crystalType, crystalColor)
    local self = setmetatable({}, self)

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Private variables:
    local _type = crystalType
    local _color = crystalColor

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Public methods:
    function self.getType()
        return _type.getName()
    end

    function self.getColor()
        return _color.getName()
    end

    -- end new()
    return self
end