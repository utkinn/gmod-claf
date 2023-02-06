require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('FilterKeyed', function()
    it('filters a table with a predicate', function()
        local inp = { a = 'hi', b = 'world' }
        local result = FilterKeyed(inp, function(k, v) return v == 'hi' end)
        assert.are.same({ a = 'hi' }, result)
    end)

    it('selects truthy values if no predicate is given', function()
        local inp = { a = false, b = true }
        local result = FilterKeyed(inp)
        assert.are.same({ b = true }, result)
    end)

    it('returns an empty table if the table is empty', function()
        local inp = {}
        local result = FilterKeyed(inp)
        assert.are.same({}, result)
    end)
end)
