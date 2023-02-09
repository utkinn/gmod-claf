-- Library loader. To use CLAF, add:
--     include 'claf.lua'
-- to the beginning of the file.

include('claf/aliases.lua')
table.Merge(_G, include('claf/enums.lua'))
table.Merge(_G, include('claf/lib.lua'))
table.Merge(_G, include('claf/fmt.lua'))
table.Merge(_G, include('claf/functional.lua'))
table.Merge(_G, include('claf/pipe.lua'))
table.Merge(_G, include('claf/assertions.lua'))
