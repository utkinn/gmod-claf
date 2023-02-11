local First = require("claf.functional").First

describe("First", function()
    it("returns the first element of a table", function()
        assert.are.equal(1, First({ 1, 2, 3 }))
        assert.Nil(First({}))
    end)
end)
