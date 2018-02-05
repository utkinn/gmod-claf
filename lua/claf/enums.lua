--Creates an enum.
function Enum(...)
    local enum = {}

    for constantValue = 1, #... do
        enum[...[constantValue]] = constantValue
    end

    return enum
end

--Creates a flag set.
function Flags(...)
    local flagSet = {}
    local currentFlagValue = 1

    for _, flagName in pairs(...) do
        flagSet[flagName] = currentFlagValue
        currentFlagValue = currentFlagValue * 2
    end

    return flagSet
end
