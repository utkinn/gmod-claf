require "spec/gmod_polyfills"

describe("isfunction", function()
    it("returns true if the given value is a function", function()
        assert.True(isfunction(function()
        end))
    end)

    it("returns false if the given value is not a function", function()
        assert.False(isfunction(1))
        assert.False(isfunction("hello"))
        assert.False(isfunction({}))
        assert.False(isfunction(nil))
    end)
end)

describe("istable", function()
    it("returns true if the given value is a table", function()
        assert.True(istable({}))
    end)

    it("returns false if the given value is not a table", function()
        assert.False(istable(1))
        assert.False(istable("hello"))
        assert.False(istable(function()
        end))
        assert.False(istable(nil))
    end)
end)

describe("isstring", function()
    it("returns true if the given value is a string", function()
        assert.True(isstring("hello"))
    end)

    it("returns false if the given value is not a string", function()
        assert.False(isstring(1))
        assert.False(isstring({}))
        assert.False(isstring(function()
        end))
        assert.False(isstring(nil))
    end)
end)

describe("string.StartWith", function()
    it("returns true if the string starts with the given substring", function()
        assert.True(string.StartWith("hello world", "hello"))
        assert.True(string.StartWith("hello world", "hello world"))
        assert.True(string.StartWith("hello world", ""))
    end)

    it("returns false if the string does not start with the given substring",
       function()
        assert.False(string.StartWith("hello world", "world"))
        assert.False(string.StartWith("hello world", "hello world!"))
    end)
end)

describe("string.Replace", function()
    it("replaces one substring with another", function()
        local str = "hello world"
        assert.are.equal("hello world!", string.Replace(str, "world", "world!"))
    end)
end)

describe("string.Explode", function()
    it("splits the string into a table of substrings", function()
        local str = "hello world   yay"
        assert.are.same({ "hello", "world", "yay" }, string.Explode(" ", str))
    end)
end)

describe("bit.bor", function()
    pending("returns the bitwise OR of the given numbers", function()
        assert.are.equal(0, bit.bor(0, 0))
        assert.are.equal(1, bit.bor(0, 1))
        assert.are.equal(1, bit.bor(1, 0))
        assert.are.equal(1, bit.bor(1, 1))
        assert.are.equal(3, bit.bor(1, 2))
        assert.are.equal(3, bit.bor(2, 1))
        assert.are.equal(3, bit.bor(3, 3))
    end)
end)

describe("table.Copy", function()
    it("returns a deep copy of the given table", function()
        local tbl = { 1, 2, 3, { 4, 5, 6 } }
        local copy = table.Copy(tbl)
        assert.are.same(tbl, copy)
        assert.are_not.equal(tbl, copy)
        assert.are_not.equal(tbl[4], copy[4])
    end)
end)

describe("table.Reverse", function()
    it("returns a reversed copy of the given table", function()
        local tbl = { 1, 2, 3, 4, 5 }
        local reversed = table.Reverse(tbl)
        assert.are.same({ 5, 4, 3, 2, 1 }, reversed)
        assert.are.not_equal(tbl, reversed)
    end)
end)

describe("tobool", function()
    it(
        "returns true if the given value is true, \"true\", a number != 0, a string != \"false\" or a table",
        function()
            assert.True(tobool(true))
            assert.True(tobool("true"))
            assert.True(tobool(1))
            assert.True(tobool(10))
            assert.True(tobool(-1))
            assert.True(tobool("a"))
            assert.True(tobool(""))
            assert.True(tobool({}))
        end)

    it("returns false if the given value is false, 0, nil, \"0\" or \"false\"",
       function()
        assert.False(tobool(false))
        assert.False(tobool("false"))
        assert.False(tobool(0))
        assert.False(tobool("0"))
        assert.False(tobool(nil))
    end)
end)

describe("table.IsSequential", function()
    it("returns true if the passed table is sequential", function()
        assert.True(table.IsSequential({ 1, 2, 3 }))
    end)

    it("returns false if the passed table is sequential", function()
        assert.False(table.IsSequential({ a = 1, b = 2, c = 3 }))
    end)
end)

describe("table.Merge", function()
    it("merges two tables", function()
        local tbl1 = { a = 1, b = 2 }
        local tbl2 = { c = 3, d = 4 }
        local merged = table.Merge(tbl1, tbl2)
        assert.are.same({ a = 1, b = 2, c = 3, d = 4 }, merged)
        assert.are.equal(tbl1, merged)
    end)
end)

describe("string.ToTable", function()
    it("returns a table of characters", function()
        assert.are.same({ "h", "e", "l", "l", "o" }, string.ToTable("hello"))
    end)
end)

insulate("include", function()
    it("runs Lua code in the given file", function()
        _G.dofile = function(x)
            return x
        end
        local fileResult = include("test/file.lua")
        assert.are.equal("lua/test/file.lua", fileResult)
    end)
end)
