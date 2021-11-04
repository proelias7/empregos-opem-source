local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("emp_tecidos")

function LocalPed()
	return GetPlayerPed(-1)
end

local veiculospaw = false
local visits = 1
local l = 0
local area = 0
local onjob = false
local CanLeaveItem = false
local stock = 0
local limitStock = 19
local HashKeyBox = 1405043423
local veh
local prop
local processo = false
local segundos = 0
local nveh = nil
local propcaixa = nil
local propcaixa2 = nil
local propcaixa3 = nil
local propcaixa4 = nil
local propcaixa5 = nil
local propcaixa6 = nil
local propcaixa7 = nil
local propcaixa8 = nil
local propcaixa9 = nil
local propcaixa10 = nil
local propcaixa11 = nil
local propcaixa12 = nil
local propcaixa13 = nil
local propcaixa14 = nil
local propcaixa15 = nil
local propcaixa16 = nil
local propcaixa17 = nil
local propcaixa18 = nil
local propcaixa19 = nil
local propcaixa20 = nil
local propcaixa21 = nil


local destination = {
	{ x = 67.25, y = -1399.04, z = 29.37},
	{ x = -699.92, y = -147.08, z = 37.85},
	{ x = -823.49, y = -1065.7, z = 11.66},
	{ x = -1180.96, y = -752.32, z = 19.55},
	{ x = -1444.57, y = -257.53, z = 46.21},
	{ x = 9.89, y = 6505.95, z = 31.54},
	{ x = 1700.36, y = 4815.89, z = 41.94},
	{ x = 121.64, y = -240.45, z = 53.36},
	{ x = -1128.51, y = 2691.9, z = 18.81},
	{ x = -3160.19, y = 1044.99, z = 20.85},
	{ x = 1184.69, y = 2721.75, z = 38.63},
	{ x = 619.15, y = 2784.92, z = 43.49}
}



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--blip de pegar O veiculos
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local ped = PlayerPedId()
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),713.98,-976.8,24.13)	
		if distancia <= 10.0 and veiculospaw == false and onjob then
			wait = 5
			DrawMarker(21,713.98,-976.8,24.13-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,129,242,248,150,0,0,0,1)
			if distancia <= 1.0 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA PEGAR A VAN",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					spawnStock3()
					veiculospaw = true		
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
	while true do
		wait = 1000
		DrawMarker(21,711.42,-968.92,30.4-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
		if GetDistanceBetweenCoords(711.42,-968.92,30.4, GetEntityCoords(LocalPed())) < 1.0 then
			wait = 5
			basiccheck()
		end
		DrawMarker(21,707.25,-966.98,30.42-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
		if GetDistanceBetweenCoords(707.25,-966.98,30.42, GetEntityCoords(LocalPed())) < 1.0 then
			wait = 5
			checknotas()
		end
		if onjob then 		
			wait = 5
			DrawMarker(21,751.45,-947.07,25.64-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(GetPlayerPed(-1))) < 30.0 then
				DrawMarker(21,destination[l].x, destination[l].y, destination[l].z,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)		
			end
			if GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then
				if not IsInVehicle() and CanLeaveItem then
					drawTxt("PRESSIONE ~b~E~s~ PARA ENTREGAR A ENCOMENDA", 4,0.5,0.93,0.50,255,255,255,180)
					if (IsControlJustReleased(1, 38)) then
						deliverysucces()
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)


Citizen.CreateThread(function()
	while true do
	wait = 1000
		local myCoords = GetEntityCoords(GetPlayerPed(-1))
		if onjob then	
			wait = 5
			if GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, 751.45,-947.07,25.64, true) < 0.5 and onjob then
				nearBoxFarm = true
				openMenuBox(nearBoxFarm)
			elseif GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, 751.45,-947.07,25.64, true) >= 0.5 and onjob then
				nearBoxFarm = false
				openMenuBox(nearBoxFarm)
			end
		end		
		Citizen.Wait(wait)
	end	
end)
RegisterNetEvent("confirmadotecido")
AddEventHandler("confirmadotecido", function()
   SpawnVan()
end)


Citizen.CreateThread(function()
	while true do
	wait = 1000
		local myCoords = GetEntityCoords(GetPlayerPed(-1))
		veh = getNearVeh(8)
		local model = GetEntityModel(veh)
		
		if model == -810318068 and onjob and CanLeaveItem then	
			wait = 5
			coordsCar = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.50, 0.0)	
			local distance = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coordsCar.x,coordsCar.y,coordsCar.z, true)
			if distance < 1.0 and onjob and CanLeaveItem then
				nearDeliveryCar = true
				openMenuDeliveryCar(nearDeliveryCar)
			elseif distance >= 3.0 and onjob and CanLeaveItem then
				nearDeliveryCar = false
				openMenuDeliveryCar(nearDeliveryCar)
			end
		end	
		
		if model == -810318068 and onjob and not CanLeaveItem then
			wait = 5
			coordsCar2 = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.50, 0.0)	
			local distance2 = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coordsCar2.x,coordsCar2.y,coordsCar2.z, true)
			if distance2 < 1.0 and onjob and not CanLeaveItem then
				nearDeliveryCar2 = true
				getBoxOnCar(nearDeliveryCar2)
			elseif distance2 >= 3.0 and onjob and not CanLeaveItem then
				nearDeliveryCar2 = false
				getBoxOnCar(nearDeliveryCar2)
			end
		end	
		Citizen.Wait(wait)		
	end	
end)

function basiccheck()
	if onjob == false then 
		drawTxt("PRESSIONE ~b~E~s~ PARA INICIAR TRABALHO", 4,0.5,0.93,0.50,255,255,255,180)
		if IsControlJustPressed (1, 38) then
			TriggerEvent('cancelando',true)
			TriggerEvent("progress",2000,"Iniciando o expediente")
			ExecuteCommand("e anotar")
			ExecuteCommand("roupas textil")
			SetTimeout(2000,function()
				TriggerEvent('cancelando',false)
				vRP._DeletarObjeto()
				ClearPedTasksImmediately(PlayerPedId())
				TriggerServerEvent('iniciotecido:sucesso')
				TriggerEvent("Notify","sucesso","trabalho Iniciado.")
			end)
		end
	else
		drawTxt("PRESSIONE ~b~H~s~ PARA SAIR DE TRABALHO", 4,0.5,0.93,0.50,255,255,255,180)
		if IsControlJustPressed(1, 74) then	
			TriggerEvent('cancelando',true)
			TriggerEvent("progress",2000,"saindo do trabalho")
			ExecuteCommand("e anotar")
			ExecuteCommand("roupas")
			SetTimeout(2000,function()
				TriggerEvent('cancelando',false)
				vRP._DeletarObjeto()
				ClearPedTasksImmediately(PlayerPedId())
				if nveh then
					TriggerServerEvent("trydeleteveh",VehToNet(nveh))
					nveh = nil
				end
				onjob = false
				stock = 0
				RemoveBlip(blips)
				SetWaypointOff()
				visits = 1
				if nveh then --deleta o veiculo
					TriggerServerEvent("trydeleteveh",VehToNet(nveh))
					nveh = nil
				end
				--daqui para baixo deleta as props-------
				if DoesEntityExist(propcaixa) then
					DetachEntity(propcaixa,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa))
					propcaixa = nil
				end
				if DoesEntityExist(propcaixa2) then
					DetachEntity(propcaixa2,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa2))
					propcaixa2 = nil
				end
				if DoesEntityExist(propcaixa3) then
					DetachEntity(propcaixa3,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa3))
					propcaixa3 = nil
				end
				if DoesEntityExist(propcaixa4) then
					DetachEntity(propcaixa4,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa4))
					propcaixa4 = nil
				end 
				if DoesEntityExist(propcaixa5) then
					DetachEntity(propcaixa5,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa5))
					propcaixa5 = nil
				end
				if DoesEntityExist(propcaixa6) then
					DetachEntity(propcaixa6,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa6))
					propcaixa6 = nil
				end
				if DoesEntityExist(propcaixa7) then
					DetachEntity(propcaixa7,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa7))
					propcaixa7 = nil
				end
				if DoesEntityExist(propcaixa8) then
					DetachEntity(propcaixa8,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa8))
					propcaixa8 = nil
				end
				if DoesEntityExist(propcaixa9) then
					DetachEntity(propcaixa9,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa9))
					propcaixa9 = nil
				end
				if DoesEntityExist(propcaixa10) then
					DetachEntity(propcaixa10,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa10))
					propcaixa10 = nil
				end
				if DoesEntityExist(propcaixa11) then
					DetachEntity(propcaixa11,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa11))
					propcaixa11 = nil
				end
				if DoesEntityExist(propcaixa12) then
					DetachEntity(propcaixa12,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa12))
					propcaixa12 = nil
				end
				if DoesEntityExist(propcaixa13) then
					DetachEntity(propcaixa13,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa13))
					propcaixa13 = nil
				end
				if DoesEntityExist(propcaixa14) then
					DetachEntity(propcaixa14,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa14))
					propcaixa14 = nil
				end
				if DoesEntityExist(propcaixa15) then
					DetachEntity(propcaixa15,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa15))
					propcaixa15 = nil
				end
				if DoesEntityExist(propcaixa16) then
					DetachEntity(propcaixa16,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa16))
					propcaixa16 = nil
				end
				if DoesEntityExist(propcaixa17) then
					DetachEntity(propcaixa17,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa17))
					propcaixa17 = nil
				end
				if DoesEntityExist(propcaixa18) then
					DetachEntity(propcaixa18,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa18))
					propcaixa18 = nil
				end
				if DoesEntityExist(propcaixa19) then
					DetachEntity(propcaixa19,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa19))
					propcaixa19 = nil
				end
				if DoesEntityExist(propcaixa20) then
					DetachEntity(propcaixa20,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa20))
					propcaixa20 = nil
				end
				if DoesEntityExist(propcaixa21) then
					DetachEntity(propcaixa21,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa21))
					propcaixa21 = nil
				end 
			end)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------
--Sitema de tranca das Portas
----------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		wait = 1000
		local veh = GetStockPosition(10)
		local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.6, 0.0)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),coordsStock.x,coordsStock.y,coordsStock.z,true)
        local model = GetEntityModel(veh)
		if distance <= 1.0 and not IsPedInAnyVehicle(PlayerPedId()) and onjob then
			wait = 5
			if model == -810318068 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
			    if portacaminhao == false then
			        DrawText3Ds(coordsStock.x,coordsStock.y,coordsStock.z+0.95,"~b~[Z] ~w~Abrir")
				    if IsControlJustPressed(0,20) then
				        SetVehicleDoorOpen(veh, 3, false, false)
						SetVehicleDoorOpen(veh, 2, false, false)
				        portacaminhao = true
				    end
                elseif portacaminhao == true then
	                DrawText3Ds(coordsStock.x,coordsStock.y,coordsStock.z+0.95,"~b~[Z] ~w~Fechar")
				    if IsControlJustPressed(0,20) then
				        SetVehicleDoorShut(veh, 3, false)
						SetVehicleDoorShut(veh, 2, false)
				        portacaminhao = false
					end
				end
            end
        end
		if distance <= 1.5 and not IsPedInAnyVehicle(PlayerPedId()) and onjob then
			wait = 5
			if model == -810318068 and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
				DrawText3Ds(coordsStock.x,coordsStock.y,coordsStock.z+0.7,"  ~b~"..stock.."~w~  /  ~b~20    ")
			end
		end
		Citizen.Wait(wait)
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function checknotas()
	drawTxt("PRESSIONE ~b~E~s~ PARA AVALIAR NOTAS FISCAIS", 4,0.5,0.93,0.50,255,255,255,180)
	if IsControlJustPressed (1, 38) then
		if emP.checkPermission() then
			local quantidade = emP.getitem()
			if quantidade >= 1 then
				TriggerEvent('cancelando',true)
				TriggerEvent("progress",quantidade*1000,"Avaliando...")
				ExecuteCommand("e prancheta")
				SetTimeout(quantidade*1000,function()
					emP.givemoneytecidos()
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

function IsInVehicle()
local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end
portacaminhao = false
function openMenuDeliveryCar(nearDeliveryCar)
	local ply = GetPlayerPed(-1)
	local veh = GetStockPosition(10)
	local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
	local model = GetEntityModel(veh)
	if nearDeliveryCar and CanLeaveItem and portacaminhao == true then
		if stock <= limitStock then
			drawTxt("PRESSIONE ~b~E~s~ PARA GUARDAR A CAIXA DE TECIDO NA VAN", 4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(1, 38) then
				CaixaStock(veh,model)
				local pid = PlayerPedId()
				DetachEntity(prop, true, false)
				SetEntityCoords(prop, 0.0, 0.0, 0.0, false, false, false, true)
				CanLeaveItem = false
				RequestAnimDict("anim@heists@money_grab@briefcase")
				while (not HasAnimDictLoaded("anim@heists@money_grab@briefcase")) do
					Citizen.Wait(10) 
				end
				TaskPlayAnim(pid,"anim@heists@money_grab@briefcase","put_down_case",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
				Wait(2000)
				StopAnimTask(pid, "anim@heists@money_grab@briefcase","put_down_case", 1.0)
				stock = stock + 1	
			end
		else
			drawTxt("A van esta cheio efetue mais entregas", 4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end

function getBoxOnCar(nearDeliveryCar2)
	if nearDeliveryCar2 and not CanLeaveItem and GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(GetPlayerPed(-1))) < 20.0 and portacaminhao == true then
		if stock >= 1 then
			drawTxt("PRESSIONE ~b~E~s~ PARA PEGAR A CAIXA DE TECIDO NA VAN", 4,0.5,0.93,0.50,255,255,255,180)
			if (IsControlJustPressed(1, 38)) then
				Citizen.Wait(100)	
				CanLeaveItem = true
				TirarCaixa()
			end				
			if CanLeaveItem then
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
				local prop = CreateObject(HashKeyBox, x+5.5, y+5.5, z+0.2,  true,  true, true)
				AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 11816), -0.17, 0.38, -0.050, 15.0, 285.0, 270.0, true, true, false, true, 1, true)
				RequestAnimDict('anim@heists@box_carry@')
				while not HasAnimDictLoaded('anim@heists@box_carry@') do
					Wait(0)
				end
				TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				repeat
				Citizen.Wait(100)
				if CanLeaveItem == false then
					DeleteEntity(prop)
				end
				until(CanLeaveItem == false)	
			end
		else		
			drawTxt("A van esta vazio busque mais encomendas.", 4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end

function openMenuBox(nearBoxFarm)
	if nearBoxFarm and onjob then
		if stock <= limitStock then
			drawTxt("PRESSIONE ~b~E~s~ PARA PEGAR A CAIXA", 4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(1, 38) then
				Citizen.Wait(100)	
				CanLeaveItem = true	
				vRP._DeletarObjeto()
			end
			if CanLeaveItem then
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
				local prop = CreateObject(HashKeyBox, x+5.5, y+5.5, z+0.2,  true,  true, true)
				AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 11816), -0.17, 0.38, -0.050, 15.0, 285.0, 270.0, true, true, false, true, 1, true)
				RequestAnimDict('anim@heists@box_carry@')
				while not HasAnimDictLoaded('anim@heists@box_carry@') do
					Wait(0)
				end
				TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				repeat
				Citizen.Wait(100)
				if CanLeaveItem == false then
					DeleteEntity(prop)
				end
				until(CanLeaveItem == false)
			end
		else
			drawTxt("A VAN ESTÁ CHEIA, EFETUE ALGUMAS ENTREGAS", 4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end


function startjob()
	onjob = true
	area = 1
	if area == 1 then 
	l = math.random(1,12)
	end
	CriandoBlip(locs,selecionado)
end

function SpawnVan()
	if (IsInVehicle()) then
		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("mule4")) then
			startjob()
		end
	else
		Citizen.Wait(10)
		startjob()
	end
end

function deliverysucces()
	emP.CheckPayment()
	StopAnimTask(GetPlayerPed(-1), 'anim@heists@box_carry@', 'idle', 1.0)
	DetachEntity(prop, true, false)
	SetEntityCoords(prop, 0.0, 0.0, 0.0, false, false, false, true)
	CanLeaveItem = false
	stock = stock - 1
	if stock == 0 then
		TriggerEvent("Notify","aviso","Não possui mais caixas de tecidos.")		
	else
		RemoveBlip(blips)
		startjob()
	end
end
function spawnStock3()
	local mhash = "speedo"
	if not nveh then
	 while not HasModelLoaded(mhash) do
	  RequestModel(mhash)
	    Citizen.Wait(10)
	 end
		local ped = PlayerPedId()
		local x,y,z = vRP.getPosition()
		nveh = CreateVehicle(mhash,711.02,-979.71,24.12+0.5,226.45,true,false)
		SetVehicleIsStolen(nveh,false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehicleDirtLevel(nveh,0.0)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
		SetModelAsNoLongerNeeded(mhash)
	end
end
--------------------------------------------------------------------------------------------------------------------------------------
--seta as prop dentro do veiculo
--------------------------------------------------------------------------------------------------------------------------------------
function CaixaStock(veh,model)
	if stock <= limitStock then
		RequestModel(GetHashKey("prop_apple_box_01"))
        while not HasModelLoaded(GetHashKey("prop_apple_box_01")) do
            Citizen.Wait(10)
        end
	    local coords = GetOffsetFromEntityInWorldCoords(veh,0.0,0.0,-5.0)
		if stock == 0 and model == -810318068 then
			propcaixa = nil
			propcaixa = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa,veh,0.0,-0.45,-2.2,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa,true)
		elseif stock == 1 and model == -810318068 then
			propcaixa2 = nil
			propcaixa2 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa2,veh,0.0,0.0,-2.2,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa2,true)
		elseif stock == 2 and model == -810318068 then
			propcaixa3 = nil
			propcaixa3 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa3,veh,0.0,0.45,-2.2,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa3,true)
		elseif stock == 3 and model == -810318068 then
			propcaixa4 = nil
			propcaixa4 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa4,veh,0.0,-0.45,-1.8,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa4,true)
		elseif stock == 4 and model == -810318068 then
			propcaixa5 = nil
			propcaixa5 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa5,veh,0.0,0.0,-1.8,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa5,true)
		elseif stock == 5 and model == -810318068 then
			propcaixa6 = nil
			propcaixa6 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa6,veh,0.0,0.45,-1.8,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa6,true)
		elseif stock == 6 and model == -810318068 then
			propcaixa7 = nil
			propcaixa7 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa7,veh,0.0,-0.45,-1.4,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa7,true)
		elseif stock == 7 and model == -810318068 then
			propcaixa8 = nil
			propcaixa8 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa8,veh,0.0,0.0,-1.4,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa8,true)
		elseif stock == 8 and model == -810318068 then
			propcaixa9 = nil
			propcaixa9 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa9,veh,0.0,0.45,-1.4,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa9,true)
		elseif stock == 9 and model == -810318068 then
			propcaixa10 = nil
			propcaixa10 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa10,veh,0.0,-0.45,-1.0,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa10,true)
		elseif stock == 10 and model == -810318068 then
			propcaixa11 = nil
			propcaixa11 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa11,veh,0.0,0.0,-1.0,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa11,true)
		elseif stock == 11 and model == -810318068 then
			propcaixa12 = nil
			propcaixa12 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa12,veh,0.0,0.45,-1.0,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa12,true)
		elseif stock == 12 and model == -810318068 then
			propcaixa13 = nil
			propcaixa13 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa13,veh,0.0,-0.45,-0.6,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa13,true)
		elseif stock == 13 and model == -810318068 then
			propcaixa14 = nil
			propcaixa14 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa14,veh,0.0,0.0,-0.6,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa14,true)
		elseif stock == 14 and model == -810318068 then
			propcaixa15 = nil
			propcaixa15 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa15,veh,0.0,0.45,-0.6,0.00,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa15,true)
		elseif stock == 15 and model == -810318068 then
			propcaixa16 = nil
			propcaixa16 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa16,veh,0.0,-0.45,-0.6,0.25,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa16,true)
		elseif stock == 16 and model == -810318068 then
			propcaixa17 = nil
			propcaixa17 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa17,veh,0.0,0.0,-0.6,0.25,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa17,true)
		elseif stock == 17 and model == -810318068 then
			propcaixa18 = nil
			propcaixa18 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa18,veh,0.0,0.45,-0.6,0.25,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa18,true)
		elseif stock == 18 and model == -810318068 then
			propcaixa19 = nil
			propcaixa19 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa19,veh,0.0,-0.45,-1.0,0.25,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa19,true)
		elseif stock == 19 and model == -810318068 then
			propcaixa20 = nil
			propcaixa20 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa20,veh,0.0,0.0,-1.0,0.25,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa20,true)
		elseif stock == 20 and model == -810318068 then
			propcaixa21 = nil
			propcaixa21 = CreateObject(GetHashKey("prop_apple_box_01"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa21,veh,0.0,0.45,-1.0,0.25,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa21,true)		
		end
	end
end
---------------------------------------------------------------------------------------------------------------------
--retira a caixa do veiculo
---------------------------------------------------------------------------------------------------------------------
function TirarCaixa()
	if stock == 1 then
        if DoesEntityExist(propcaixa) then
			DetachEntity(propcaixa,false,false)
			FreezeEntityPosition(propcaixa,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa))
            propcaixa = nil
        end
	elseif stock == 2 then
		if DoesEntityExist(propcaixa2) then
			DetachEntity(propcaixa2,false,false)
			FreezeEntityPosition(propcaixa2,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa2))
            propcaixa2 = nil
        end
	elseif stock == 3 then
		if DoesEntityExist(propcaixa3) then
			DetachEntity(propcaixa3,false,false)
			FreezeEntityPosition(propcaixa3,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa3))
            propcaixa3 = nil
        end
	elseif stock == 4 then
		if DoesEntityExist(propcaixa4) then
			DetachEntity(propcaixa4,false,false)
			FreezeEntityPosition(propcaixa4,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa4))
            propcaixa4 = nil
        end
	elseif stock == 5 then
		if DoesEntityExist(propcaixa5) then
			DetachEntity(propcaixa5,false,false)
			FreezeEntityPosition(propcaixa5,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa5))
            propcaixa5 = nil
        end
	elseif stock == 6 then
		if DoesEntityExist(propcaixa6) then
			DetachEntity(propcaixa6,false,false)
			FreezeEntityPosition(propcaixa6,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa6))
            propcaixa6 = nil
        end
    elseif stock == 7 then
		if DoesEntityExist(propcaixa7) then
			DetachEntity(propcaixa7,false,false)
			FreezeEntityPosition(propcaixa7,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa7))
            propcaixa7 = nil
        end
    elseif stock == 8 then
		if DoesEntityExist(propcaixa8) then
			DetachEntity(propcaixa8,false,false)
			FreezeEntityPosition(propcaixa8,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa8))
            propcaixa8 = nil
        end
    elseif stock == 9 then
		if DoesEntityExist(propcaixa9) then
			DetachEntity(propcaixa9,false,false)
			FreezeEntityPosition(propcaixa9,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa9))
            propcaixa9 = nil
        end
    elseif stock == 10 then
		if DoesEntityExist(propcaixa10) then
			DetachEntity(propcaixa10,false,false)
			FreezeEntityPosition(propcaixa10,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa10))
            propcaixa10 = nil
        end
    elseif stock == 11 then
		if DoesEntityExist(propcaixa11) then
			DetachEntity(propcaixa11,false,false)
			FreezeEntityPosition(propcaixa11,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa11))
            propcaixa11 = nil
        end
    elseif stock == 12 then
		if DoesEntityExist(propcaixa12) then
			DetachEntity(propcaixa12,false,false)
			FreezeEntityPosition(propcaixa12,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa12))
            propcaixa12 = nil
        end
    elseif stock == 13 then
		if DoesEntityExist(propcaixa13) then
			DetachEntity(propcaixa13,false,false)
			FreezeEntityPosition(propcaixa13,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa13))
            propcaixa13 = nil
        end
    elseif stock == 14 then
		if DoesEntityExist(propcaixa14) then
			DetachEntity(propcaixa14,false,false)
			FreezeEntityPosition(propcaixa14,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa14))
            propcaixa14 = nil
        end
    elseif stock == 15 then
		if DoesEntityExist(propcaixa15) then
			DetachEntity(propcaixa15,false,false)
			FreezeEntityPosition(propcaixa15,false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa15))
            propcaixa15 = nil
        end
	
	elseif stock == 16 then
		if DoesEntityExist(propcaixa16) then
			DetachEntity(propcaixa16,false,false)
			FreezeEntityPosition(propcaixa16,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa16))
			propcaixa16 = nil
		end
	
	elseif stock == 17 then
		if DoesEntityExist(propcaixa17) then
			DetachEntity(propcaixa17,false,false)
			FreezeEntityPosition(propcaixa17,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa17))
			propcaixa17 = nil
		end
	elseif stock == 18 then
		if DoesEntityExist(propcaixa18) then
			DetachEntity(propcaixa18,false,false)
			FreezeEntityPosition(propcaixa18,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa18))
			propcaixa18 = nil
		end
	
	elseif stock == 19 then
		if DoesEntityExist(propcaixa19) then
			DetachEntity(propcaixa19,false,false)
			FreezeEntityPosition(propcaixa19,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa19))
			propcaixa19 = nil
		end
	
	elseif stock == 20 then
		if DoesEntityExist(propcaixa20) then
			DetachEntity(propcaixa20,false,false)
			FreezeEntityPosition(propcaixa20,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa20))
			propcaixa20 = nil
		end
	
	elseif stock == 21 then
		if DoesEntityExist(propcaixa20) then
			DetachEntity(propcaixa20,false,false)
			FreezeEntityPosition(propcaixa20,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa20))
			propcaixa20 = nil
		end
	end
end
------------------------------------------------------------------------------------------------------------
function getNearVeh(radius)
	local playerPed = GetPlayerPed(-1)
	local coordA = GetEntityCoords(playerPed, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, radius+0.00001, 0.0)
	local nearVehicle = getVehicleInDirection(coordA, coordB)

	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordA)
	    if IsPedSittingInAnyVehicle(playerPed) then
	        local veh = GetVehiclePedIsIn(playerPed, true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 8192+4096+4+2+1)
	        if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 4+2+1) end
	        return veh
	    end
	end
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(destination[l].x,destination[l].y,destination[l].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,3)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de tecido")
	EndTextCommandSetBlipName(blips)
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

function GetStockPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetStockDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordsx)
	    if IsPedSittingInAnyVehicle(ped) then
	        local veh = GetVehiclePedIsIn(ped,true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,8192+4096+4+2+1) 
	        if not IsEntityAVehicle(veh) then 
	        	veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,4+2+1) 
	        end 
	        return veh
	    end
	end
end

function GetStockDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
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