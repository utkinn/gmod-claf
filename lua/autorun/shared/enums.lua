--Creates an enum.
function Enum(constantNames)
    local enum = {}

    for constantValue = 1, #constantNames do
        enum[constantNames[constantValue]] = constantValue
    end

    return enum
end

--Creates a flag set.
function Flags(flagsNames)
    local flagSet = {}
    local currentFlagValue = 1

    for _, flagName in pairs(flagsNames) do
        flagSet[flagName] = currentFlagValue
        currentFlagValue = currentFlagValue * 2
    end

    return flagSet
end
