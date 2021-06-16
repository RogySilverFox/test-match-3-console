require('CrystalType')
require('CrystalColor')

---------------------------------------------------------------------------------------------------
-- Enums module:
--
-- Данный модуль содержит все используемые перечисления в проекте
---------------------------------------------------------------------------------------------------


CrystalTypeEnum = {
    [1] = CrystalType:new('normal'),
}

CrystalColorEnum = {
    [1] = CrystalColor:new('A'),
    [2] = CrystalColor:new('B'),
    [3] = CrystalColor:new('C'),
    [4] = CrystalColor:new('D'),
    [5] = CrystalColor:new('E'),
    [6] = CrystalColor:new('F'),
}

DestructionTypesEnum = {
    Line = 1,
}

UserCommandsEnum = {
    Move = 'm',
    Exit = 'q',
}

MoveDirectionEnum = {
    Left = 'l',
    Right = 'r',
    Up = 'u',
    Down = 'd'
}
