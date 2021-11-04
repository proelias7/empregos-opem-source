-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPReceiver.checkPayment(mod,health)
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        local pagamento = math.random(cfg.cargas[mod]['valor'][1],cfg.cargas[mod]['valor'][2])
		vRP.giveMoney(user_id,parseInt(pagamento+health))
	end
end



