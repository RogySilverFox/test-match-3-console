require('GameModel')
require('Enums')

---------------------------------------------------------------------------------------------------
-- Main:
--
-- Файл запуска игры
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
-- Глобальные переменныу
isMainRun = true
gameModel = GameModel:new()

---------------------------------------------------------------------------------------------------
local function parseUserInput(userInputString)
   local userInput = {}

   for str in string.gmatch(userInputString, "([^%s]+)") do
      table.insert(userInput, str)
   end

   return userInput
end 

local function executeUserCommand(userInputString)
   local userInput = parseUserInput(userInputString)

   if (#userInput == 4 or #userInput == 1) then
        if userInput[1] == UserCommandsEnum.Move then
            local row = tonumber(userInput[2])
            local column = tonumber(userInput[3])
            if row == nil or column == nil then
                print('!!! Input Error !!!')
                return
            end
            row = row + 1
            column = column + 1
            if userInput[4] == MoveDirectionEnum.Down then
                gameModel:move({row=row, column=column}, {row=row+1, column=column})
            elseif userInput[4] == MoveDirectionEnum.Up then
                gameModel:move({row=row, column=column}, {row=row-1, column=column})
            elseif userInput[4] == MoveDirectionEnum.Right then
                gameModel:move({row=row, column=column}, {row=row, column=column+1})
            elseif userInput[4] == MoveDirectionEnum.Left then
                gameModel:move({row=row, column=column}, {row=row, column=column-1})
            else
                print('!!! Input Error !!!')
                return
            end

        elseif userInput[1] == UserCommandsEnum.Exit then
            isMainRun = false
            return
        else
            print('!!! Input Error !!!')
            return
        end
    else
        print('!!! Input Error !!!')
        return
    end
end

---------------------------------------------------------------------------------------------------
function main()
    gameModel:init()
    local userInputString

    while isMainRun do
        print('Please enter the command: \n(Example "m row_index column_index u/d/l/r" or "q")')
        userInputString = io.stdin:read()
        executeUserCommand(userInputString)
    end
end

---------------------------------------------------------------------------------------------------
-- Запуск программы
main()