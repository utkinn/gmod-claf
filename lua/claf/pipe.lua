local pipeClass = {}

function pipeClass:Map(editor)
    self.source = Map(self.source, editor)
    return self
end

function pipeClass:Filter(filter)
    self.source = Filter(self.source, filter)
    return self
end

function pipeClass:FilterKeyed(filter)
    self.source = FilterKeyed(self.source, filter)
    return self
end

function pipeClass:Any()
    return Any(self.source)
end

function pipeClass:All()
    return All(self.source)
end

function pipeClass:None()
    return None(self.source)
end

function pipeClass:Count(predicate)
    return Count(self.source, predicate)
end

function pipeClass:One()
    return One(self.source)
end

function pipeClass:Few()
    return Few(self.source)
end

function pipeClass:Flatten()
    self.source = Flatten(self.source)
    return self
end

function pipeClass:Min()
    return Min(self.source)
end

function pipeClass:Max()
    return Max(self.source)
end

function pipeClass:Reverse()
    self.source = table.Reverse(self.source)
    return self
end

function pipeClass:Reduce(reducer, initial)
    return Reduce(self.source, reducer, initial)
end

function pipeClass:Sum()
    return Sum(self.source)
end

function pipeClass:ToTable()
    return self.source
end

function Pipe(tbl)
    return setmetatable({ source = tbl }, { __index = pipeClass })
end