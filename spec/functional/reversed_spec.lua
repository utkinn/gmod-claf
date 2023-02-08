require 'spec/gmod_polyfills'
local Reversed = require('claf.functional').Reversed

describe("Reversed", function()
    it("returns a reversed copy of the given table", function()
        assert.are.same({ 3, 2, 1 }, Reversed({ 1, 2, 3 }))
    end)
end)
