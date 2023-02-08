stds.gmod = {
    globals = {
        "bit",
        "include",
        "FindMetaTable",
        "Run",
        "RunString",
        table = {
            fields = {
                "Merge",
                "Copy",
                "IsSequential",
                "Reverse",
            }
        },
        "tobool",
        "isfunction",
        "istable",
        "isstring",
        "Color",
        "MsgC",
        string = {
            fields = {
                "Explode",
                "StartWith",
                "Replace",
            }
        },
        "net",
        "hook",
        "SERVER",
        "CLIENT",
        "ErrorIfNil",
    },
}

std = "luajit+gmod"
