require "spec/gmod_polyfills"
local Try = require("claf/functional").Try

describe("Try", function()
    it("executes the \"catch\" function on error in the \"try\" function",
       function()
        local caughtErr
        Try(function()
            error("test")
        end, function(err)
            caughtErr = err
        end)
        assert.is.truthy(string.match(caughtErr, "test"))
    end)

    it("executes the \"finally\" function on error", function()
        local finallyCalled = false
        Try(function()
            error("test")
        end, nil, function()
            finallyCalled = true
        end)
        assert.True(finallyCalled)
    end)

    it("executes the \"finally\" function on no error", function()
        local finallyCalled = false
        Try(function()
        end, nil, function()
            finallyCalled = true
        end)
        assert.True(finallyCalled)
    end)

    it("works with table of functions", function()
        local catchRun = false
        local finallyRun = false

        Try {
            function()
                error("test")
            end,
            catch = function()
                catchRun = true
            end,
            finally = function()
                finallyRun = true
            end
        }

        assert.True(catchRun)
        assert.True(finallyRun)
    end)
end)
