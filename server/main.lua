-- Server-side script for LSPD system with armory, uniforms, vehicles and lockers

-- Table to hold player ranks (keyed by player source)
local PlayerRanks = {}

-- Helper function to get a player's rank (0 if none)
local function getPlayerRank(src)
    return PlayerRanks[src] or 0
end

-- When players request organizations, send them the configuration
RegisterNetEvent('orgsys:getOrganizations', function()
    local src = source
    TriggerClientEvent('orgsys:openMenu', src, Config.Organizations)
end)

-- Assign a rank to a player (called from the organizations menu)
RegisterNetEvent('orgsys:assignRank', function(orgKey, rank)
    local src = source
    PlayerRanks[src] = tonumber(rank) or 0
end)

-- Broadcast updated locations to all clients
local function broadcastLocations()
    TriggerClientEvent('lspd:updateLocations', -1, Config.Locations)
end

-- Commands for rank 20 to set locations
RegisterCommand('setarmory', function(source)
    if getPlayerRank(source) == 20 then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        table.insert(Config.Locations.armory, coords)
        broadcastLocations()
    end
end, false)

RegisterCommand('setuniform', function(source)
    if getPlayerRank(source) == 20 then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        table.insert(Config.Locations.uniforms, coords)
        broadcastLocations()
    end
end, false)

RegisterCommand('setgarage', function(source)
    if getPlayerRank(source) == 20 then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        table.insert(Config.Locations.vehicles, coords)
        broadcastLocations()
    end
end, false)

RegisterCommand('setlocker', function(source)
    if getPlayerRank(source) == 20 then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        table.insert(Config.Locations.lockers, coords)
        broadcastLocations()
    end
end, false)

-- Provide locations to a player when requested
RegisterNetEvent('lspd:requestLocations', function()
    local src = source
    TriggerClientEvent('lspd:updateLocations', src, Config.Locations)
end)

-- Armory: send weapons list to player
RegisterNetEvent('lspd:getArmory', function()
    local src = source
    local rank = getPlayerRank(src)
    TriggerClientEvent('lspd:openSelector', src, 'armory', Config.Weapons, rank)
end)

-- Give the selected weapon to the player if they have the rank
RegisterNetEvent('lspd:giveWeapon', function(weaponName)
    local src = source
    local rank = getPlayerRank(src)
    for _, w in ipairs(Config.Weapons) do
        if w.name == weaponName then
            if rank >= w.minRank then
                local ped = GetPlayerPed(src)
                GiveWeaponToPed(ped, GetHashKey(w.name), 250, false, true)
            end
            break
        end
    end
end)

-- Vehicles: send vehicle list to player
RegisterNetEvent('lspd:getVehicles', function()
    local src = source
    local rank = getPlayerRank(src)
    TriggerClientEvent('lspd:openSelector', src, 'vehicles', Config.Vehicles, rank)
end)

-- Spawn a selected vehicle for the player
RegisterNetEvent('lspd:spawnVehicle', function(model)
    local src = source
    local rank = getPlayerRank(src)
    for _, v in ipairs(Config.Vehicles) do
        if v.model == model then
            if rank >= v.minRank then
                local ped = GetPlayerPed(src)
                local coords = GetEntityCoords(ped)
                local heading = GetEntityHeading(ped)
                local hash = GetHashKey(model)
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Wait(10)
                end
                local veh = CreateVehicle(hash, coords.x, coords.y, coords.z, heading, true, true)
                TaskWarpPedIntoVehicle(ped, veh, -1)
            end
            break
        end
    end
end)

-- Uniforms: send uniforms list to player
RegisterNetEvent('lspd:getUniforms', function()
    local src = source
    local rank = getPlayerRank(src)
    TriggerClientEvent('lspd:openSelector', src, 'uniforms', Config.Uniforms, rank)
end)

-- Apply selected uniform to player (handled on client)
RegisterNetEvent('lspd:applyUniform', function(uniformKey)
    local src = source
    TriggerClientEvent('lspd:applyUniform', src, uniformKey)
end)
