local Last = require("claf.functional").Last

describe("Last", function()
    it("returns the Last element of a table", function()
        assert.are.equal(3, Last({ 1, 2, 3 }))
        assert.Nil(Last({}))
    end)
end)
