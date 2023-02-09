-- Library loader. To use CLAF, add:
--     include 'claf.lua'
-- to the beginning of the file.

table.Merge(_G, require('claf/aliases'))
table.Merge(_G, require('claf/enums'))
table.Merge(_G, require('claf/lib'))
table.Merge(_G, require('claf/fmt'))
table.Merge(_G, require('claf/functional'))
table.Merge(_G, require('claf/pipe'))
table.Merge(_G, require('claf/assertions'))
