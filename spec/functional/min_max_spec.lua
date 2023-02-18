require "spec/gmod_polyfills"
local f = require("claf/functional")

describe("Min", function()
    it("returns the minimum value", function()
        local inp = { 1, 3, 1, 2 }
        assert.are.equal(1, f.Min(inp))
    end)

    it("returns nil for empty tables", function()
        assert.are.equal(nil, f.Min({}))
    end)

    it("returns the minimum value with custom sorter", function()
        local inp = { 1, 3, 1, 2 }
        assert.are.equal(3, f.Min(inp, function(a, b)
            return a > b
        end))
    end)
end)

describe("Max", function()
    it("returns the maximum value", function()
        local inp = { 1, 3, 1, 2 }
        assert.are.equal(3, f.Max(inp))
    end)

    it("returns nil for empty tables", function()
        assert.are.equal(nil, f.Max({}))
    end)

    it("returns the maximum value with custom sorter", function()
        local inp = { 1, 3, 1, 2 }
        assert.are.equal(1, f.Max(inp, function(a, b)
            return a > b
        end))
    end)
end)
