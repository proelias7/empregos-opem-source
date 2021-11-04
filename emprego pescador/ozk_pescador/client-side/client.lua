-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local notify = false
local segundos = 0
local segtask = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('pescador')
AddEventHandler('pescador',function()
	if not processo then
		local ped = PlayerPedId()
		for k,v in pairs(cfg.locs) do
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),v.x,v.y,v.z)
			if distancia <= v.raio then
				notify = true
				if not IsPedInAnyVehicle(ped) then
					if vRPSend.checkItemPesca() then
						processo = true
						segundos = cfg.segundos
						segtask = math.random(2,20)
						timepesca()
						timeprocesso()
						if not IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
							vRP._CarregarObjeto("amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",15,60309)
						end
						TriggerEvent('cancelando',true)
					end
				end
			end
		end
		Citizen.Wait(1000)
		if not notify then
			TriggerEvent("Notify","negado","Você não está em uma área de pesca.")
		end
		notify = false
	end
end)

function timepesca()
	Citizen.CreateThread(function()
		while true do
			wait = 1000
			--[[
			local distance2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),723.0,4189.51,41.1,true)
			if distance2 <= 15 then
				wait = 5
				DrawMarker(21,723.0,4189.51,41.1-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,129,242,248,150,0,0,0,1)
				if GetDistanceBetweenCoords(723.0,4189.51,41.1, GetEntityCoords(LocalPed())) < 1.0 then
					checknotaspeixe()
				end
			end]]
			---------------------------------------------------------------------------------------------------------
			---------------------------------------------------------------------------------------------------------
			---------------------------------------------------------------------------------------------------------
			if processo then
				wait = 5
				drawTxt("AGUARDE ATÉ VISGAR UM PEIXE",4,0.25,0.96,0.50,255,255,255,180)
			else
				break
			end
			Citizen.Wait(wait)
		end
	end)
end
function timeprocesso()
	Citizen.CreateThread(function()
		while true do
			wait = 1000
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == segtask then
					if vRPSend.taskFishing2() then
						processo = false
						vRPSend.checkPayment()
						vRP._stopAnim(false)
						vRP._DeletarObjeto()
						TriggerEvent('cancelando',false)
					else
						processo = false
						vRP._stopAnim(false)
						vRP._DeletarObjeto()
						TriggerEvent('cancelando',false)
						TriggerEvent("Notify","negado","O Peixe Escapou	.")
					end
				end
			else
				break
			end
			Citizen.Wait(wait)
		end
	end)
end

function checknotaspeixe()
	drawTxt("PRESSIONE ~b~E~s~ PARA AVALIAR NOTAS FISCAIS", 4,0.5,0.93,0.50,255,255,255,180)
	if IsControlJustPressed (1, 38) then
		if vRPSend.checkPermission() then
			local quantidade = vRPSend.getitem()
			if quantidade >= 1 then
				TriggerEvent('cancelando',true)
				TriggerEvent("progress",quantidade*1000,"Avaliando...")
				ExecuteCommand("e prancheta")
				SetTimeout(quantidade*1000,function()
					vRPSend.givemoneypeixe()
					TriggerEvent('cancelando',false)
					vRP._DeletarObjeto()
					ClearPedTasksImmediately(PlayerPedId())
				end)
			else	
				TriggerEvent("Notify","negado","Você não possui notas para avaliar.")
			end	
		else
			TriggerEvent("Notify","negado","Você não pode avaliar notas.")
		end	
	end
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3D(x,y,z, text, scl, font) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 180)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end