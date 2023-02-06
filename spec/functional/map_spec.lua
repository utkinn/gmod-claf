require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('Map', function()
    it('should map a function over a list', function()
        local inp = { 1, 2, 3, 4, 5 }
        local result = Map(inp, function(x) return x * 2 end)
        assert.are.same({ 2, 4, 6, 8, 10 }, result)
    end)

    it('returns an empty table when given an empty table', function()
        local result = Map({}, function(x) return x * 2 end)
        assert.are.same({}, result)
    end)

    it("returns a table with values of specified key of each input table's element", function()
        local inp = { { a = 1 }, { a = 2 }, { a = 3 } }
        local result = Map(inp, 'a')
        assert.are.same({ 1, 2, 3 }, result)
    end)
end)
