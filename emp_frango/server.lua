local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_frango",emP)
local Tools = module("vrp","lib/Tools")

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('iniciofrango:sucesso')
AddEventHandler('iniciofrango:sucesso', function()
	local player = source
	local user_id = vRP.getUserId(player)
	if user_id then
		TriggerClientEvent('confirmadofrango', source)
	end
end)

function emP.CheckPayment()
	local player = source
	local user_id = vRP.getUserId(source)		
	if user_id then
		TriggerClientEvent("vrp_sound:source",source,'coins',0.3)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>1</b> Nota Fiscal.") 
		vRP.giveInventoryItem(user_id,"notafiscalfrango", 1) 
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
	return vRP.getInventoryItemAmount(user_id,"notafiscalfrango")
end

function emP.givemoneyfrango()
	local user_id = vRP.getUserId(source)
	local quantidade = vRP.getInventoryItemAmount(user_id,"notafiscalfrango")
	if vRP.tryGetInventoryItem(user_id,"notafiscalfrango",quantidade) then
		vRP.giveMoney(user_id,2500 * quantidade)-- bufado da semana (320)
		TriggerClientEvent("Notify",source,"sucesso","Notas avaliadas.")
	else
		TriggerClientEvent("Notify",source,"negado","Notas insuficientes.")
	end	
end
