fx_version "bodacious"
game "gta5"

author 'proelias7 by QUANTIC STORE'
description 'Central de Chamadas para policia'
version '1.0.1'

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"utils/lib.lua",
	"cfg.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"utils/lib.lua",
	"cfg.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/*/**"
}