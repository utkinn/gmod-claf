function isfunction(x)
    return type(x) == "function"
end

function istable(x)
    return type(x) == "table"
end

function isstring(x)
    return type(x) == "string"
end

function string.StartWith(inp, start)
    return string.sub(inp, 1, string.len(start)) == start
end

function string.Replace(str, find, replace)
    return string.gsub(str, find, replace)
end

function string.Explode(sep, str)
    local result = {}
    local regex = ("([^%s]+)"):format(sep)
    for each in str:gmatch(regex) do
        table.insert(result, each)
    end
    return result
end

bit = bit32  -- luacheck: globals bit32

function table.Copy(t)
    local copy = {}
    for k, v in pairs(t) do
        if istable(v) then
            copy[k] = table.Copy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function tobool(x)
    local falsyValues = {
        [false] = true,
        ["false"] = true,
        [0] = true,
        ["0"] = true,
    }
    return x ~= nil and not falsyValues[x]
end

function table.IsSequential(t)
	local i = 1
	for _, _ in pairs(t) do
		if t[i] == nil then
            return false
        end
		i = i + 1
	end
	return true
end

function table.Merge(dest, source)
    for k, v in pairs(source) do
        if istable(v) then
            if istable(dest[k]) then
                table.Merge(dest[k], source[k])
            else
                dest[k] = table.Copy(v)
            end
        else
            dest[k] = v
        end
    end
    return dest
end
