Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPReceiver = {}
Tunnel.bindInterface("ozk_caminhoneiro",vRPReceiver)
vRPSend = Tunnel.getInterface("ozk_caminhoneiro")
