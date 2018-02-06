-- Functions handy for unit testing.

function assertNot(any)
    assert(not any)
end

function assertNotNil(any)
    assert(any ~= nil)
end

function assertNoError(func)
    local noErrors = pcall(func)
    assert(noErrors)
end

function assertError(func)
    local noErrors = pcall(func)
    assertNot(noErrors)
end
