-- Means of functional programming.

-- Applies "editor" function to all elements of the provided table.
function Map(source, editor)
    local modified = table.Copy(source)

    -- Applying editor function to all tables
    for k, v in pairs(modified) do -- Iterating through keys and values
        modified[k] = editor(v)
    end

    return modified
end

-- Filters the provided tables.
function Filter(source, predicate)
    local filtered = {}
    if predicate == nil then
        predicate = function(x) return tobool(x) end
    end

    -- Applying editor function to all tables
    for _, v in ipairs(source) do -- Iterating through keys and values
        if predicate(v) then
            table.insert(filtered, v)
        end
    end

    end
end

-- Returns true if any value in the table matches the given predicate.
function Any(source, predicate)
    if predicate == nil then
        predicate = function(x) return tobool(x) end
    end

    for _, v in pairs(source) do
        if predicate(v) then
            return true
        end
    end

    return false
end

function None(source, predicate)
    return not Any(source, predicate)
end

-- Returns true if all values in the table matches the given predicate.
function All(source, predicate)
    if predicate == nil then
        predicate = function(x) return tobool(x) end
    end

    for _, v in pairs(source) do
        if not predicate(v) then
            return false
        end
    end

    return true
end

function Count(source, predicate)
    if predicate == nil then
        predicate = function(x) return tobool(x) end
    end

    local count = 0
    for _, v in pairs(source) do
        if predicate(v) then
            count = count + 1
        end
    end

    return count
end

function One(source, predicate)
    return Count(source, predicate) == 1
end

function Few(source, predicate)
    return Count(source, predicate) > 1
end

function Zip(tables)   -- TODO: Support for different lenghts
    if #tables == 1 then return tables[1] end

    if not All(tables, function(x) return table.IsSequential(x) end) then error 'some tables are not sequential' end

    local zip = {}

    for i = 1, #tables[1] do
        local container = {}
        for _, tbl in ipairs(tables) do
            table.insert(container, tbl[i])
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
function Max(source)
    local sorted = table.Copy(source)
    table.sort(sorted)
    return sorted[#sorted]
end

function Min(source)
    local sorted = table.Copy(source)
    table.sort(sorted)
    return sorted[1]
end
