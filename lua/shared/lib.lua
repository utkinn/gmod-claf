-- Some utility functions.

-- Free ID for automatic hook name.
local CLAF_hookAutoNameID = 1

-- Always creates an error 'not implemented'.
function TODO(reason)
    if reason then
        error('not implemented: '..reason)
    else
        error('not implemented')
    end
end

-- Throws an error if the passed argument is nil.
function ErrorIfNil(any)
    if any == nil then error('nil is not allowed here') end
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
        WriteMessageDataPiece(v)
    end
end

net.Write = function(piece)
    ErrorIfNil(piece)
    if isnumber(piece) then
        TODO()
    elseif isbool(piece) then
        net.WriteBool(piece)
    elseif isstring(piece) then
        net.WriteString(piece)
    elseif isentity(piece) then
        net.WriteEntity(piece)
    elseif istable(piece) then
        net.WriteTable(piece)
    end
    -- TODO('more types')
end

function QuickNetMessage(networkString, receiver, ...)
    if SERVER then
        ErrorIfNil(receiver)
    end

    net.Start(networkString)
        WriteMessageData(arg)
    if SERVER then
        net.Send(receiver)
    else    -- Clientside
        net.SendToServer()
    end
end
