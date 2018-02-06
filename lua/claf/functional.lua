-- Means of functional programming.

-- Applies "editor" function to all elements of provided tables.
function Map(editor, ...)
    local tables = table.Copy(...)  -- Copying vararg

    -- Applying editor function to all tables
    for _, table in pairs(tables) do   -- Iterating through tables
        for k, v in pairs(table) do -- Iterating through keys and values
            table[k] = editor(v)
        end
    end

    -- If there is one table, return it.
    -- Otherwise, return a table of tables.
    if #tables == 1 then
        return tables[1]
    else
        return tables
    end
end

-- Filters the provided tables.
function Filter(predicate, ...)
    local tables = table.Copy(...)  -- Copying vararg

    -- Applying editor function to all tables
    for _, table in pairs(tables) do   -- Iterating through tables
        for k, v in pairs(table) do -- Iterating through keys and values
            if not predicate(v) then
                table[k] = nil  -- Remove the value if the predicate returns false
            end
        end
    end

    -- If there is one table, return it.
    -- Otherwise, return a table of tables.
    if #tables == 1 then
        return tables[1]
    else
        return tables
    end
end

-- Returns true if any value in the table matches the given predicate.
function Any(table, predicate)
    if predicate == nil then
        predicate = function(x) return tobool(x) end
    end

    for _, v in pairs(table) do
        if predicate(v) then
            return true
        end
    end

    return false
end

-- Returns true if all values in the table matches the given predicate.
function All(table, predicate)
    if predicate == nil then
        predicate = function(x) return tobool(x) end
    end

    for _, v in pairs(table) do
        if not predicate(v) then
            return false
        end
    end

    return true
end

function Zip(...)   -- TODO: Support for different lenghts
    local tables = table.Copy(...)  -- Copying vararg

    if #tables == 1 then return tables[1] end
    if not All(function(x) table.IsSequential(x) end, unpack(tables)) then error 'some tables are not sequential' end

    local zip = {}

    for i = 1, #tables[1] do
        local container = {}
        for _, table in pairs(tables) do
            table.insert(table[i])
        end
        table.insert(zip, container)
    end

    return zip
end

function Try(try, catch, finally)
    local noErrors, message = pcall(try)
    if catch ~= nil and not noErrors then catch(message) end
    if finally ~= nil then finally() end
end

-- TODO: Keys
function Max(table)
    local sorted = table.Copy(table)
    table.sort(sorted)
    return sorted[#sorted]
end

function Min(table)
    local sorted = table.Copy(table)
    table.sort(sorted)
    return sorted[1]
end
