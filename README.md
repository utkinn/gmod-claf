# CLAF
![CLAF Logo](logos/logo-250x250.png)
# Library for Garry's Mod addons

CLAF is a set of wrappers and libraries for the standard API which makes the Garry's Mod addons development easier.  
See [wiki](https://github.com/javabird25/gmod-claf/wiki) for the documentation.

# Why to use?
CLAF provides functional programming, aliases and shortcuts for the standard API to make the addon programming easier.

# Features
## Functional programming
Quickly modify tables with functional programming features:

```lua
-- Filtering numbers in traditional way...
local numbers = { 1, 2, 3, 4, 5 }
for k, number in pairs(numbers) do
    if number % 2 != 0 then
        numbers[k] = nil
    end
end

-- ...and in functional way

local numbers = { 1, 2, 3, 4, 5 }
numbers = Filter(numbers, function(x) return IsOdd(x) end)
```

```lua
local inp = {
    { { x = 1 }, { x = 2 } },
    { { x = 3 }, { x = 4 } },
}

local result = Pipe(inp)
    :Flatten()
    :Map('x')
    :Sum()

assert(result == 10)
```

## Popular language features simulation
### Try-catch
Run code that can cause errors in `Try()`:

```lua
Try(function()
    -- some error-potential code
end,
-- error handler
function(errorMessage)
    print('something went wrong: '..errorMessage)
end)
```

### Enums and flags
```lua
LiquidType = Enum { 'WATER', 'LAVA', 'OIL' }
bottle = { liquid = LiquidType.WATER }
```

```lua
Settings = Flags { 'SHOW_WELCOME', 'SHOW_HELP', 'SHOW_HINTS' }

-- Combining flags
userSettings = bit.bor(Settings.SHOW_WELCOME, Settings.SHOW_HELP)

-- Reading flags
welcome = bit.band(userSettings, Settings.SHOW_WELCOME) -- true
help = bit.band(userSettings, Settings.SHOW_HELP)    -- true
hints = bit.band(userSettings, Settings.SHOW_HINTS) -- false
```

## String interpolation
Easily insert variables' values into strings using the **string interpolation**:
```lua
local name = 'John'
str = fmt'My name is {name}'
-- 'My name is John'
```

# How to use?
## While the addon development
1. Subscribe to [CLAF addon in Steam Workshop](http://steamcommunity.com/sharedfiles/filedetails/?id=1302107512).
2. Add the following line to the beginning of the source files where CLAF is used:
```lua
include 'claf.lua'
```

## When it's time to publish
Add dependency of [CLAF Steam Workshop addon](http://steamcommunity.com/sharedfiles/filedetails/?id=1302107512) on your addon.
Alternatively, you can copy the library files into your addon, but don't forget to include a license notice (see [LICENSE](LICENSE)).

# Setting up for development

1. Install [WSL](https://learn.microsoft.com/en-us/windows/wsl/) or [MinGW](https://www.mingw-w64.org/), because running Lua natively on Windows is sort of a nightmare.
2. Install Lua.

   For WSL (assuming you have Ubuntu chosen as your WSL distribution):
   ```sh
   sudo apt install lua5.2
   ```

   For MinGW:
   ```sh
   pacman -S mingw-w64-x86_64-lua
   ```

3. Clone the repository.
4. Install [LuaRocks](https://luarocks.org/).

   For WSL (assuming you have Ubuntu chosen as your WSL distribution):
   ```sh
   sudo apt install luarocks
   ```

   For MinGW:
   ```sh
   pacman -S mingw-w64-lua-luarocks
   ```

5. Run `lua maint.lua prepare-dev` in the root directory of the project. This will install development dependencies such as tools for formatting, testing and linting the code.

# `maint.lua`
`maint.lua` is a script that helps with the development of the library. It can be used to run tests, format the code, etc.  
It can be invoked by running `lua maint.lua <command>` in the root directory of the project, where `<command>` is one of the following:

* `prepare-dev` - installs development dependencies.
* `test` - runs tests.
* `cover` - runs tests and generates a coverage report.
* `lint` - runs linter.
* `format` - formats the code.
* `format-check` - checks if the code is formatted correctly.
* `ci` - runs all the checks that are run on the CI server. If the command fails, it means that the code is not ready to be committed.
