require "spec/gmod_polyfills"
local Filter = require("claf/functional").Filter

describe("Filter", function()
    it("filters a table with a predicate", function()
        local inp = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
        local result = Filter(inp, function(x)
            return x % 2 == 0
        end)
        assert.are.same({ 2, 4, 6, 8, 10 }, result)
    end)

    it("selects truthy values if no predicate is given", function()
        local inp = { 0, true, 1, false, nil }
        local result = Filter(inp)
        assert.are.same({ true, 1 }, result)
    end)

    it("returns an empty table if the table is empty", function()
        local inp = {}
        local result = Filter(inp)
        assert.are.same({}, result)
    end)
end)
