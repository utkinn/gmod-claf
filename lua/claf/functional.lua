-- Means of functional programming.

local mod = {}

-- Applies "editor" function to all elements of the provided table.
-- If "editor" is a string, it will be used as a key to select a value from each element.
function mod.Map(source, editor)
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
function mod.Filter(source, predicate)
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
function mod.FilterKeyed(source, predicate)
    local filtered = {}
    if predicate == nil then
        predicate = function(_, v) return tobool(v) end
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
function mod.Reduce(source, reducer, initial)
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
function mod.Sum(source)
    return mod.Reduce(source, function(a, b) return a + b end, 0)
end

-- Returns true if any value in the table matches the given predicate.
function mod.Any(source, predicate)
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

function mod.None(source, predicate)
    return not mod.Any(source, predicate)
end

-- Returns true if all values in the table matches the given predicate.
function mod.All(source, predicate)
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

function mod.Count(source, predicate)
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

function mod.One(source, predicate)
    return mod.Count(source, predicate) == 1
end

function mod.Few(source, predicate)
    return mod.Count(source, predicate) > 1
end

-- Given a table of tables, returns a new table with all the elements of the provided tables.
function mod.Flatten(source)
    local flattened = {}

    for _, v in ipairs(source) do
        if istable(v) then
            for _, v2 in ipairs(v) do
                table.insert(flattened, v2)
            end
        else
            table.insert(flattened, v)
        end
    end

    return flattened
end

function mod.Zip(tables)   -- TODO: Support for different lenghts
    if #tables == 1 then return tables[1] end

    if not mod.All(tables, function(x) return table.IsSequential(x) end) then error 'some tables are not sequential' end

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

function mod.Try(try, catch, finally)
    if istable(try) then
        try, catch, finally = try[1], try.catch, try.finally
    end

    local noErrors, message = pcall(try)
    if catch ~= nil and not noErrors then catch(message) end
    if finally ~= nil then finally() end
end

-- TODO: Keys
function mod.Max(source)
    local sorted = table.Copy(source)
    table.sort(sorted)
    return sorted[#sorted]
end

function mod.Min(source)
    local sorted = table.Copy(source)
    table.sort(sorted)
    return sorted[1]
end

function mod.Take(source, n)
    local taken = {}
    for i = 1, n do
        table.insert(taken, source[i])
    end
    return taken
end

function mod.TakeRight(source, n)
    local taken = {}
    for i = #source - n + 1, #source do
        table.insert(taken, source[i])
    end
    return taken
end

function mod.TakeWhile(source, predicate)
    local taken = {}
    for _, v in ipairs(source) do
        if predicate(v) then
            table.insert(taken, v)
        else
            break
        end
    end
    return taken
end

function mod.TakeRightWhile(source, predicate)
    local taken = {}
    for i = #source, 1, -1 do
        if predicate(source[i]) then
            table.insert(taken, source[i])
        else
            break
        end
    end
    return table.Reverse(taken)
end

function mod.Drop(source, n)
    local dropped = {}
    for i = n + 1, #source do
        table.insert(dropped, source[i])
    end
    return dropped
end

function mod.DropRight(source, n)
    local dropped = {}
    for i = 1, #source - n do
        table.insert(dropped, source[i])
    end
    return dropped
end

function mod.DropWhile(source, predicate)
    local result = {}
    for i = 1, #source do
        if not predicate(source[i]) then
            table.insert(result, source[i])
        end
    end
    return result
end

function mod.DropRightWhile(source, predicate)
    local result = table.Copy(source)
    for i = #result, 1, -1 do
        if predicate(result[i]) then
            result[i] = nil
        else
            break
        end
    end
    return result
end

function mod.First(source)
    return source[1]
end

function mod.Last(source)
    return source[#source]
end

function mod.Sorted(source, sorter)
    local sorted = table.Copy(source)
    table.sort(sorted, sorter)
    return sorted
end

function mod.SortedDesc(source, sorter)
    local sorted = table.Copy(source)
    table.sort(sorted, sorter)
    return table.Reverse(sorted)
end

mod.Reversed = table.Reverse

function mod.Includes(source, x)
    for _, v in ipairs(source) do
        if v == x then
            return true
        end
    end
    return false
end

return mod
