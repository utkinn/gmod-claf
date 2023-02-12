local fn = include("claf/functional.lua")

local mod = {}

local numbers = string.ToTable("1234567890")
local allowedIdentifierSymbols = string.ToTable(
                                     "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890")

local function isBadIdentifierChar(c)
    return not fn.Includes(allowedIdentifierSymbols, c)
end

local function checkName(name)
    if #name == 0 then
        error "empty identifier"
    end

    if fn.Includes(numbers, name:sub(1, 1)) then
        error "identifier cannot start with a number"
    end

    if fn.Any(name:sub(1):ToTable(), isBadIdentifierChar) then
        error "invalid character in identifier"
    end
end

local function generateEnumOrFlagSet(constants, nextValue)
    if not istable(constants) then
        error "\"constants\" must be a table of strings"
    end
    local enum = {}

    local value = 1
    for _, name in pairs(constants) do
        checkName(name)
        if not isstring(name) then
            error "\"constants\" must be a table of strings"
        end
        enum[name] = value
        value = nextValue(value)
    end

    return enum
end

-- Creates an enum.
function mod.Enum(constants)
    return generateEnumOrFlagSet(constants, function(value)
        return value + 1
    end)
end

-- Creates a flag set.
function mod.Flags(constants)
    return generateEnumOrFlagSet(constants, function(value)
        return value * 2
    end)
end

return mod
