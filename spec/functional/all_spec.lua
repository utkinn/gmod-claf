require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('All', function()
    it('returns true if all elements in the table satisfies the predicate', function()
        assert.True(All({ 2, 2, 2 }, function(x) return x == 2 end))
    end)
    
    it('returns false if at least one element does not satisfy the predicate', function()
        assert.False(All({ 1, 2, 3 }, function(x) return x == 2 end))
    end)
    
    it('returns true if all elements in the table are truthy if no predicate is specified', function()
        assert.True(All({ true, 1 }))
    end)
    
    it('returns false if at least one element is not truthy if no predicate is specified', function()
        assert.False(All({ true, 0 }))
    end)

    it('returns true if the table is empty', function()
        assert.True(All({}))
    end)
end)
