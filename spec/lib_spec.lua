require("spec/gmod_polyfills")

_G.net = {}
_G.hook = {}

local match = require("luassert.match")
local _ = match._
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
    it("calls hook.Add with generated unique identifier", function()
        stub(hook, "Add")

        lib.Hook("event1", function()
        end)
        lib.Hook("event2", function()
        end)

        assert.stub(hook.Add).was.called_with("event1", "CLAFHook_1", _)
        assert.stub(hook.Add).was.called_with("event2", "CLAFHook_2", _)
    end)

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
