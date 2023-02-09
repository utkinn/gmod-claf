local Includes = require('claf.functional').Includes

describe("Includes", function()
    it("should return true if the value is in the table", function()
        assert.is_true(Includes({ 1, 2, 3 }, 2))
        assert.is_false(Includes({ 1, 2, 3 }, 4))
    end)
end)
