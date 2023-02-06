require 'spec/gmod_polyfills'
require 'lua/claf/assertions'

describe('assertions', function()
    it('assertNot()', function()
        assertNot(false)
    end)

    it('assertNotNil()', function()
        assertNotNil(1)
    end)

    it('assertNil()', function()
        assertNil(nil)
    end)

    describe('assertNoError()', function()
        it('works as expected if a function is passed', function()
            assertNoError(function()
                return 1
            end)
        end)

        it('throws an error if something other than a function is passed', function()
            assert.has_error(function() assertNoError(1) end, '"func" must be a function')
        end)
    end)

    describe('assertError()', function()
        it('works as expected if a function is passed', function()
            assertError(function()
                error()
            end)
        end)

        it('throws an error if something other than a function is passed', function()
            assert.has_error(function() assertError(1) end, '"func" must be a function')
        end)
    end)
end)
