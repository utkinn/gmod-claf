include 'claf.lua'

-- Unit tests.

local bar = '__________________________________________________'

local tests = {
    --- Self-test ---

    function()
        print 'Running CLAF tests...'
        print(bar)
    end,

    function()
        print 'assertNot()...'

        assertNot(false)
    end,

    function()
        print 'assertNotNil()...'

        assertNotNil(1)
    end,

    function()
        print 'assertNil()...'

        assertNil(nil)
    end,

    function()
        print 'assertNoError()...'

        assertNoError(function() end)
    end,

    function()
        print 'assertError()...'

        assertError(function() TOTALLY_ILLEGAL_STUFF_HERE() end)
    end,

    --- Alias tests ---

    function()
        print 'Alias "GetHealth"...'

        local health = Entity(1):Health()
        local getHealth = Entity(1):GetHealth()

        assert(health == getHealth)
    end,
    function()
        print 'Alias "IsAlive"...'

        local alive = player.GetAll()[1]:Alive()
        local isAlive = player.GetAll()[1]:IsAlive()

        assert(alive == isAlive)
    end,
    function()
        print 'Alias "GetArmor"...'

        local armor = player.GetAll()[1]:Armor()
        local getArmor = player.GetAll()[1]:GetArmor()

        assert(armor == getArmor)
    end,
    function()
        print 'Alias "Run"...'

        Run 'x_ = 1'

        assert(x_ == 1)

        x_ = nil
    end,

    --- Enums and Flags tests ---

    function()
        print 'Enum structure...'

        local color = Enum { 'RED', 'GREEN', 'BLUE' }

        assertNotNil(color.RED)
        assertNotNil(color.GREEN)
        assertNotNil(color.BLUE)
    end,
    function()
        print 'Flags structure...'

        local color = Flags { 'RED', 'GREEN', 'BLUE' }

        assertNotNil(color.RED)
        assertNotNil(color.GREEN)
        assertNotNil(color.BLUE)
    end,
    function()
        print 'Empty enum...'

        local empty = Enum {}

        assert(#empty == 0)
    end,
    function()
        print 'Empty flags...'

        local empty = Flags {}

        assert(#empty == 0)
    end,
    function()
        print 'Incorrect enum constant names...'

        assertError(function() Enum { 'RED.smth' } end)
        assertError(function() Enum { '4abc' } end)
        assertError(function() Enum { '!@#$%^&*' } end)
        assertError(function() Enum { 'smth()' } end)
        assertError(function() Enum { '"' } end)
        assertError(function() Enum { '' } end)

        assertNoError(function() Enum { '_4' } end)
        assertNoError(function() Enum { '__' } end)
        assertNoError(function() Enum { '_a' } end)
    end,
    function()
        print 'Incorrect flags constant names...'

        assertError(function() Flags { 'RED.smth' } end)
        assertError(function() Flags { '4abc' } end)
        assertError(function() Flags { '!@#$%^&*' } end)
        assertError(function() Flags { 'smth()' } end)
        assertError(function() Flags { '"' } end)
        assertError(function() Flags { '' } end)

        assertNoError(function() Flags { '_4' } end)
        assertNoError(function() Flags { '__' } end)
        assertNoError(function() Flags { '_a' } end)
    end,
    function()
        print 'Flag batching/debatching...'

        local color = Flags { 'RED', 'GREEN', 'BLUE' }

        local greenAndBlue = bit.bor(color.GREEN, color.BLUE)
        -- RED                  1   001
        -- GREEN                2   010
        -- BLUE                 4   100
        -- bit.bor(GREEN, BLUE) 6   110
        assert(greenAndBlue == 6)
        assert(bit.band(greenAndBlue, color.GREEN) == color.GREEN)
        assert(bit.band(greenAndBlue, color.BLUE) == color.BLUE)
    end,

    --- Functional programming ---

    function()
        print 'Map()...'

        local numbers = { 1, 2, 3, 4, 5 }

        numbers = Map(numbers, function(x) return x * 2 end)

        assert(numbers[1] == 2)
        assert(numbers[2] == 4)
        assert(numbers[3] == 6)
        assert(numbers[4] == 8)
        assert(numbers[5] == 10)
    end,
    function()
        print 'Map() with empty table...'

        local empty = {}

        local emptyToo = Map(empty, function(x) return x * 2 end)

        assert(#emptyToo == 0)
    end,
    function()
        print 'Map() with key editor...'

        local numbers = { { x = 1 }, { x = 2 }, { x = 3 } }

        local oneTwoThree = Map(numbers, 'x')

        assert(oneTwoThree[1] == 1)
        assert(oneTwoThree[2] == 2)
        assert(oneTwoThree[3] == 3)
    end,
    function()
        print 'Filter()...'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }

        numbers = Filter(numbers, function(x) return IsEven(x) end)

        assert(numbers[1] == 2)
        assert(numbers[2] == 4)
        assert(numbers[3] == 6)
        assert(numbers[4] == 8)
        assert(numbers[5] == 10)
    end,
    function()
        print 'Filter() with default predicate...'

        local bools = { false, true, false }

        bools = Filter(bools)

        assert(bools[1])
    end,
    function()
        print 'Filter() with empty table...'

        local empty = {}

        local emptyToo = Filter(empty)

        assert(#emptyToo == 0)
    end,
    function()
        print '"Fancy" Filter()...'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }

        numbers = Filter(numbers, IsEven)

        assert(numbers[1] == 2)
        assert(numbers[2] == 4)
        assert(numbers[3] == 6)
        assert(numbers[4] == 8)
        assert(numbers[5] == 10)
    end,
    function()
        print 'FilterKeyed() (values)...'

        local tbl = { a = 'hi', b = 'world' }

        tbl = FilterKeyed(tbl, function(k, v) return v == 'hi' end)

        assert(tbl['a'] == 'hi')
        assertNil(tbl['b'])
    end,
    function()
        print 'FilterKeyed() (keys)...'

        local tbl = { a = 'hi', b = 'world' }

        tbl = FilterKeyed(tbl, function(k, v) return k == 'a' end)

        assert(tbl['a'] == 'hi')
        assertNil(tbl['b'])
    end,
    function()
        print 'FilterKeyed() with default predicate...'

        local tbl = { a = false, b = true }

        tbl = FilterKeyed(tbl)

        assert(tbl['b'])
        assertNil(tbl['a'])
    end,
    function()
        print 'FilterKeyed() with empty table...'

        local empty = {}

        local emptyToo = FilterKeyed(empty)

        assert(#emptyToo == 0)
    end,
    function()
        print 'Reduce()...'

        local numbers = { 1, 2, 3 }
        local sum = Reduce(numbers, function(acc, x) return acc + x end, 3)
        assert(sum == 9)
    end,
    function()
        print 'Reduce() without initial value...'

        local numbers = { 1, 2, 3 }
        local sum = Reduce(numbers, function(acc, x) return acc + x end)
        assert(sum == 6)
    end,
    function()
        print 'Reduce() with empty table without initial value...'

        local empty = {}
        local sum = Reduce(empty, function(acc, x) return acc + x end)
        assert(sum == nil)
    end,
    function()
        print 'Sum()...'

        local numbers = { 1, 2, 3 }
        local sum = Sum(numbers)
        assert(sum == 6)
    end,
    function()
        print 'Any()...'

        local numbers = { 2, 20, 100, 1 }

        local anyIsOdd = Any(numbers, function(x) return IsOdd(x) end)

        assert(anyIsOdd)
    end,
    function()
        print 'Any() with default predicate...'

        local numbers = { true, false, false, true }

        local any = Any(numbers)

        assert(any)
    end,
    function()
        print 'Any() with empty table...'

        local empty = {}

        local shouldBeFalse = Any(empty)

        assertNot(shouldBeFalse)
    end,
    function()
        print 'All()...'

        local numbers = { 2, 20, 100, 1 }

        local allIsOdd = All(numbers, function(x) return IsOdd(x) end)

        assertNot(allIsOdd)
    end,
    function()
        print 'All() with default predicate...'

        local numbers = { true, true }

        local all = All(numbers)

        assert(all)
    end,
    function()
        print 'All() with empty table...'

        local empty = {}

        local shouldBeTrue = All(empty)

        assert(shouldBeTrue)
    end,
    function()
        print 'None()...'

        local numbers = { 2, 20, 100, 1 }

        allIsOdd = None(numbers, function(x) return IsOdd(x) end)

        assertNot(allIsOdd)
    end,
    function()
        print 'None() with default predicate...'

        local numbers = { true, false }

        all = None(numbers)

        assertNot(all)
    end,
    function()
        print 'None() with empty table...'

        local empty = {}

        local shouldBeTrue = None(empty)

        assert(shouldBeTrue)
    end,
    function()
        print 'Count()...'

        local numbers = { 2, 20, 100, 1, 3 }

        local odds = Count(numbers, function(x) return IsOdd(x) end)

        assert(odds == 2)
    end,
    function()
        print 'Count() with default predicate...'

        local numbers = { true, false }

        local count = Count(numbers)

        assert(count == 1)
    end,
    function()
        print 'Count() with empty table...'

        local empty = {}

        local count = Count(empty)

        assert(count == 0)
    end,
    function()
        print 'One()...'

        local numbers = { 2, 20, 100, 1, 3 }

        local one = One(numbers, function(x) return IsOdd(x) end)

        assertNot(one)
    end,
    function()
        print 'One() with default predicate...'

        local numbers = { true, false }

        local one = One(numbers)

        assert(one)
    end,
    function()
        print 'One() with empty table...'

        local empty = {}

        local count = One(empty)

        assertNot(one)
    end,
    function()
        print 'Few()...'

        local numbers = { 2, 20, 100, 1, 3 }

        local few = Few(numbers, function(x) return IsOdd(x) end)

        assert(few)
    end,
    function()
        print 'Few() with default predicate...'

        local numbers = { true, false }

        local few = Few(numbers)

        assertNot(few)
    end,
    function()
        print 'Few() with empty table...'

        local empty = {}

        local few = Few(empty)

        assertNot(few)
    end,

    --- Zip ---

    function()
        print 'Zip() (same source lengths)...'

        local a = { 1, 2, 3 }
        local b = { 4, 5, 6 }
        local c = { 7, 8, 9 }

        local zip = Zip { a, b, c }

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
    function()
        print 'Zip() (different source lengths)...'

        local a = { 1, 2, 3 }
        local b = { 4, 5, 6, 7 }
        local c = { 8, 9, 10, 11, 12 }

        local zip = Zip { a, b, c }

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

    --- Flatten ---

    function()
        print 'Flatten()...'

        local before = { { 1, 2, 3 }, { 4, 5, 6 } }
        local expectedAfter = { 1, 2, 3, 4, 5, 6 }

        local actualAfter = Flatten(before)

        assert(table.concat(actualAfter) == table.concat(expectedAfter))
    end,

    --- Try/catch ---

    function()
        print 'Try with catch...'

        local x
        local wrong = function()
            Try(function()
                __nothing__.foo = 1
            end,
            -- catch
            function()
                x = 2
            end)
        end

        assertNoError(wrong)
        assert(x == 2)
    end,
    function()
        print 'Try (error occurs) with finally...'

        local x
        local wrong = function()
            Try(function()
                __nothing__.foo = 1
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
    function()
        print 'Try (error does not occur) with finally...'

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

    function()
        print 'Min()...'

        local tbl = { 2, 5, 34, 73, 1, 6 }

        local min = Min(tbl)

        assert(min == 1)
    end,
    function()
        print 'Max()...'

        local tbl = { 2, 5, 34, 73, 1, 6 }

        local max = Max(tbl)

        assert(max == 73)
    end,
    function()
        print 'Min(), Max() with empty table...'

        local tbl = {}

        local min = Min(tbl)
        local max = Max(tbl)

        assertNil(min)
        assertNil(max)
    end,

    --- Pipe ---

    function()
        print 'Pipe() - ToTable()...'

        local inp = {
            { { x = 1 }, { x = 2 } },
            { { x = 3 }, { x = 4 } },
        }
        local result = Pipe(inp)
            :Flatten()
            :Map('x')
            :ToTable()

        assert(result[1] == 1)
        assert(result[2] == 2)
        assert(result[3] == 3)
        assert(result[4] == 4)
    end,

    function()
        print 'Pipe() - Sum()...'

        local inp = {
            { { x = 1 }, { x = 2 } },
            { { x = 3 }, { x = 4 } },
        }
        local result = Pipe(inp)
            :Flatten()
            :Map('x')
            :Sum()

        assert(result == 10)
    end,

    function()
        print 'Pipe() with invalid method...'

        local inp = { 1, 2, 3 }

        assertError(function()
            Pipe(inp):InvalidMethod()
        end)
    end,

    --- f'str' ---

    function()
        print 'String interpolation...'

        local a = '1'
        b = '{2}'
        local c = 3
        d = 4
        local e = nil
        local str = fmt'{a} {b}, {c}{d}{e}'

        assert(str == '1 {2}, 34nil', 'result = "'..str..'"')

        b, d = nil
    end,
    function()
        print 'String interpolation with no substitution marks...'

        local a = '1'
        b = '{2}'
        local c = 3
        d = 4
        local str = fmt'None'

        assert(str == 'None', 'result = "'..str..'"')

        b, d = nil
    end,
    function()
        print 'String interpolation with junk in substitution mark...'

        local str = fmt'{6395  92472 2842 +=+ ^_^}: what?'

        assert(str == 'nil: what?', 'result = "'..str..'"')
    end,
    function()
        print 'String interpolation escaping...'

        local str = fmt'{{These braces are not meant to be substituted}}'

        assert(str == '{These braces are not meant to be substituted}', 'result = "'..str..'"')
    end,
    -- function()
    --     print 'Recursive string interpolation...'
    --
    --     _G['a{3}'] = 1
    --     local str = f'{a{3}}'
    --
    --     assert(str == '1', 'result = "'..str..'"')
    --
    --     _G['a{3}'] = nil
    -- end,
    function()
        print 'String interpolation with table member...'

        local tbl = {a = 1}
        local str = fmt'-{tbl.a}-'

        assert(str == '-1-', 'result = "'..str..'"')
    end,

    --- Tests success ---

    function()
        print(bar)
        print 'CLAF TESTS SUCCESSFUL!'
    end
}

print 'CLAF Tests table initialized'

for _, test in pairs(tests) do
    test()
end
