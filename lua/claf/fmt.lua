local f_deprecation_warns = 0
-- Deprecated
function f(str)
    if f_deprecation_warns < 10 then
        MsgC(Color(255, 255, 0), '[CLAF] f() is deprecated. Use fmt() instead.')
        f_deprecation_warns = f_deprecation_warns + 1
    end
    return fmt(str)
end

function fmt(str)
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
        local value
        if locals[varNameWithoutBraces] ~= nil then
            value = locals[varNameWithoutBraces]
        else
            value = _G[varNameWithoutBraces]
        end

        -- Textual representation for nil
        if value == nil then
            value = 'nil'
        end
        str = string.Replace(str, varName, value)
    end

    -- Restoring escaped brackets
    str = string.Replace(str, ESCAPE_PLACEHOLDER_END, '}')
    str = string.Replace(str, ESCAPE_PLACEHOLDER_BEGIN, '{')

    return str
end
