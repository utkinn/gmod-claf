-- Library loader. To use CLAF, add:
--     include 'claf.lua'
-- to the beginning of the file.

include('includes/modules/claf/aliases.lua')
table.Merge(_G, include('includes/modules/claf/enums.lua'))
table.Merge(_G, include('includes/modules/claf/lib.lua'))
table.Merge(_G, include('includes/modules/claf/fmt.lua'))
table.Merge(_G, include('includes/modules/claf/functional.lua'))
table.Merge(_G, include('includes/modules/claf/pipe.lua'))
table.Merge(_G, include('includes/modules/claf/assertions.lua'))
