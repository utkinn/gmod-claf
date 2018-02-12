-- Some utility functions.

-- Free ID for automatic hook name.
local CLAF_hookAutoNameID = 1

-- Always creates an error 'not implemented'.
function TODO(reason)
    if reason ~= nil then
        error 'not implemented: '..reason
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
    function net.QuickMsg(networkString, receiver, ...)
        ErrorIfNil(receiver)

        net.Start(networkString)
        WriteMessageData(arg)
        net.Send(receiver)
    end
else
    function net.QuickMsg(networkString, ...)
        net.Start(networkString)
        WriteMessageData(arg)
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
