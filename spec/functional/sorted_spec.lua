require 'spec/gmod_polyfills'
local s = require('claf.functional')

describe("Sorted", function()
    it("returns a copy of the table sorted by the given function", function()
        local t = { 3, 1, 2 }
        local sorted = s.Sorted(t, function(a, b) return a < b end)
        assert.are.same({ 1, 2, 3 }, sorted)
        assert.are.same({ 3, 1, 2 }, t)
    end)

    it("returns a copy of the table sorted using '<' if sorter is not specified", function()
        local t = { 3, 1, 2 }
        local sorted = s.Sorted(t)
        assert.are.same({ 1, 2, 3 }, sorted)
        assert.are.same({ 3, 1, 2 }, t)
    end)
end)

describe("SortedDesc", function()
    it("returns a copy of the table sorted in reverse order by the given function", function()
        local t = { 3, 1, 2 }
        local sorted = s.SortedDesc(t, function(a, b) return a < b end)
        assert.are.same({ 3, 2, 1 }, sorted)
        assert.are.same({ 3, 1, 2 }, t)
    end)

    it("returns a copy of the table sorted in reverse order using '<' if sorter is not specified", function()
        local t = { 3, 1, 2 }
        local sorted = s.SortedDesc(t)
        assert.are.same({ 3, 2, 1 }, sorted)
        assert.are.same({ 3, 1, 2 }, t)
    end)
end)
