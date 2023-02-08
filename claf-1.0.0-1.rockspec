-- Rockspec purely for dependency management

package = "CLAF"
version = "1.0.0-1"
dependencies = {
    "lua >= 5.1",
    "busted ~> 2",
    "luacov ~> 0.15",
    "luacheck ~> 0.23",
}
source = {
    url = "git://github.com/javabird25/gmod-claf.git",
}
build = {
    type = "none",
}