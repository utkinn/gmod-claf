require("spec/gmod_polyfills")

local function detectOs()
    return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

local function getLsCommand(path)
    return detectOs() == "unix" and "ls -A \"" .. path .. "\"" or "dir \"" ..
               path .. "\" /b /ad"
end

local function ensureLua52OrGreater()
    local major, minor = _VERSION:match("Lua (%d+)%.(%d+)")
    assert(tonumber(major) >= 5 and tonumber(minor) >= 2,
           "Lua 5.2 or greater is required to run this test")
end

local function listDir(path)
    -- Lua 5.1's file:close() does not return the exit code of the command,
    -- so we can't check if the command failed.
    ensureLua52OrGreater()

    local i = 0
    local t = {}
    local pfile = io.popen(getLsCommand(path))

    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end

    local _, _, exitCode = pfile:close()
    assert(exitCode == 0, "Failed to list directory: " .. path)
    return t
end

describe("claf.lua", function()
    it("exposes all CLAF functions in _G when included", function()
        _G.FindMetaTable = function()
            return {}
        end
        _G.net = {}
        local includeSpy = spy.on(_G, "include")

        include "claf.lua"

        assert.is_function(_G.All)

        local clafModules = listDir("lua/claf")
        for _, mod in ipairs(clafModules) do
            assert.spy(includeSpy).was.called_with("claf/" .. mod)
        end
    end)
end)
