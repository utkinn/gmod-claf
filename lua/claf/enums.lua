-- Creates an enum.
function Enum(...)
    local enum = {}
    local arg = ...

    for constantValue = 1, #arg do
        enum[arg[constantValue]] = constantValue
    end

    return enum
end

-- Creates a flag set.
function Flags(...)
    local flagSet = {}
    local currentFlagValue = 1
    local arg = ...

    for _, flagName in pairs(...) do
        flagSet[flagName] = currentFlagValue
        currentFlagValue = currentFlagValue * 2
    end

    return flagSet
end
