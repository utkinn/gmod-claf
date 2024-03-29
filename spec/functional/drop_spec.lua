require "spec/gmod_polyfills"
local d = require("claf.functional")

describe("Drop", function()
    it("Drops min(n, #table) elements of a table", function()
        assert.are.same({ 4, 5 }, d.Drop({ 1, 2, 3, 4, 5 }, 3))
        assert.are.same({}, d.Drop({ 1, 2 }, 3))
        assert.are.same({}, d.Drop({}, 3))
    end)
end)

describe("DropRight", function()
    it("Drops min(n, #table) elements of a table from the end", function()
        assert.are.same({ 1, 2 }, d.DropRight({ 1, 2, 3, 4, 5 }, 3))
        assert.are.same({}, d.DropRight({ 1, 2, 3 }, 4))
        assert.are.same({}, d.DropRight({}, 4))
    end)
end)

describe("DropWhile", function()
    it("Drops elements of a table while the predicate is true", function()
        assert.are.same({ 4, 5 }, d.DropWhile({ 1, 2, 3, 4, 5 }, function(x)
            return x < 4
        end))
        assert.are.same({ 1, 2, 3 }, d.DropWhile({ 1, 2, 3 }, function(x)
            return x < 1
        end))
        assert.are.same({}, d.DropWhile({ 1, 2, 3 }, function(x)
            return x < 4
        end))
        assert.are.same({}, d.DropWhile({}, function(x)
            return x < 1
        end))
    end)
end)

describe("DropRightWhile", function()
    it("Drops elements of a table from the end while the predicate is true",
       function()
        assert.are.same({ 1, 2 },
                        d.DropRightWhile({ 1, 2, 3, 4, 5 }, function(x)
            return x > 2
        end))
        assert.are.same({}, d.DropRightWhile({ 1, 2, 3 }, function(x)
            return x > 0
        end))
        assert.are.same({ 1, 2, 3 }, d.DropRightWhile({ 1, 2, 3 }, function(x)
            return x > 3
        end))
        assert.are.same({}, d.DropRightWhile({}, function(x)
            return x > 3
        end))
    end)
end)
