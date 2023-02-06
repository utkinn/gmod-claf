local pipeClass = {}

local function pipeIndex(self, funcName)
    return function(_self, ...)
        local transformFunction = _G[funcName]
        if transformFunction == nil then
            error('Pipe: ' .. funcName .. ' is not a valid method')
        end

        local result = transformFunction(self.value, ...)

        if istable(result) then
            self.value = result
        else
            return result
        end
        return self
    end
end

function Pipe(source)
    return setmetatable(
        { value = source, ToTable = function(self) return self.value end }, 
        { 
            __index = pipeIndex, 
            __tostring = function(self)
                return 'PipeObj with ' .. tostring(self.value)
            end
        }
    )
end
