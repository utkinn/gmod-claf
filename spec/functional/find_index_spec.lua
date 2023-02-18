require("spec/gmod_polyfills")
local FindIndex = require("claf/functional").FindIndex

describe("FindIndex", function()
    it(
        "should return the index of the first element that matches the predicate",
        function()
            local t = { 2, 3, 4, 5 }
            local index = FindIndex(t, function(v)
                return v == 5
            end)
            assert.are.equal(4, index)
        end)

    it("should return nil if no element matches the predicate", function()
        local t = { 2, 3, 4, 5 }
        local index = FindIndex(t, function(v)
            return v == 6
        end)
        assert.Nil(index)
    end)

    it("should return the index of a specified element", function()
        local t = { "a", "b", "c", "d" }
        local index = FindIndex(t, "c")
        assert.are.equal(3, index)
    end)
end)
