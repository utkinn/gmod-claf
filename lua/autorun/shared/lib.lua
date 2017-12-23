--Free ID for automatic hook name
CLAF_hookAutoNameID = 1

--Throws an error if the passed argument is nil.
function ErrorIfNil(any)
    if any == nil then
        error(any .. " shouldn't be nil")
end

--Quick hook creation function.
function Hook(event, callback, ID)
    if ID == nil then
        ID = "CLAF_" .. CLAF_hookAutoNameID
        CLAF_hookAutoNameID = CLAF_hookAutoNameID + 1
    end

    hook.Add(event, ID, callback)
end
