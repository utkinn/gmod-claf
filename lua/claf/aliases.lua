-- Aliases for standard functions.
-- Some standard functions have bad names, so aliases are created for them.
local entityMetaTable = FindMetaTable "Entity"

entityMetaTable.GetHealth = entityMetaTable.Health

local playerMetaTable = FindMetaTable "Player"

playerMetaTable.IsAlive = playerMetaTable.Alive
playerMetaTable.GetArmor = playerMetaTable.Armor

-- Runs a piece of Lua code.
Run = RunString
