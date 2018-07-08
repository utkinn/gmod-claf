include 'claf.lua'

local function measureExecutionTime(func, repeatN)
    local timestampBeforeExecution = SysTime()
    for _ = 1, repeatN do
        func()
    end
    return SysTime() - timestampBeforeExecution
end

local bar = '__________________________________________________'

local tests = {
    function()
        print 'Mapping {1..5}: multiply each value by 2 | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5 }
        print(measureExecutionTime(function()
            Map(numbers, function(x) return x * 2 end)
        end, 2500000)..' s')
    end,
    function()
        print 'Filtering {1..10}: IsEven | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            Filter(numbers, function(x) return IsEven(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'Any() with {1..10}: IsOdd | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            Any(numbers, function(x) return IsOdd(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'All() with {1..10}: IsOdd | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            All(numbers, function(x) return IsOdd(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'None() with {1..10}: IsOdd | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            None(numbers, function(x) return IsOdd(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'Count() with {1..10}: IsOdd | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            Count(numbers, function(x) return IsOdd(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'One() with {1..10}: IsOdd | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            One(numbers, function(x) return IsOdd(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'Few() with {1..10}: IsOdd | x 2 500 000'

        local numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        print(measureExecutionTime(function()
            Few(numbers, function(x) return IsOdd(x) end)
        end, 2500000)..' s')
    end,
    function()
        print 'Zip() with {1,2,3}, {4,5,6} and {7,8,9} | x 2 500 000'

        local a = { 1, 2, 3 }
        local b = { 4, 5, 6 }
        local c = { 7, 8, 9 }

        print(measureExecutionTime(function()
            Zip { a, b, c }
        end, 2500000)..' s')
    end,
    function()
        print 'Min() with { 2, 5, 34, 73, 1, 6 } | x 2 500 000'

        local tbl = { 2, 5, 34, 73, 1, 6 }

        print(measureExecutionTime(function()
            Min(tbl)
        end, 2500000)..' s')
    end,
    function()
        print 'Max() with { 2, 5, 34, 73, 1, 6 } | x 2 500 000'

        local tbl = { 2, 5, 34, 73, 1, 6 }

        print(measureExecutionTime(function()
            Max(tbl)
        end, 2500000)..' s')
    end,
    function()
        print 'String interpolation with locals a = "1", c = 3 | x 2 500 000'

        local a = '1'
        local c = 3
        print(measureExecutionTime(function()
            fmt'{a} {c}'
        end, 2500000)..' s')
    end,
    function()
        print 'String interpolation with globals a = "1", c = 3 | x 2 500 000'

        a = '1'
        c = 3
        print(measureExecutionTime(function()
            fmt'{a} {c}'
        end, 2500000)..' s')
        a, c = nil, nil
    end
}

-- print('WAIT')
-- print(bar)

for _, test in pairs(tests) do
    test()
    print()
end
