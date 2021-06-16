---------------------------------------------------------------------------------------------------
-- PossibleMovePatterns module:
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
-- Базовый класс поиска возможных вариантов
BasePossibleMovePattern = {}
BasePossibleMovePattern.__index = BasePossibleMovePattern

function BasePossibleMovePattern:new()
    local self = setmetatable({}, self)

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Public methods:
    self.checkHorizontalPatterns = nil
    self.checkVerticalPatterns = nil

    function self.isCrystalsSameColor(self, cristalsSlot, row_1, column_1, row_2, column_2)
        if row_1 < 1 or row_1 > #cristalsSlot or row_2 < 1 or row_2 > #cristalsSlot or 
            column_1 < 1 or column_1 > #cristalsSlot[1] or column_2 < 1 or column_2 > #cristalsSlot[1] then
            return false
        end
        
        return cristalsSlot[row_1][column_1].getColor() == cristalsSlot[row_2][column_2].getColor()
    end

    -- end new()
    return self
end

---------------------------------------------------------------------------------------------------
-- Класс поиска возможных вариантов линий
LinePossibleMovePattern = BasePossibleMovePattern:new()

LinePossibleMovePattern.checkHorizontalPatterns = function (self, row, column, cristalsSlot)
    local result = false

    -- 1-й Шаблон
    if LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row, column+1) then
        result = LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row, column-2) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row-1, column-1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+1, column-1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row, column+3) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row-1, column+2) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+1, column+2)
    end

    -- 2-й Шаблон
    if LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row, column+2) then
        result = LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row-1, column+1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+1, column+1)
    end

    return result
end

LinePossibleMovePattern.checkVerticalPatterns = function (self, row, column, cristalsSlot)
    local result = false

    -- 1-й Шаблон
    if LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+1, column) then
        result = LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row-2, column) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row-1, column-1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row-1, column+1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+3, column) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+2, column-1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+2, column+1)
    end

    -- 2-й Шаблон
    if LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+2, column) then
        result = LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+1, column-1) or
                LinePossibleMovePattern:isCrystalsSameColor(cristalsSlot, row, column, row+1, column+1)
    end

    return result
end