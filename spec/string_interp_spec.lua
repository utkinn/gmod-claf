local fmtLib = require("claf/fmt")
local fmt = fmtLib.fmt
local f = fmtLib.f

describe("fmt\"\"", function()
    it("replaces patterns like {var} with variable values", function()
        -- luacheck: no unused
        local var = "{value}"
        local null = nil
        assert.equal("{value} nil", fmt "{var} {null}")
    end)

    it("ignores strings without substitution patterns", function()
        assert.equal("no substitution", fmt "no substitution")
    end)

    it("inserts \"nil\" in place of invalid substitution patterns", function()
        assert.equal("nil", fmt "{!!!}")
    end)

    it("does not substitute patterns like {{this}}", function()
        assert.equal("{a}", fmt "{{a}}")
    end)

    describe("supports table access syntax in substitution patterns", function()
        -- luacheck: no unused
        it("(1 level)", function()
            local tbl = { a = 1 }
            local str = fmt "-{tbl.a}-"
            assert.are.equal("-1-", str)
        end)
        it("(3 levels)", function()
            local tbl = { a = { b = { c = 1 } } }
            local str = fmt "{tbl.a.b.c}"
            assert.are.equal("1", str)
        end)
    end)
end)

insulate("f\"\"", function()
    it("is a deprecated alias for fmt\"\"", function()
        _G.Color = function(r, g, b)
            return string.format("Color(%d, %d, %d)", r, g, b)
        end
        stub(_G, "MsgC")

        -- luacheck: no unused
        local var = "{value}"
        local null = nil
        assert.equal("{value} nil", f "{var} {null}")
        assert.stub(_G.MsgC).was.called_with(Color(255, 255, 0),
                                             "[CLAF] f() is deprecated. Use fmt() instead.")
    end)
end)
