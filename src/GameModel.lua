require('Crystal')
require('Enums')
require('PossibleMovePatterns')
require('GameVisualizer')

---------------------------------------------------------------------------------------------------
-- GameModel module:
---------------------------------------------------------------------------------------------------


GameModel = {}
GameModel.__index = GameModel

function GameModel:new()
    local self = setmetatable({}, self)

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Private variables:
    local _cristalsSlot = nil
    local _cristalsSlotColumnsCount = nil
    local _cristalsSlotRowsCount = nil

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Private methods:
    local function isThreeSameColor(row, column, color)
        if column >= 3 and
            color == _cristalsSlot[row][column-1].getColor() and 
            color == _cristalsSlot[row][column-2].getColor() then
            return true
        end
        if row >= 3 and
            color == _cristalsSlot[row-1][column].getColor() and 
            color == _cristalsSlot[row-2][column].getColor() then
            return true
        end

        return false
    end

    local function generateSimpleSlot(slotColumnsCount, slotRowsCount)
        local newCrystal

        _cristalsSlotColumnsCount = slotColumnsCount
        _cristalsSlotRowsCount = slotRowsCount
        _cristalsSlot = {}

        for i = 1, slotRowsCount do
            _cristalsSlot[i] = {}
            for j = 1, slotColumnsCount do
                newCrystal = Crystal:new(
                    CrystalTypeEnum[math.random(#CrystalTypeEnum)],
                    CrystalColorEnum[math.random(#CrystalColorEnum)]
                )

                while isThreeSameColor(i, j, newCrystal.getColor()) do
                    newCrystal = Crystal:new(
                        CrystalTypeEnum[math.random(#CrystalTypeEnum)],
                        CrystalColorEnum[math.random(#CrystalColorEnum)]
                    )
                end

                _cristalsSlot[i][j] = newCrystal
            end
        end
    end

    local function isMoveExists()
        for i = 1, _cristalsSlotRowsCount do
            for j = 1, _cristalsSlotColumnsCount do
                if LinePossibleMovePattern:checkHorizontalPatterns(i, j, _cristalsSlot) or LinePossibleMovePattern:checkVerticalPatterns(i, j, _cristalsSlot) then
                    return true
                end
            end
        end

        return false
    end

    local function getHorizontalLines() --
        local horizontalLinesArray = {}
        local currentCrysatalPosition = {row=1, column=1}
        local countSameColor = 1

        for i = 1, _cristalsSlotRowsCount do
            for j = 2, _cristalsSlotColumnsCount do
                if _cristalsSlot[i][j].getColor() == _cristalsSlot[i][j - 1].getColor() then
                    countSameColor = countSameColor + 1
                else
                    table.insert(horizontalLinesArray, {position=currentCrysatalPosition,  count=countSameColor})
                    currentCrysatalPosition = {row=i, column=j}
                    countSameColor = 1
                end

                if j == _cristalsSlotColumnsCount then
                    table.insert(horizontalLinesArray, {position=currentCrysatalPosition,  count=countSameColor})
                    currentCrysatalPosition = {row=i+1, column=1}
                    countSameColor = 1
                end
            end
        end

        return horizontalLinesArray
    end

    local function getVerticalLines() --
        local verticalLinesArray = {}
        local currentCrysatalPosition = {row=1, column=1}
        local countSameColor = 1

        for i = 1, _cristalsSlotColumnsCount do
            for j = 2, _cristalsSlotRowsCount do 
                if _cristalsSlot[j][i].getColor() == _cristalsSlot[j - 1][i].getColor() then
                    countSameColor = countSameColor + 1
                else
                    table.insert(verticalLinesArray, {position=currentCrysatalPosition,  count=countSameColor})
                    currentCrysatalPosition = {row=j, column=i}
                    countSameColor = 1
                end

                if j == _cristalsSlotRowsCount then
                    table.insert(verticalLinesArray, {position=currentCrysatalPosition,  count=countSameColor})
                    currentCrysatalPosition = {row=1, column=i+1}
                    countSameColor = 1
                end
            end
        end

        return verticalLinesArray
    end

    local function findAndDestroyByType(destructionType)
        if destructionType == DestructionTypesEnum.Line then
            local result = false

            local horizontalLinesArray = getHorizontalLines()
            local verticalLinesArray = getVerticalLines()

            -- удаление линий по горизонтале
            for i = 1, #horizontalLinesArray do
                if horizontalLinesArray[i].count > 2 then
                    result = true
                    for j = 0, horizontalLinesArray[i].count-1 do
                        _cristalsSlot[horizontalLinesArray[i].position.row][horizontalLinesArray[i].position.column+j] = nil
                    end
                end
            end

            -- удаление линий по вертикали
            for i = 1, #verticalLinesArray do
                if verticalLinesArray[i].count > 2 then
                    result = true
                    for j = 0, verticalLinesArray[i].count-1 do
                        _cristalsSlot[verticalLinesArray[i].position.row+j][verticalLinesArray[i].position.column] = nil
                    end
                end
            end

            return result
        end
    end

    local function refillSlot()
        for i = 1, _cristalsSlotRowsCount do
            for j = 1, _cristalsSlotColumnsCount do
                if _cristalsSlot[i][j] == nil then
                    _cristalsSlot[i][j] = Crystal:new(
                        CrystalTypeEnum[math.random(#CrystalTypeEnum)],
                        CrystalColorEnum[math.random(#CrystalColorEnum)]
                    )
                end
            end
        end
    end

    local function swapCrystals(from, to)
        local tmpCrystal = _cristalsSlot[to.row][to.column]
        _cristalsSlot[to.row][to.column] = _cristalsSlot[from.row][from.column]
        _cristalsSlot[from.row][from.column] = tmpCrystal
    end

    --:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    -- Public methods:
    function self.init()
        generateSimpleSlot(10, 10) -- генерация игрового поля

        if not isMoveExists() then
            self.mix()
        end

        self.tick()
    end

    function self.tick()
        GameVisualizer:dump(_cristalsSlot, _cristalsSlotRowsCount, _cristalsSlotColumnsCount)
    end

    function self.move(self, from, to)
        if from.row < 1 or to.row < 1 or 
            from.row > _cristalsSlotRowsCount or to.row > _cristalsSlotRowsCount or 
            from.column < 1 or to.column < 1 or 
            from.column > _cristalsSlotColumnsCount or to.column > _cristalsSlotColumnsCount then
            return
        end

        swapCrystals(from, to)

        if findAndDestroyByType(DestructionTypesEnum.Line) then
            -- успешный ход
            self.tick()
            refillSlot()
            self.tick()
            
            while findAndDestroyByType(DestructionTypesEnum.Line) do
                self.tick()
                refillSlot()
                self.tick()
            end

            if not isMoveExists() then
                self.mix()
                self.tick()
            end
        else
            -- нейдачный ход
            swapCrystals(from, to)
        end
        
    end

    function self.mix()
        local currentCrystalsArray = {}
        local tmpArray
        local newCrystal
        local randomCrystalsArrayIndex

        for i = 1, _cristalsSlotRowsCount do
            for j = 1, _cristalsSlotColumnsCount do
                table.insert(currentCrystalsArray, _cristalsSlot[i][j])
            end
        end

        while not isMoveExists() do
            tmpArray = currentCrystalsArray
            
            for i = 1, _cristalsSlotRowsCount do
                for j = 1, _cristalsSlotColumnsCount do
                    randomCrystalsArrayIndex = math.random(#tmpArray)
                    newCrystal = tmpArray[randomCrystalsArrayIndex]

                    while isThreeSameColor(i, j, newCrystal.getColor()) do
                        randomCrystalsArrayIndex = math.random(#tmpArray)
                        newCrystal = tmpArray[randomCrystalsArrayIndex]
                    end
                    table.remove(tmpArray, randomCrystalsArrayIndex)
                    _cristalsSlot[i][j] = newCrystal
                end
            end
        end
    end

    -- end new()
    return self
end