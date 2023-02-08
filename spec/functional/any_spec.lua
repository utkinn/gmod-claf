require 'spec/gmod_polyfills'
local Any = require('claf/functional').Any

describe('Any', function()
    it('returns true if any element in the table satisfies the predicate', function()
        assert.True(Any({ 1, 2, 3 }, function(x) return x == 2 end))
    end)

    it('returns false if none of the elements in the table satisfies the predicate', function()
        assert.False(Any({ 1, 2, 3 }, function(x) return x == 4 end))
    end)

    it('returns true if any element in the table is truthy if no predicate is specified', function()
        assert.True(Any({ true, 0 }))
    end)

    it('returns false if none of the elements are truthy if no predicate is specified', function()
        assert.False(Any({ false, 0 }))
    end)

    it('returns false if the table is empty', function()
        assert.False(Any({}))
    end)
end)
