require 'spec/gmod_polyfills'
local a = require('claf/assertions')

describe('assertions', function()
    it('assertNot()', function()
        a.assertNot(false)
    end)

    it('assertNotNil()', function()
        a.assertNotNil(1)
    end)

    it('assertNil()', function()
        a.assertNil(nil)
    end)

    describe('assertNoError()', function()
        it('works as expected if a function is passed', function()
            a.assertNoError(function()
                return 1
            end)
        end)

        it('throws an error if something other than a function is passed', function()
            assert.has_error(function() a.assertNoError(1) end, '"func" must be a function')
        end)
    end)

    describe('assertError()', function()
        it('works as expected if a function is passed', function()
            a.assertError(function()
                error()
            end)
        end)

        it('throws an error if something other than a function is passed', function()
            assert.has_error(function() a.assertError(1) end, '"func" must be a function')
        end)
    end)
end)
