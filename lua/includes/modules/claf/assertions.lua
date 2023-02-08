-- Functions handy for unit testing.

local mod = {}

function mod.assertNot(any)
    assert(not any)
end

function mod.assertNotNil(any)
    assert(any ~= nil)
end

function mod.assertNil(any)
    assert(any == nil)
end

function mod.assertNoError(func)
    if not isfunction(func) then error '"func" must be a function' end
    local noErrors = pcall(func)
    assert(noErrors)
end

function mod.assertError(func)
    if not isfunction(func) then error '"func" must be a function' end
    local noErrors = pcall(func)
    mod.assertNot(noErrors)
end

return mod
