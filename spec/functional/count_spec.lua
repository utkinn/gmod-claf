require 'spec/gmod_polyfills'
local Count = require('claf/functional').Count

describe('Count', function()
    it('returns the number of elements matching the predicate', function()
        assert.are.equal(2, Count({ 1, 2, 2, 3 }, function(x) return x == 2 end))
    end)

    it('returns the number of truthy elements if no predicate is given', function()
        assert.are.equal(3, Count({ 1, 2, false, 3 }))
    end)

    it('returns 0 if the table is empty', function()
        assert.are.equal(0, Count({}))
    end)
end)
