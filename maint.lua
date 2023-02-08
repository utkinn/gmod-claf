#!/usr/bin/env lua

local function detectOs()
    return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

local rmF = detectOs() == "win" and "del /q" or "rm -f"

local tasks = {
    test = "busted",
    cover = { rmF .. " luacov.*", "busted -c", "luacov" },
    lint = "luacheck .",
    ci = { children = { "test", "lint" } }
}

local function runTask(taskName)
    local taskDef = tasks[taskName]
    if not taskDef then
        error("Unknown taskName: " .. taskName)
    end
    if type(taskDef) == "table" then
        if type(taskDef.children) == "table" then
            for _, child in ipairs(taskDef.children) do
                runTask(child)
            end
        end
        for _, cmd in ipairs(taskDef) do
            os.execute(cmd)
        end
    else
        os.execute(taskDef)
    end
end

for _, taskToRun in ipairs(arg) do
    runTask(taskToRun)
end
