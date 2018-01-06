-- Aliases for standard functions.
-- Some standard functions have bad names, so aliases are created for them.

local entityMetaTable = FindMetaTable('Entity')
-- Alias for Entity:Health().
function entityMetaTable:GetHealth()
    return self:Health()
end
