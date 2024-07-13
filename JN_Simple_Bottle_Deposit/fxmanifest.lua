fx_version "cerulean"
game {"gta5"}

Autor "Jannn.o"
Discription "surch Bottles from bins and sell them"

shared_script "@es_extended/imports.lua"

client_scripts {
    "client/*.lua",
    "Config.lua"
}

server_scripts {
    "server/*.lua",
    "Config.lua",
    "@mysql-async/lib/MySQL.lua"
}