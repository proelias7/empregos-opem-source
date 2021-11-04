fx_version 'bodacious'
game 'gta5'

author 'proelias7'
description 'emprego de caminhoneiro'
version '1.0.0'

ui_page "web-side/ui.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"utils/lib.lua",
	"cfg.lua",
	"client-side/client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"utils/lib.lua",
	"cfg.lua",
	"server-side/server.lua"
}

files {
	"web-side/*"
}