-- Functions handy for unit testing.

function assertNot(any)
    assert(not any)
end

function assertNotNil(any)
    assert(any ~= nil)
end

function assertNil(any)
    assert(any == nil)
end

function assertNoError(func)
    if not isfunction(func) then error '"func" must be a function' end
    local noErrors = pcall(func)
    assert(noErrors)
end

function assertError(func)
    if not isfunction(func) then error '"func" must be a function' end
    local noErrors = pcall(func)
    assertNot(noErrors)
end
