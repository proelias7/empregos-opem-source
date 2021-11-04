local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_tecidos",emP)
local Tools = module("vrp","lib/Tools")

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('iniciotecido:sucesso')
AddEventHandler('iniciotecido:sucesso', function()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		TriggerClientEvent('confirmadotecido', source)
	end
end)

function emP.CheckPayment()
	local player = source
	local user_id = vRP.getUserId(source)		
	if user_id then
		TriggerClientEvent("vrp_sound:source",source,'coins',0.3)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>1</b> Nota Fiscal.") 
		vRP.giveInventoryItem(user_id,"notafiscaltecido", 1) 
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"empresario.permissao")
end

function emP.getitem()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.getInventoryItemAmount(user_id,"notafiscaltecido")
end

function emP.givemoneytecidos()
	local user_id = vRP.getUserId(source)
	local quantidade = vRP.getInventoryItemAmount(user_id,"notafiscaltecido")
	if vRP.tryGetInventoryItem(user_id,"notafiscaltecido",quantidade) then
		vRP.giveMoney(user_id,1500 * quantidade)
		TriggerClientEvent("Notify",source,"sucesso","Notas avaliadas.")
	else
		TriggerClientEvent("Notify",source,"negado","Notas insuficientes.")
	end	
end


--[[
RegisterCommand('trocarnotas',function(source,args,rawCommand)
	local player = source
	local user_id = vRP.getUserId(player)
	local quantidade = vRP.getInventoryItemAmount(user_id,"maconha")
	if vRP.tryGetInventoryItem(user_id,"maconha",quantidade) then
		TriggerClientEvent("progress",source,quantidade*1000,"AVALIANDO...")
		SetTimeout(quantidade*1000,function()
			vRP.giveMoney(user_id,500 * quantidade)	
			TriggerClientEvent("Notify",source,"sucesso","Aguarde enquanto as notas estão sendo processadas")
		end)
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui notas no invetario.") 
	end
end)
]]