-- Some utility functions.

-- Free ID for automatic hook name.
local CLAF_hookAutoNameID = 1

-- Always creates an error 'not implemented'.
function TODO(reason)
    if reason ~= nil then
        error('not implemented: '..reason)
    else
        error 'not implemented'
    end
end

-- Throws an error if the passed argument is nil.
function ErrorIfNil(any)
    if any == nil then error 'nil is not allowed here' end
end

-- Quick hook creation function.
function Hook(event, callback, ID)
    if ID == nil then
        ID = 'CLAFHook_'..CLAF_hookAutoNameID
        CLAF_hookAutoNameID = CLAF_hookAutoNameID + 1
    end

    hook.Add(event, ID, callback)
end

-- Sends a quick net message to the opposite side.
function Signal(networkString, receiver)
    if SERVER then
        ErrorIfNil(receiver)
        net.Start(networkString)
        net.Send(receiver)
    else    -- Clientside
        net.Start(networkString)
        net.SendToServer()
    end
end

local function WriteMessageData(data)
    for _, v in pairs(data) do
        net.Write(v)
    end
end

net.Write = net.WriteType
net.Read = net.ReadType

if SERVER then
    function net.QuickMsg(networkString, receiver, data)
        ErrorIfNil(receiver)

        net.Start(networkString)
        if istable(data) then
            WriteMessageData(data)
        else
            net.Write(data)
        end
        net.Send(receiver)
    end
else
    function net.QuickMsg(networkString, data)
        net.Start(networkString)
        if istable(data) then
            WriteMessageData(data)
        else
            net.Write(data)
        end
        net.SendToServer()
    end
end

-- Returns true if x is even, false otherwise.
function IsEven(x)
    return x % 2 == 0
end

-- Returns true if x is odd, false otherwise.
function IsOdd(x)
    return x % 2 != 0
end

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

    return str
end
