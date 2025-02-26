local framework = exports.bln_lib:framework()
local lootedEntities = {}

local function LogDebug(...)
    if Config.Debug then
        print('^3[Loot System]^7', ...)
    end
end

local function RollRandom(min, max)
    return math.floor(min + math.random() * (max - min + 1))
end

local function GetRandomFromTable(table)
    if #table == 0 then return nil end
    return table[math.random(#table)]
end

local function CreateCooldownKey(coords)
    local x = math.floor(coords.x)
    local y = math.floor(coords.y)
    local z = math.floor(coords.z)
    return string.format("%d:%d:%d", x, y, z)
end

local function ProcessContainerLoot(source, containerModel, coords)
    local containerConfig = Config.Containers[containerModel]
    local foundSomething = false
    local user = framework:getUser(source)

    if not containerConfig then
        return
    end

    if containerConfig.rewards.money.enabled and math.random(100) <= containerConfig.rewards.money.chance then
        local amount = RollRandom(containerConfig.rewards.money.min, containerConfig.rewards.money.max)
        user:addMoney(amount)
        foundSomething = true
        LogDebug("Player found $" .. amount .. " in container")
    end

    if containerConfig.rewards.items.enabled then
        for _, item in ipairs(containerConfig.rewards.items.list) do
            if math.random(100) <= item.chance then
                local quantity = RollRandom(item.min, item.max)
                local success = framework:giveItem(source, item.name, quantity)

                if success then
                    foundSomething = true
                    LogDebug("Player found " .. quantity .. "x " .. item.name .. " in container")
                end
            end
        end
    end

    return foundSomething
end

local function ProcessPedLoot(source, pedModel)
    if Config.Peds.blacklist[pedModel] then
        return false
    end

    local foundSomething = false
    local user = framework:getUser(source)

    if Config.Peds.rewards.money.enabled and math.random(100) <= Config.Peds.rewards.money.chance then
        local amount = RollRandom(Config.Peds.rewards.money.min, Config.Peds.rewards.money.max)
        user:addMoney(amount)
        foundSomething = true
        LogDebug("Player found $" .. amount .. " on ped")
    end

    if Config.Peds.rewards.items.enabled then
        for _, item in ipairs(Config.Peds.rewards.items.list) do
            if math.random(100) <= item.chance then
                local quantity = RollRandom(item.min, item.max)
                local success = framework:giveItem(source, item.name, quantity)

                if success then
                    foundSomething = true
                    LogDebug("Player found " .. quantity .. "x " .. item.name .. " on ped")
                end
            end
        end
    end

    return foundSomething
end

local function ProcessAnimalLoot(source, animalModel)
    local animalConfig = Config.Animals[animalModel]
    local foundSomething = false

    if not animalConfig then
        return false
    end

    if animalConfig.rewards.items.enabled then
        for _, item in ipairs(animalConfig.rewards.items.list) do
            local quantity = RollRandom(item.min, item.max)
            local success = framework:giveItem(source, item.name, quantity)

            if success then
                foundSomething = true
                LogDebug("Player found " .. quantity .. "x " .. item.name .. " on animal")
            end
        end
    end

    return foundSomething
end

local function ProcessEntityLoot(source, entityId, model, entityType, coords)
    if entityType == "container" then
        return ProcessContainerLoot(source, model, coords)
    elseif entityType == "ped" then
        return ProcessPedLoot(source, model)
    elseif entityType == "animal" then
        return ProcessAnimalLoot(source, model)
    end

    return false
end


RegisterNetEvent("bln_loot_hunter:checkContainerCooldown")
AddEventHandler("bln_loot_hunter:checkContainerCooldown", function(entityNetId, containerModel, coords)
    local source = source
    local coordsKey = CreateCooldownKey(coords)
    local currentTime = os.time()

    if lootedEntities[coordsKey] and lootedEntities[coordsKey] > currentTime then
        local message = GetRandomFromTable(Config.Notifications.Cooldown.messages)
        TriggerClientEvent("bln_loot_hunter:sendNotification", source, message)
        return
    end

    lootedEntities[coordsKey] = currentTime + (Config.Cooldown / 1000)

    local rewards = {
        money = 0,
        items = {}
    }

    local containerConfig = Config.Containers[containerModel]
    local user = framework:getUser(source)
    local foundSomething = false

    if not containerConfig then
        return
    end

    if containerConfig.rewards.money.enabled and math.random(100) <= containerConfig.rewards.money.chance then
        local amount = RollRandom(containerConfig.rewards.money.min, containerConfig.rewards.money.max)
        user:addMoney(amount)
        rewards.money = amount
        foundSomething = true
        LogDebug("Player found $" .. amount .. " in container")
    end

    if containerConfig.rewards.items.enabled then
        for _, item in ipairs(containerConfig.rewards.items.list) do
            if math.random(100) <= item.chance then
                local quantity = RollRandom(item.min, item.max)
                local success = framework:giveItem(source, item.name, quantity)

                if success then
                    table.insert(rewards.items, { name = item.name, quantity = quantity })
                    foundSomething = true
                    LogDebug("Player found " .. quantity .. "x " .. item.name .. " in container")
                end
            end
        end
    end

    if foundSomething then
        TriggerClientEvent("bln_loot_hunter:rewardNotification", source, rewards)
    else
        local message = GetRandomFromTable(Config.Notifications.Empty.messages)
        TriggerClientEvent("bln_loot_hunter:sendNotification", source, message)
    end
end)

RegisterNetEvent("bln_loot_hunter:checkEntityCooldown")
AddEventHandler("bln_loot_hunter:checkEntityCooldown", function(entityNetId, entityModel, entityType, coords)
    local source = source
    local success = false

    local rewards = {
        money = 0,
        items = {}
    }

    if entityType == "ped" then
        local coordsKey = CreateCooldownKey(coords)
        local currentTime = os.time()

        if lootedEntities[coordsKey] and lootedEntities[coordsKey] > currentTime then
            local message = GetRandomFromTable(Config.Notifications.Cooldown.messages)
            TriggerClientEvent("bln_loot_hunter:sendNotification", source, message)
            return
        end

        lootedEntities[coordsKey] = currentTime + (Config.Cooldown / 1000)

        if not Config.Peds.blacklist[entityModel] then
            local user = framework:getUser(source)

            if Config.Peds.rewards.money.enabled and math.random(100) <= Config.Peds.rewards.money.chance then
                local amount = RollRandom(Config.Peds.rewards.money.min, Config.Peds.rewards.money.max)
                user:addMoney(amount)
                rewards.money = amount
                success = true
                LogDebug("Player found $" .. amount .. " on ped")
            end

            if Config.Peds.rewards.items.enabled then
                for _, item in ipairs(Config.Peds.rewards.items.list) do
                    if math.random(100) <= item.chance then
                        local quantity = RollRandom(item.min, item.max)
                        local itemSuccess = framework:giveItem(source, item.name, quantity)

                        if itemSuccess then
                            table.insert(rewards.items, { name = item.name, quantity = quantity })
                            success = true
                            LogDebug("Player found " .. quantity .. "x " .. item.name .. " on ped")
                        end
                    end
                end
            end
        end
    elseif entityType == "animal" then
        local animalConfig = Config.Animals[entityModel]

        if not animalConfig then
            return
        end

        if animalConfig.rewards.items.enabled then
            for _, item in ipairs(animalConfig.rewards.items.list) do
                local quantity = RollRandom(item.min, item.max)
                local itemSuccess = framework:giveItem(source, item.name, quantity)

                if itemSuccess then
                    table.insert(rewards.items, { name = item.name, quantity = quantity })
                    success = true
                    LogDebug("Player found " .. quantity .. "x " .. item.name .. " on animal")
                end
            end
        end
    end

    if success then
        TriggerClientEvent("bln_loot_hunter:rewardNotification", source, rewards)
    else
        local message = GetRandomFromTable(Config.Notifications.Empty.messages)
        TriggerClientEvent("bln_loot_hunter:sendNotification", source, message)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)

        local currentTime = os.time()
        local keysToRemove = {}

        for key, time in pairs(lootedEntities) do
            if time < currentTime then
                table.insert(keysToRemove, key)
            end
        end

        for _, key in ipairs(keysToRemove) do
            lootedEntities[key] = nil
        end

        if Config.Debug and #keysToRemove > 0 then
            LogDebug("Cleaned up " .. #keysToRemove .. " expired loot cooldowns")
        end
    end
end)

if Config and Config.Debug then
    RegisterCommand('clearlootcooldowns', function(source, args)
        if source == 0 then
            lootedEntities = {}
            print("^2[Loot System] All loot cooldowns cleared^7")
        else
            lootedEntities = {}
            TriggerClientEvent('chat:addMessage', source, {
                color = { 255, 255, 0 },
                multiline = true,
                args = { "[SYSTEM]", "All loot cooldowns cleared" }
            })
        end
    end, true)
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    print("^2[Loot System] Initialized for " .. framework:get() .. " framework^7")
end)
