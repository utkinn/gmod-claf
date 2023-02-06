require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('Reduce', function()
    it('reduces a table with initial value', function()
        local inp = { 1, 2, 3 }
        local sum = Reduce(inp, function(acc, x) return acc + x end, 3)
        assert.are.equal(9, sum)
    end)
    
    it('reduces a table without initial value given', function()
        local inp = { 1, 2, 3 }
        local sum = Reduce(inp, function(acc, x) return acc + x end)
        assert.are.equal(6, sum)
    end)

    it('reduces an empty table without initial value given', function()
        local inp = {}
        local sum = Reduce(inp, function(acc, x) return acc + x end)
        assert.Nil(sum)
    end)
end)
