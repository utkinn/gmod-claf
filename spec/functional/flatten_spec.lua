require 'spec/gmod_polyfills'
require 'lua/claf/functional'

describe('Flatten', function()
    it('flattens a fully nested table', function()
        local before = { { 1, 2, 3 }, { 4, 5, 6 } }
        local after = Flatten(before)
        assert.are.same({ 1, 2, 3, 4, 5, 6 }, after)
    end)
    
    it('flattens a partially nested table', function()
        local before = { { 1, 2, 3 }, 4 }
        local after = Flatten(before)
        assert.are.same({ 1, 2, 3, 4 }, after)
    end)

    it('returns a copy of an already flat table', function()
        local before = { 1, 2, 3 }
        local after = Flatten(before)
        assert.are.same(before, after)
    end)
end)
