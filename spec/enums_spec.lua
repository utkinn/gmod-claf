require "spec/gmod_polyfills"
local e = require("claf/enums")

describe("Enum", function()
    it("creates an enum", function()
        local enum = e.Enum { "a", "b", "c" }
        assert.are.equal(enum.a, 1)
        assert.are.equal(enum.b, 2)
        assert.are.equal(enum.c, 3)
    end)

    it("throws an error if one of its members is an invalid identifier",
       function()
        assert.has_error(function()
            e.Enum { "d-e" }
        end)
        assert.has_error(function()
            e.Enum { "4d" }
        end)
        assert.has_error(function()
            e.Enum { "!@#$%^&*" }
        end)
        assert.has_error(function()
            e.Enum { "smth()" }
        end)
        assert.has_error(function()
            e.Enum { "\"" }
        end)
        assert.has_error(function()
            e.Enum { "" }
        end)

        e.Enum { "_4" }
    end)
end)

describe("Flags", function()
    it("creates flags", function()
        local enum = e.Flags { "a", "b", "c" }
        assert.are.equal(enum.a, 1)
        assert.are.equal(enum.b, 2)
        assert.are.equal(enum.c, 4)
    end)

    it("throws an error if one of its members is an invalid identifier",
       function()
        assert.has_error(function()
            e.Flags { "d-e" }
        end)
        assert.has_error(function()
            e.Flags { "4d" }
        end)
        assert.has_error(function()
            e.Flags { "!@#$%^&*" }
        end)
        assert.has_error(function()
            e.Flags { "smth()" }
        end)
        assert.has_error(function()
            e.Flags { "\"" }
        end)
        assert.has_error(function()
            e.Flags { "" }
        end)

        e.Flags { "_4" }
    end)

    pending("can be combined with bit.bor", function()
        local enum = e.Flags { "a", "b", "c" }
        assert.are.equal(bit.bor(enum.a, enum.b), 3)
        assert.are.equal(bit.bor(enum.a, enum.c), 5)
        assert.are.equal(bit.bor(enum.b, enum.c), 6)
        assert.are.equal(bit.bor(enum.a, enum.b, enum.c), 7)
    end)
end)
