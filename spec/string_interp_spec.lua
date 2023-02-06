require 'lua/claf/fmt'

describe('fmt""', function()
    it('replaces patterns like {var} with variable values', function()
        local var = '{value}'
        local null = nil
        assert.equal('{value} nil', fmt'{var} {null}')
    end)

    it('ignores strings without substitution patterns', function()
        assert.equal('no substitution', fmt'no substitution')
    end)

    it('inserts "nil" in place of invalid substitution patterns', function()
        assert.equal('nil', fmt'{!!!}')
    end)

    it('does not substitute patterns like {{this}}', function()
        assert.equal('{a}', fmt'{{a}}')
    end)

    describe('supports table access syntax in substitution patterns', function()
        it('(1 level)', function()
            local tbl = { a = 1 }
            local str = fmt'-{tbl.a}-'
            assert.are.equal('-1-', str)
        end)
        it('(3 levels)', function()
            local tbl = { a = { b = { c = 1 } } }
            local str = fmt'{tbl.a.b.c}'
            assert.are.equal('1', str)
        end)
    end)
end)