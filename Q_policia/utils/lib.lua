Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPReceiver = {}
Tunnel.bindInterface("Q_policia",vRPReceiver)
vRPSend = Tunnel.getInterface("Q_policia")