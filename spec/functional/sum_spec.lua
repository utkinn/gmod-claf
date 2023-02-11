require "spec/gmod_polyfills"
local Sum = require("claf/functional").Sum

describe("Sum", function()
    it("returns table's sum", function()
        local inp = { 1, 2, 3 }
        local sum = Sum(inp)
        assert.are.equal(6, sum)
    end)

    it("returns 0 for empty table", function()
        local inp = {}
        local sum = Sum(inp)
        assert.are.equal(0, sum)
    end)
end)
