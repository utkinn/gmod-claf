local mod = {}

local f_deprecation_warns = 0
-- Deprecated
function mod.f(str)
    if f_deprecation_warns < 10 then
        MsgC(Color(255, 255, 0), '[CLAF] f() is deprecated. Use fmt() instead.')
        f_deprecation_warns = f_deprecation_warns + 1
    end
    return mod.fmt(str)
end

-- TODO: refactor
function mod.fmt(str)
    -- ESCAPE_PLACEHOLDER_* are NOT empty. They actually contain "object replacement characters" (U+FFFC).
    -- "{{" is replaced with one symbol, "}}" is replaced with two symbols.
    -- U+FFFC was chosen because it wouldn't be used by anyone very likely.
    local ESCAPE_PLACEHOLDER_BEGIN = '￼'  -- U+FFFC, x1
    local ESCAPE_PLACEHOLDER_END = '￼￼'  -- U+FFFC, x2

    -- Replacing escaped curly brackets ("{{" and "}}") with escape placeholders.
    str = string.Replace(str, '{{', ESCAPE_PLACEHOLDER_BEGIN)
    str = string.Replace(str, '}}', ESCAPE_PLACEHOLDER_END)

    -- Table of variable names to substitute
    local variableNamesIter = string.gmatch(str, '{.-}')
    local variableNames = {}
    for v in variableNamesIter do
        table.insert(variableNames, v)
    end

    -- Looking through this function caller's locals
    local name, value
    local locals = {}
    local i = 1
    while true do
        name, value = debug.getlocal(2, i)
        if name == nil then break end
        locals[name] = value
        i = i + 1
    end

    for _, varName in pairs(variableNames) do
        local varNameWithoutBraces = string.sub(varName, 2, -2)
        local value2
        if string.match(varNameWithoutBraces, '%.') then
            local varNameParts = string.Explode('.', varNameWithoutBraces)
            if locals[varNameParts[1]] ~= nil then
                value2 = locals[varNameParts[1]]
            else
                value2 = _G[varNameParts[1]]
            end
            table.remove(varNameParts, 1)
            for _, part in pairs(varNameParts) do
                value2 = value2[part]
            end
        elseif locals[varNameWithoutBraces] ~= nil then
            value2 = locals[varNameWithoutBraces]
        else
            value2 = _G[varNameWithoutBraces]
        end

        -- Textual representation for nil
        if value2 == nil then
            value2 = 'nil'
        end
        str = string.Replace(str, varName, value2)
    end

    -- Restoring escaped brackets
    str = string.Replace(str, ESCAPE_PLACEHOLDER_END, '}')
    str = string.Replace(str, ESCAPE_PLACEHOLDER_BEGIN, '{')

    return str
end

return mod
