require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('One', function()
    it('returns true if exactly one element matches the predicate', function()
        assert.True(One({ 1, 2, 3 }, function(x) return x == 2 end))
    end)
    
    it('returns false if not exactly one element matches the predicate', function()
        assert.False(One({ 2, 2, 3 }, function(x) return x == 2 end))
    end)
end)
