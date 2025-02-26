local function GetEntityTypeString(entity)
    if not DoesEntityExist(entity) then
        return "unknown"
    end

    if IsEntityAPed(entity) then
        if not Citizen.InvokeNative(0xB980061DA992779D, entity) then -- not is ped human
            return "animal"
        else
            return "ped"
        end
    elseif IsEntityAnObject(entity) then
        return "container"
    else
        return "unknown"
    end
end

local function SendNotification(notifData)
    if not notifData or not notifData.title then return end

    TriggerEvent('bln_notify:send', {
        title = notifData.title,
        message = notifData.message
    }, notifData.type)
end

RegisterNetEvent("bln_loot_hunter:sendNotification")
AddEventHandler("bln_loot_hunter:sendNotification", function(notifData)
    SendNotification(notifData)
end)

local function HandleContainerInteraction(searcherPedId, searchedEntityId, isContainerClosedAfter)
    if searcherPedId == PlayerPedId() and isContainerClosedAfter == 0 then
        local containerModel = GetEntityModel(searchedEntityId)
        local containerConfig = Config.Containers[containerModel]

        if not containerConfig then
            return
        end

        if Config.Debug then
            print("Player opened " .. containerConfig.label .. " (Model Hash: " .. containerModel .. ")")
            local x, y, z = table.unpack(GetEntityCoords(searchedEntityId))
            print("Location: " .. x .. ", " .. y .. ", " .. z)
        end

        local containerNetId = NetworkGetNetworkIdFromEntity(searchedEntityId)
        local coords = GetEntityCoords(searchedEntityId)
        TriggerServerEvent("bln_loot_hunter:checkContainerCooldown", containerNetId, containerModel, coords)
    end
end

local function HandleLootComplete(looterId, lootedEntityId, isLootSuccess)
    if looterId == PlayerPedId() and isLootSuccess == 1 then
        if DoesEntityExist(lootedEntityId) then
            local entityType = GetEntityTypeString(lootedEntityId)
            local model = GetEntityModel(lootedEntityId)

            if Config.Debug then
                print("Looted entity model: " .. model)
                print("Entity type: " .. entityType)
            end

            local entityNetId = NetworkGetNetworkIdFromEntity(lootedEntityId)
            local coords = GetEntityCoords(lootedEntityId)
            TriggerServerEvent("bln_loot_hunter:checkEntityCooldown", entityNetId, model, entityType, coords)
        end
    end
end

RegisterNetEvent("bln_loot_hunter:rewardNotification")
AddEventHandler("bln_loot_hunter:rewardNotification", function(rewards)
    if rewards.money > 0 then
        TriggerEvent('bln_notify:send', {
            title = "~img:leaderboard_cash~ " .. rewards.money,
        }, "TIP")
    end

    if #rewards.items > 0 then
        for i, item in ipairs(rewards.items) do
            TriggerEvent('bln_notify:send', {
                title = "~img:" .. Config.inventoryURL .. item.name .. ".png~" .. " X" .. item.quantity .. "",
            }, "TIP")
            Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local size = GetNumberOfEvents(0)

        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)

                if eventAtIndex == GetHashKey("EVENT_CONTAINER_INTERACTION") then
                    local eventDataStruct = DataView.ArrayBuffer(32)
                    eventDataStruct:SetInt32(0, 0)
                    eventDataStruct:SetInt32(8, 0)
                    eventDataStruct:SetInt32(16, 0)
                    eventDataStruct:SetInt32(24, 0)

                    local isDataExists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, 0, i, eventDataStruct:Buffer(), 4)

                    if isDataExists then
                        local searcherPedId = eventDataStruct:GetInt32(0)
                        local searchedEntityId = eventDataStruct:GetInt32(8)
                        local isContainerClosedAfter = eventDataStruct:GetInt32(24)

                        HandleContainerInteraction(searcherPedId, searchedEntityId, isContainerClosedAfter)
                    end
                elseif eventAtIndex == GetHashKey("EVENT_LOOT_COMPLETE") then
                    local eventDataStruct = DataView.ArrayBuffer(24)
                    eventDataStruct:SetInt32(0, 0)
                    eventDataStruct:SetInt32(8, 0)
                    eventDataStruct:SetInt32(16, 0)

                    local isDataExists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, 0, i, eventDataStruct:Buffer(), 3)

                    if isDataExists then
                        local looterId = eventDataStruct:GetInt32(0)
                        local lootedEntityId = eventDataStruct:GetInt32(8)
                        local isLootSuccess = eventDataStruct:GetInt32(16)

                        HandleLootComplete(looterId, lootedEntityId, isLootSuccess)
                    end
                end
            end
        end
    end
end)

if Config and Config.Debug then
    RegisterCommand('lootdebug', function()
        local playerPed = PlayerPedId()
        local success, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

        if success and DoesEntityExist(entity) then
            local coords = GetEntityCoords(entity)
            local model = GetEntityModel(entity)
            local netId = NetworkGetNetworkIdFromEntity(entity)
            local entityType = GetEntityTypeString(entity)

            print('Entity Debug:')
            print('Type: ' .. entityType)
            print('Model: ' .. model)
            print('NetID: ' .. netId)
            print('Coords: ' .. coords.x .. ', ' .. coords.y .. ', ' .. coords.z)
        else
            print('No entity in aim')
        end
    end, false)
end
