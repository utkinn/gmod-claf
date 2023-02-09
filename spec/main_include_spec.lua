require('spec/gmod_polyfills')

local function detectOs()
    return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

local function getLsCommand(path)
    return detectOs() == "unix" and 'ls -A "'..path..'"' or 'dir "'..path..'" /b /ad'
end

local function listDir(path)
    local i = 0
    local t = {}
    local pfile = io.popen(getLsCommand(path))

    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    
    pfile:close()
    return t
end

describe('claf.lua', function()
    it('exposes all CLAF functions in _G when included', function()
        _G.FindMetaTable = function() return {} end
        _G.net = {}
        local includeSpy = spy.on(_G, 'include')

        include 'claf.lua'

        assert.is_function(_G.All)

        local clafModules = listDir('lua/includes/modules/claf')
        for _, mod in ipairs(clafModules) do
            assert.spy(includeSpy).was.called_with('includes/modules/claf/' .. mod)
        end
    end)
end)
