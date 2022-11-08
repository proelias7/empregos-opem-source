local contServico = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPReceiver.sendCode(service)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)
		players = vRP.getUsersByPermission(cfg.permTicket)
		local description = cfg.call[service].descrisao

		TriggerClientEvent("Notify",source,"sucesso","Chamado efetuado com sucesso.",5000)
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")

		local x,y,z = vRPclient.getPosition(source)
		local identity = vRP.getUserIdentity(user_id)
		for k,v in pairs(players) do
			local sourcecall = vRP.getUserSource(v)
			local identitys = vRP.getUserIdentity(v)
			if v and v ~= source then
				async(function()
					if service == "QTH" then
						TriggerClientEvent("NotifyPush",sourcecall,{ code = service, title = "OCORRÊNCIA", x = x, y = y, z = z, badge = description.." de <b>"..identity.name.." "..identity.firstname.."</b>." })
						TriggerClientEvent('locpolicial',sourcecall,x,y,z,user_id)
						--vRPclient._setGPS(player,x,y)
					else
						TriggerClientEvent("NotifyPush",sourcecall,{ code = service, title = "OCORRÊNCIA", x = x, y = y, z = z, badge = "<b>"..description.."</b>." })
					end
				end)
			end
		end
	end
end

function vRPReceiver.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
    for _,v in pairs(cfg.perm) do
	    if vRP.hasPermission(user_id,v) then
            return true
        end
    end
    return false
end