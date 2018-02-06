include 'claf.lua'

-- Unit tests.

if not GetConVar('developer'):GetBool() then return end

local tests = {
    --- Alias tests ---

    -- Alias "GetHealth"
    function()
        local health = Entity(1):Health()
        local getHealth = Entity(1):GetHealth()

        assert(health == getHealth)
    end,
    -- Alias "IsAlive"
    function()
        local alive = Player(1):Alive()
        local isAlive = Player(1):IsAlive()

        assert(alive == isAlive)
    end,
    -- Alias "GetArmor"
    function()
        local armor = Player(1):Armor()
        local getArmor = Player(1):GetArmor()

        assert(armor == getArmor)
    end,
    -- Alias "Run"
    function()
        Run 'x_ = 1'

        assert(x_ == 1)
    end,

    --- Enums and Flags tests ---

    -- Enum structure
    function()
        local color = Enum('RED', 'GREEN', 'BLUE')

        assertNotNil(color.RED)
        assertNotNil(color.GREEN)
        assertNotNil(color.BLUE)
    end,
    -- Flag structure
    function()
        local color = Flags('RED', 'GREEN', 'BLUE')

        assertNotNil(color.RED)
        assertNotNil(color.GREEN)
        assertNotNil(color.BLUE)
    end,
    -- Empty enum
    function()
        local empty = Enum()
        assert(#empty == 0)
    end,
    -- Empty flag set
    function()
        local empty = Flags()
        assert(#empty == 0)
    end,
    -- Incorrect enum constant names
    function()
        assertError(Enum('RED.smth'))
        assertError(Enum('4abc'))
        assertError(Enum('!@#$%^&*'))
        assertError(Enum('smth()'))
        assertError(Enum('"'))
        assertError(Enum(''))
        assertError(Enum('_4'))
        assertError(Enum('__'))
        assertError(Enum('_a'))
    end,
    -- Incorrect flag constant names
    function()
        assertError(Flags('RED.smth'))
        assertError(Flags('4abc'))
        assertError(Flags('!@#$%^&*'))
        assertError(Flags('smth()'))
        assertError(Flags('"'))
        assertError(Flags(''))
        assertError(Flags('_4'))
        assertError(Flags('__'))
        assertError(Flags('_a'))
    end,
    -- Flag batching
    function()
        local color = Flags('RED', 'GREEN', 'BLUE')

        local greenAndBlue = bit.bor(color.GREEN, color.BLUE)
        -- RED                  1   001
        -- GREEN                2   010
        -- BLUE                 4   100
        -- bit.bor(GREEN, BLUE) 6   110
        assert(greenAndBlue == 6)
    end,

    --- Functional programming ---

    -- Map
    function()
        local numbers = {1, 2, 3, 4, 5}

        numbers = Map(function(x) return x * 2 end, numbers)

        assert(numbers[1] == 2)
        assert(numbers[2] == 4)
        assert(numbers[3] == 6)
        assert(numbers[4] == 8)
        assert(numbers[5] == 10)
    end,
    -- Mapping empty table
    function()
        local empty = {}

        local emptyToo = Map(function(x) x * 2 end, empty)

        assert(#emptyToo == 0)
    end,
    -- Filter
    function()
        local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

        numbers = Filter(function(x) return IsEven(x) end, numbers)

        assert(numbers[1] == 2)
        assert(numbers[2] == 4)
        assert(numbers[3] == 6)
        assert(numbers[4] == 8)
        assert(numbers[5] == 10)
    end,
    -- Filtering empty table
    function()
        local empty = {}

        local emptyToo = Filter(function(x) true end, empty)

        assert(#emptyToo == 0)
    end,
    -- Any
    function()
        local numbers = {2, 20, 100, 1}

        anyIsOdd = Any(numbers, function(x) return IsOdd(x) end)

        assert(anyIsOdd)
    end,
    -- Any without predicate
    function()
        local numbers = {true, false, false, true}

        any = Any(numbers)

        assert(any)
    end,
    -- Applying Any to empty table
    function()
        local empty = {}

        local shouldBeFalse = Any(empty)

        assertNot(shouldBeFalse)
    end,
    -- All
    function()
        local numbers = {2, 20, 100, 1}

        allIsOdd = All(numbers, function(x) return IsOdd(x) end)

        assertNot(allIsOdd)
    end,
    -- All without predicate
    function()
        local numbers = {true, true}

        all = All(numbers)

        assert(all)
    end,
    -- Applying All to empty table
    function()
        local empty = {}

        local shouldBeFalse = All(empty)

        assertNot(shouldBeFalse)
    end,

    --- Zip ---

    -- Same lenghts
    function()
        local a = {1, 2, 3}
        local b = {4, 5, 6}
        local c = {7, 8, 9}

        local zip = Zip(a, b, c)

        assert(zip[1][1] == 1)
        assert(zip[1][2] == 4)
        assert(zip[1][3] == 7)
        assert(zip[2][1] == 2)
        assert(zip[2][2] == 5)
        assert(zip[2][3] == 8)
        assert(zip[3][1] == 3)
        assert(zip[3][2] == 6)
        assert(zip[3][3] == 9)
    end,
    -- Different lenghts
    function()
        local a = {1, 2, 3}
        local b = {4, 5, 6, 7}
        local c = {8, 9, 10, 11, 12}

        local zip = Zip(a, b, c)

        assert(zip[1][1] == 1)
        assert(zip[1][2] == 4)
        assert(zip[1][3] == 8)
        assert(zip[2][1] == 2)
        assert(zip[2][2] == 5)
        assert(zip[2][3] == 9)
        assert(zip[3][1] == 3)
        assert(zip[3][2] == 6)
        assert(zip[3][3] == 10)
        assert(#zip == 3)
        assert(#zip[1] == 3)
        assert(#zip[2] == 3)
        assert(#zip[3] == 3)
    end,


    --- Try/catch ---

    -- Try + catch
    function()
        local x
        local wrong = function()
            Try(function()
                nil.foo = 1
            end,
            -- catch
            function()
                x = 2
            end)
        end

        assertNoError(wrong)
        assert(x == 2)
    end,
    -- Try (exception) + finally
    function()
        local x
        local wrong = function()
            Try(function()
                nil.foo = 1
            end,
            nil,
            -- finally
            function()
                x = 2
            end)
        end

        assertNoError(wrong)
        assert(x == 2)
    end,
    -- Try (no exception) + finally
    function()
        local x
        local wrong = function()
            Try(function() end,
            nil,
            -- finally
            function()
                x = 2
            end)
        end

        assertNoError(wrong)
        assert(x == 2)
    end,

    --- Min and Max ---
    -- Min
    function()
        local tbl = {2, 5, 34, 73, 1, 6}

        local min = Min(tbl)

        assert(min == 1)
    end,
    -- Max
    function()
        local tbl = {2, 5, 34, 73, 1, 6}

        local max = Max(tbl)

        assert(max == 73)
    end,
    -- Min and Max for empty tables
    function()
        local tbl = {}

        local min = Min(tbl)
        local max = Max(tbl)

        assertNil(min)
        assertNil(max)
    end
}

for _ test in pairs(tests) do
    test()
end
