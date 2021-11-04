Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPReceiver = {}
Tunnel.bindInterface("ozk_pescador",vRPReceiver)
vRPSend = Tunnel.getInterface("ozk_pescador")
cnVRP = Tunnel.getInterface("vrp_taskbar")--funcão de chamar a task aponte ela para o script de task