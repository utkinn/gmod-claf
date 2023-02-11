local fakeMetatables = {}

function FindMetaTable(mt)
    fakeMetatables[mt] = fakeMetatables[mt] or {}
    return fakeMetatables[mt]
end

_G["FindMetaTable"] = FindMetaTable

require "claf/aliases"

describe("Entity method aliases", function()
    it("GetHealth() == Health()", function()
        local entityMetatable = FindMetaTable("Entity")
        entityMetatable.Health = function()
            return 100
        end
        assert.are.equal(100, entityMetatable:GetHealth())
    end)
end)

describe("Player method aliases", function()
    it("IsAlive() == Alive()", function()
        local playerMetatable = FindMetaTable("Player")
        playerMetatable.Alive = function()
            return true
        end
        assert.are.equal(true, playerMetatable:IsAlive())
    end)

    it("GetArmor() == Armor()", function()
        local playerMetatable = FindMetaTable("Player")
        playerMetatable.Armor = function()
            return 100
        end
        assert.are.equal(100, playerMetatable:GetArmor())
    end)
end)

it("Run()", function()
    stub(_G, "RunString")
    Run("__x = 1")
    assert.stub(RunString).was.called_with("__x = 1")
end)
