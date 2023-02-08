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

local statusCodes = {}

local inverseStart = '\x1b[7m\x1b[1m'
local resetColors = '\x1b[0C\x1b[0m'

local function printTaskBanner(taskName)
    local bannerLenght = 60
    local taskHeading = ' Task "' .. taskName .. '"'
    local paddingLenght = bannerLenght - #taskHeading - 1
    print(
        '\n'
        .. inverseStart
        .. taskHeading
        .. string.rep(' ', paddingLenght)
        .. '\xc2\xa0'
        .. resetColors
        .. '\n'
    )
end

local function runTask(taskName)
    local taskDef = tasks[taskName]
    if not taskDef then
        error("Unknown task: " .. taskName)
    end
    if type(taskDef) == "table" then
        if type(taskDef.children) == "table" then
            for _, child in ipairs(taskDef.children) do
                runTask(child)
            end
        end
        for _, cmd in ipairs(taskDef) do
            printTaskBanner(taskName)
            local _, _, status = os.execute(cmd)
            statusCodes[cmd] = status
        end
    else
        printTaskBanner(taskName)
        local _, _, status = os.execute(taskDef)
        statusCodes[taskDef] = status
    end
end

for _, taskToRun in ipairs(arg) do
    runTask(taskToRun)
end

local boldRedStart = '\x1b[1;31m'

local fail = false
print('\n')
for cmd, status in pairs(statusCodes) do
    if status ~= 0 then
        print(boldRedStart .. 'Command "' .. cmd .. '" failed with status ' .. status .. '.' .. resetColors)
        fail = true
    end
end

if fail then
    os.exit(1)
end
