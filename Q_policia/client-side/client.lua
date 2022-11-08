-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping ( 'call:policia' , '[V] aperte' , 'keyboard' , 'F9' )
RegisterCommand('call:policia', function(source,args)
	if vRPSend.checkPermission() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "openSystem" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendCode",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })
	vRPSend.sendCode(data.code)
end)

local blips = {}
RegisterNetEvent('locpolicial')
AddEventHandler('locpolicial',function(x,y,z,user_id)
	if not DoesBlipExist(blips[user_id]) then
		blips[user_id] = AddBlipForCoord(x,y,z)
		SetBlipScale(blips[user_id],0.5)
		SetBlipSprite(blips[user_id],161)
		SetBlipColour(blips[user_id],26)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Localização Policial")
		EndTextCommandSetBlipName(blips[user_id])
		SetBlipAsShortRange(blips[user_id],false)
		SetTimeout(30000,function()
			if DoesBlipExist(blips[user_id]) then
				RemoveBlip(blips[user_id])
			end
		end)
	end
end)