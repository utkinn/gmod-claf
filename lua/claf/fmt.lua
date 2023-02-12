local mod = {}

local deprecationWarnsIssued = 0
-- Deprecated
function mod.f(str)
    if deprecationWarnsIssued < 10 then
        MsgC(Color(255, 255, 0), "[CLAF] f() is deprecated. Use fmt() instead.")
        deprecationWarnsIssued = deprecationWarnsIssued + 1
    end
    return mod.fmt(str)
end

local function evalVarInCallerScope(name, stackFramesToGoUp)
    for i = 1, math.huge do
        local n, v = debug.getlocal(stackFramesToGoUp, i)
        if n == nil then
            -- Ran out of locals, give a global with this name a shot
            return _G[name]
        end
        if n == name then
            return v
        end
    end
end

local function evaluateTableMember(expr)
    local stackFramesToGoUp = 5

    local exprParts = string.Explode(".", expr)
    local value = evalVarInCallerScope(exprParts[1], stackFramesToGoUp)
    table.remove(exprParts, 1)
    for _, part in ipairs(exprParts) do
        value = value[part]
    end

    return value
end

local function evaluatePattern(pattern)
    local stackFramesToGoUp = 4

    local patternWithoutBraces = string.sub(pattern, 2, -2)
    local value
    if string.match(patternWithoutBraces, "%.") then
        value = evaluateTableMember(patternWithoutBraces)
    else
        value = evalVarInCallerScope(patternWithoutBraces, stackFramesToGoUp)
    end

    if value == nil then
        value = "nil"
    end

    return value
end

function mod.fmt(str)
    -- ESCAPE_PLACEHOLDER_* contain exotic Unicode characters from Private Use Area block
    -- (https://en.wikipedia.org/wiki/Private_Use_Areas).
    -- Since their purpose is not defined, they are not likely to be used in any input.
    local ESCAPE_PLACEHOLDER_BEGIN = "" -- U+E000
    local ESCAPE_PLACEHOLDER_END = "" -- U+E001

    -- Lua patterns don't support lookbehind and lookahead, so as a workaround
    -- we replace escaped brackets with a placeholder and then restore them
    -- after the substitution.
    str = string.Replace(str, "{{", ESCAPE_PLACEHOLDER_BEGIN)
    str = string.Replace(str, "}}", ESCAPE_PLACEHOLDER_END)

    for pattern in string.gmatch(str, "{.-}") do
        str = string.Replace(str, pattern, evaluatePattern(pattern))
    end

    str = string.Replace(str, ESCAPE_PLACEHOLDER_END, "}")
    str = string.Replace(str, ESCAPE_PLACEHOLDER_BEGIN, "{")

    return str
end

return mod
