require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('None', function()
    it('returns true if not a single element in the table satisfies the predicate', function()
        assert.True(None({ 1, 2, 3 }, function(x) return x == 4 end))
    end)
    
    it('returns false if at least one element in the table satisfies the predicate', function()
        assert.False(None({ 1, 2, 3 }, function(x) return x == 2 end))
    end)
    
    it('returns true if none of the elements in the table is truthy if no predicate is specified', function()
        assert.True(None({ false, 0 }))
    end)
    
    it('returns false if at least one element in the table are truthy if no predicate is specified', function()
        assert.False(None({ true, 0 }))
    end)

    it('returns true if the table is empty', function()
        assert.True(None({}))
    end)
end)
