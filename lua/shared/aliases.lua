-- Aliases for standard functions.
-- Some standard functions have bad names, so aliases are created for them.

local entityMetaTable = FindMetaTable('Entity')

-- Alias for Entity:Health().
function entityMetaTable:GetHealth()
    return self:Health()
end

local playerMetaTable = FindMetaTable('Player')

-- Alias for Player:Alive().
function playerMetaTable:IsAlive()
    return self:Alive()
end

-- Alias for Player:Armor().
function playerMetaTable:GetArmor()
    return self:Armor()
end

-- Runs a piece of Lua code.
function Run(code)
    RunString(code)
end
