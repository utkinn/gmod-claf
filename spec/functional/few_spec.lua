require 'spec/gmod_polyfills'
local Few = require('claf/functional').Few

describe('Few', function()
    it('returns true if more than one element matches the predicate', function()
        assert.True(Few({ 1, 2, 2, 3 }, function(x) return x == 2 end))
    end)

    it('returns false one or zero elements match the predicate', function()
        assert.False(Few({ 1 }, function(x) return x == 2 end))
        assert.False(Few({ 2 }, function(x) return x == 2 end))
    end)
end)
