-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local random = 0
local modules = ""
local servico = false
local servehicle = nil
local CoordenadaX2 = 0.0
local CoordenadaY2 = 0.0
local CoordenadaZ2 = 0.0
local segundos = 0
local r = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO DE DURAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function time()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if segundos > 0 then
				segundos = segundos - 1
			else
				break
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		wait = 1000
		if servico then
			local ped = PlayerPedId()
			local distance = Vdist(GetEntityCoords(ped),CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			if distance <= 100.0 then
				wait = 5
				DrawMarker(23,CoordenadaX2,CoordenadaY2,CoordenadaZ2-0.96,0,0,0,0,0,0,10.0,10.0,1.0,255,164,11,500,0,0,0,0)
				if distance <= 5.9 then
					local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
					if GetEntityModel(vehicle) == servehicle and segundos == 0 then
						drawTxt("Pressione ~o~E~w~ Para Descarregar",4,0.5,0.93,0.50,255,255,255,180)
					end
					if IsControlJustPressed(0,38) then
						if GetEntityModel(vehicle) == servehicle then
							segundos = 10
							time()
							ExecuteCommand("e prancheta")
							while servico do
								if segundos > 0 then
									drawTxt("DESCARREGANDO: ~o~"..segundos.."~w~ SEGUNDOS",4,0.5,0.93,0.50,255,255,255,180)
								else
									vRPSend.checkPayment(modules,parseInt(GetVehicleBodyHealth(GetPlayersLastVehicle())/10))
									TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
									if DoesEntityExist(vehicle) then
										TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
									end
									ClearPedTasks(PlayerPedId())
									vRP._DeletarObjeto()
									RemoveBlip(blips)
									servico = false
								end
								Citizen.Wait(5)
							end
						end
					end
				end
			end
		else
			local distancemenu = Vdist(GetEntityCoords(PlayerPedId()),cfg.locmenu[1],cfg.locmenu[2],cfg.locmenu[3])
			if distancemenu <= 5 then
				wait = 5
				DrawMarker(27, cfg.locmenu[1],cfg.locmenu[2],cfg.locmenu[3]-1, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.7000, 0.7000, 0.5000, 255,164,11,500, 0, 0, 0, 1)
				if distancemenu <= 1.5 then
					if IsControlJustPressed(0,38) then
						ExecuteCommand("e anotar")
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	ClearPedTasks(PlayerPedId())
	vRP._DeletarObjeto()
	if data ~= "fechar" and segundos == 0 then
		ToggleActionMenu()
		spawnCarga(cfg.cargas[data]['spawnCarga'][1],cfg.cargas[data]['spawnCarga'][2],cfg.cargas[data]['spawnCarga'][3],cfg.cargas[data]['spawnCarga'][4],cfg.cargas[data]['spawnCarga'][5])
		servico = true
		modules = data
		servehicle = cfg.cargas[data]['hashvehicle']
		r = math.random(#cfg.cargas[data]['locs'])
		CoordenadaX2 = cfg.cargas[data]['locs'][r].x
		CoordenadaY2 = cfg.cargas[data]['locs'][r].y
		CoordenadaZ2 = cfg.cargas[data]['locs'][r].z
		CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
		TriggerEvent("Notify","sucesso","Carga de <b>"..data.."</b> liberada.")
		segundos = 10
		time()
	else
		ToggleActionMenu()
	end
end)

function spawnCarga(name,x,y,z,h)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end
	if HasModelLoaded(mhash) then
		local nveh = CreateVehicle(mhash,x,y,z+0.5,h,true,false)
		SetVehicleOnGroundProperly(nveh)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		SetEntityAsMissionEntity(nveh,true,true)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function CriandoBlip(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,47)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Carga")
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