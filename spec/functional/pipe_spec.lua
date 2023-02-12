require "spec/gmod_polyfills"
local f = require("claf/functional")
local Pipe = require("claf/pipe").Pipe

-- TODO: Make Pipe() accept a second argument with table of methods that can be used
table.Merge(_G, f)

describe("Pipe", function()
    it("returns a transformed table if ToTable is called in the chain end",
       function()
        local inp = { { { x = 1 }, { x = 2 } }, { { x = 3 }, { x = 4 } } }
        local result = Pipe(inp):Flatten():Map("x"):ToTable()

        assert.are.same({ 1, 2, 3, 4 }, result)
    end)

    it(
        "returns an aggregate result if the last method in the chain returns a non-table value",
        function()
            local inp = { { { x = 1 }, { x = 2 } }, { { x = 3 }, { x = 4 } } }
            local result = Pipe(inp):Flatten():Map("x"):Sum()

            assert.are.equal(10, result)
        end)

    it("throws an error if an invalid method is called", function()
        assert.has_error(function()
            Pipe({}):InvalidMethod()
        end, "Pipe: InvalidMethod is not a valid method")
    end)

    it(
        "returns \"PipeObj with \" .. tostring(self.value) if tostring is called",
        function()
            local inp = {}
            local result = tostring(Pipe(inp))

            assert.are.equal("PipeObj with " .. tostring(inp), result)
        end)
end)
