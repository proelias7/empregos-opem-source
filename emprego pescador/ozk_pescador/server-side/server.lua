-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

function vRPReceiver.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local peixe = cfg.peixes[math.random(#cfg.peixes)]
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(peixe) <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,peixe,1,true)
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.") 
		end
	end
end
function vRPReceiver.taskFishing2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return cnVRP.taskFishing(source)
	end
end

function vRPReceiver.checkItemPesca()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id,cfg.itemvara) >= 1 and vRP.getInventoryItemAmount(user_id,cfg.itemisca) >= 1 and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dourado") <= vRP.getInventoryMaxWeight(user_id) then
			vRP.tryGetInventoryItem(user_id,cfg.itemisca,1,true)
            return true 
        else
			if vRP.getInventoryItemAmount(user_id,cfg.itemvara) == 0 then
				TriggerClientEvent("Notify",source,"negado","Você não possui uma Vara de Pescar em sua mochila.")
			end
			if vRP.getInventoryItemAmount(user_id,cfg.itemisca) == 0 then
				TriggerClientEvent("Notify",source,"negado","Você não possui Isca em sua mochila.") 
			end
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
            return false
        end
    end
end


function vRPReceiver.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"microvRPReceiverreendedor.permissao") or vRP.hasPermission(user_id,"macrovRPReceiverreendedor.permissao") or vRP.hasPermission(user_id,"vRPReceiverresario.permissao")
end

function vRPReceiver.getitem()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.getInventoryItemAmount(user_id,"notafiscalpeixe")
end

function vRPReceiver.givemoneypeixe()
	local user_id = vRP.getUserId(source)
	local quantidade = vRP.getInventoryItemAmount(user_id,"notafiscalpeixe")
	if vRP.tryGetInventoryItem(user_id,"notafiscalpeixe",quantidade) then
		vRP.giveMoney(user_id,50 * quantidade)
		TriggerClientEvent("Notify",source,"sucesso","Notas avaliadas.")
	else
		TriggerClientEvent("Notify",source,"negado","Notas insuficientes.")
	end	
end