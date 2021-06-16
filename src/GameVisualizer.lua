---------------------------------------------------------------------------------------------------
-- GameModel module:
---------------------------------------------------------------------------------------------------


GameVisualizer = {}

function GameVisualizer:dump(cristalsSlot, cristalsSlotRowsCount, cristalsSlotColumnsCount)
    local slotStringVisualisator
    local stringVisualisatorLength
    local function getCrustalColor(cristal)
        if cristal == nil then
            return '*'
        else
            return cristal:getColor()
        end
    end

    print() -- разделитель для удобства
    -- Вывод шапки модели
    slotStringVisualisator = '   ' -- 3 пробела
    for i = 1, cristalsSlotColumnsCount do
       slotStringVisualisator = string.format('%s %d', slotStringVisualisator, i-1)
    end
    print(slotStringVisualisator)
    stringVisualisatorLength = string.len(slotStringVisualisator)
    slotStringVisualisator = '  ' -- 2 пробела
    slotStringVisualisator = string.format('%s%s', slotStringVisualisator, string.rep('-', stringVisualisatorLength-1))
    print(slotStringVisualisator)

    -- Вывод тела модели
    for i = 1, cristalsSlotRowsCount do
       slotStringVisualisator = string.format('%d |', i-1)

       for j = 1, cristalsSlotColumnsCount do
          slotStringVisualisator = string.format('%s %s', slotStringVisualisator, getCrustalColor(cristalsSlot[i][j]))
       end

       print(slotStringVisualisator)
    end
    print() -- разделитель для удобства
end