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

bit = bit32

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
	for key, value in pairs(t) do
		if t[i] == nil then
            return false
        end
		i = i + 1
	end
	return true
end