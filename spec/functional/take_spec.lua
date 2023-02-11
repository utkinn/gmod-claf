local t = require("claf.functional")

describe("Take", function()
    it("takes min(n, #table) elements of a table", function()
        assert.are.same({ 1, 2, 3 }, t.Take({ 1, 2, 3, 4, 5 }, 3))
        assert.are.same({ 1, 2 }, t.Take({ 1, 2 }, 3))
    end)
end)

describe("TakeRight", function()
    it("takes min(n, #table) elements of a table from the end", function()
        assert.are.same({ 3, 4, 5 }, t.TakeRight({ 1, 2, 3, 4, 5 }, 3))
        assert.are.same({ 1, 2, 3 }, t.TakeRight({ 1, 2, 3 }, 4))
    end)
end)

describe("TakeWhile", function()
    it("takes elements of a table while the predicate is true", function()
        assert.are.same({ 1, 2, 3 }, t.TakeWhile({ 1, 2, 3, 4, 5 }, function(x)
            return x < 4
        end))
        assert.are.same({ 1, 2, 3 }, t.TakeWhile({ 1, 2, 3 }, function(x)
            return x < 4
        end))
        assert.are.same({}, t.TakeWhile({ 1, 2, 3 }, function(x)
            return x < 1
        end))
        assert.are.same({}, t.TakeWhile({}, function(x)
            return x < 1
        end))
    end)
end)

describe("TakeRightWhile", function()
    it("takes elements of a table from the end while the predicate is true",
       function()
        assert.are.same({ 3, 4, 5 },
                        t.TakeRightWhile({ 1, 2, 3, 4, 5 }, function(x)
            return x > 2
        end))
        assert.are.same({ 1, 2, 3 }, t.TakeRightWhile({ 1, 2, 3 }, function(x)
            return x > 0
        end))
        assert.are.same({}, t.TakeRightWhile({ 1, 2, 3 }, function(x)
            return x > 3
        end))
        assert.are.same({}, t.TakeRightWhile({}, function(x)
            return x > 3
        end))
    end)
end)
