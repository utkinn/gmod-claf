require("spec/gmod_polyfills")

_G.net = {}
_G.hook = {}

local _ = require("luassert.match")._
local lib = require("claf.lib")

describe("TODO", function()
    it("throws a \"not implemented\" error", function()
        assert.has_error(function()
            lib.TODO()
        end, "not implemented")
    end)

    it("throws a \"not implemented\" error with description", function()
        assert.has_error(function()
            lib.TODO("foo")
        end, "not implemented: foo")
    end)
end)

describe("ErrorIfNil", function()
    it("throws an error if the value is nil", function()
        assert.has_error(function()
            lib.ErrorIfNil(nil)
        end, "nil is not allowed here")
    end)

    it("does not throw if value is not nil", function()
        lib.ErrorIfNil(1)
    end)
end)

describe("Hook", function()
    insulate("", function()
        it("calls hook.Add with generated unique identifier", function()
            stub(hook, "Add")

            lib.Hook("event1", function()
            end)
            lib.Hook("event2", function()
            end)

            assert.stub(hook.Add).was.called_with("event1", "CLAFHook_1", _)
            assert.stub(hook.Add).was.called_with("event2", "CLAFHook_2", _)
        end)
    end)

    insulate("", function()
        it("calls hook.Add with specified identifier", function()
            stub(hook, "Add")

            lib.Hook("event1", function()
            end, "id1")
            lib.Hook("event2", function()
            end, "id2")

            assert.stub(hook.Add).was.called_with("event1", "id1", _)
            assert.stub(hook.Add).was.called_with("event2", "id2", _)
        end)
    end)

    insulate("", function()
        -- luacheck: globals Hook
        it("remembers last auto generated hook ID between includes", function()
            stub(hook, "Add")

            table.Merge(_G, include "claf/lib.lua")
            Hook("event1", function()
            end)
            table.Merge(_G, include "claf/lib.lua")
            Hook("event1", function()
            end)

            assert.stub(hook.Add).was.called_with("event1", "CLAFHook_1", _)
            assert.stub(hook.Add).was.called_with("event1", "CLAFHook_2", _)
        end)
    end)
end)

describe("Signal sends a net message with no payload", function()
    insulate("from server to specified client", function()
        it("", function()
            stub(net, "Start")
            stub(net, "Send")
            _G.SERVER = true
            _G.CLIENT = false
            local recipient = 1

            lib.Signal("message", recipient)

            assert.stub(net.Start).was.called_with("message")
            assert.stub(net.Send).was.called_with(recipient)
        end)
    end)

    insulate("from client to server", function()
        it("", function()
            stub(net, "Start")
            stub(net, "SendToServer")
            _G.SERVER = false
            _G.CLIENT = true

            lib.Signal("message")

            assert.stub(net.Start).was.called_with("message")
            assert.stub(net.SendToServer).was.called()
        end)
    end)
end)

describe("IsEven", function()
    it("returns true if the number is even", function()
        assert.True(lib.IsEven(2))
        assert.False(lib.IsEven(1))
    end)
end)

describe("IsOdd", function()
    it("returns true if the number is odd", function()
        assert.True(lib.IsOdd(1))
        assert.False(lib.IsOdd(2))
    end)
end)

describe("net.QuickMsg", function()
    insulate("on server", function()
        setup(function()
            _G.SERVER = true
            _G.CLIENT = false
            include("claf/lib.lua")
        end)

        describe("sends a message to a recipient", function()
            local recipient = 1

            before_each(function()
                stub(net, "Start")
                stub(net, "Write")
                stub(net, "Send")
            end)

            it("with one payload value", function()
                net.QuickMsg("message", recipient, 1)

                assert.stub(net.Start).was.called_with("message")
                assert.stub(net.Write).was.called_with(1)
                assert.stub(net.Send).was.called_with(recipient)
            end)

            it("with multiple payload values", function()
                net.QuickMsg("message", recipient, { 1, 2, 3 })

                assert.stub(net.Start).was.called_with("message")
                assert.stub(net.Write).was.called_with(1)
                assert.stub(net.Write).was.called_with(2)
                assert.stub(net.Write).was.called_with(3)
                assert.stub(net.Send).was.called_with(recipient)
            end)
        end)
    end)

    insulate("on client", function()
        setup(function()
            _G.SERVER = false
            _G.CLIENT = true
            include("claf/lib.lua")
        end)

        describe("sends a message to server", function()
            before_each(function()
                stub(net, "Start")
                stub(net, "Write")
                stub(net, "SendToServer")
            end)

            it("with one payload value", function()
                net.QuickMsg("message", 1)

                assert.stub(net.Start).was.called_with("message")
                assert.stub(net.Write).was.called_with(1)
                assert.stub(net.SendToServer).was.called()
            end)

            it("with multiple payload values", function()
                net.QuickMsg("message", { 1, 2, 3 })

                assert.stub(net.Start).was.called_with("message")
                assert.stub(net.Write).was.called_with(1)
                assert.stub(net.Write).was.called_with(2)
                assert.stub(net.Write).was.called_with(3)
                assert.stub(net.SendToServer).was.called()
            end)
        end)
    end)
end)
