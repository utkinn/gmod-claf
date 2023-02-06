-- Means of functional programming.

-- Applies "editor" function to all elements of the provided table.
-- If "editor" is a string, it will be used as a key to select a value from each element.
function Map(source, editor)
    local modified = table.Copy(source)

    if isstring(editor) then
        local key = editor
        editor = function(x) return x[key] end
    end

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

    return filtered
end

-- Filters the provided keyed (non-sequential) tables.
function FilterKeyed(source, predicate)
    local filtered = {}
    if predicate == nil then
        predicate = function(k, v) return tobool(v) end
    end

    -- Applying editor function to all tables
    for k, v in pairs(source) do -- Iterating through keys and values
        if predicate(k, v) then
            filtered[k] = v
        end
    end

    return filtered
end

-- Executes the `reducer` callback function on each element of the table, 
-- in order, passing in the return value from the calculation on the preceding element. 
-- The final result of running the reducer across all elements of the array is a single value.
--
-- If `initial` is provided, it will be used as the initial value of the accumulator.
-- Otherwise `initial` is assumed to be `source[1]`.
function Reduce(source, reducer, initial)
    local sourceCopy = table.Copy(source)

    if initial == nil and #sourceCopy == 0 then
        return nil
    end

    if initial == nil then
        initial = source[1]
        table.remove(sourceCopy, 1)
    end
    local reduced = initial

    for _, v in ipairs(sourceCopy) do
        reduced = reducer(reduced, v)
    end

    return reduced
end

-- Returns the sum of all values in the table.
function Sum(source)
    return Reduce(source, function(a, b) return a + b end, 0)
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

-- Given a table of tables, returns a new table with all the elements of the provided tables.
function Flatten(source)
    local flattened = {}

    for _, v in ipairs(source) do
        for _, v2 in ipairs(v) do
            table.insert(flattened, v2)
        end
    end

    return flattened
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
    if istable(try) then
        try, catch, finally = try[1], try.catch, try.finally
    end

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
