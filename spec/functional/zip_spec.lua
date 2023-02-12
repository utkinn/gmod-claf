require "spec/gmod_polyfills"
local Zip = require("claf/functional").Zip

describe("Zip", function()
    it("returns input[1] if input is a table of length 1", function()
        local a = { 1, 2, 3 }
        local zip = Zip { a }
        assert.are.same(a, zip)
    end)

    describe("zips multiple tables of", function()
        it("equal lenghts", function()
            local a = { 1, 2, 3 }
            local b = { 4, 5, 6 }
            local c = { 7, 8, 9 }

            local zip = Zip { a, b, c }

            assert.are.same({ { 1, 4, 7 }, { 2, 5, 8 }, { 3, 6, 9 } }, zip)
        end)

        it("different lenghts", function()
            local a = { 1, 2, 3 }
            local b = { 4, 5, 6, 7 }
            local c = { 8, 9, 10, 11, 12 }

            local zip = Zip { a, b, c }

            assert.are.same({ { 1, 4, 8 }, { 2, 5, 9 }, { 3, 6, 10 } }, zip)
        end)
    end)
end)
