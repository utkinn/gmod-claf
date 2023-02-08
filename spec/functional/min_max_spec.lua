require 'spec/gmod_polyfills'
local f = require('claf/functional')

describe('Min', function()
    it('returns the minimum value', function()
        local inp = { 1, 3, 1, 2 }
        assert.are.equal(1, f.Min(inp))
    end)

    it('returns nil for empty tables', function()
        assert.are.equal(nil, f.Min({}))
    end)
end)

describe('Max', function()
    it('returns the maximum value', function()
        local inp = { 1, 3, 1, 2 }
        assert.are.equal(3, f.Max(inp))
    end)

    it('returns nil for empty tables', function()
        assert.are.equal(nil, f.Max({}))
    end)
end)
