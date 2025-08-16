-- Client-side script for LSPD system with armory, uniforms, vehicles, lockers and organizations menu

-- Command and key mapping to open the organizations menu
RegisterCommand('openOrgMenu', function()
    TriggerServerEvent('orgsys:getOrganizations')
end, false)

RegisterKeyMapping('openOrgMenu', 'Abrir men\u00fa de organizaciones', 'keyboard', 'TAB')

-- NUI event to receive organizations and open the organizations menu
RegisterNetEvent('orgsys:openMenu', function(orgs)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'openMenu', data = orgs })
end)

-- Close the NUI menu from JavaScript
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    cb('ok')
end)

-- Handle assigning ranks (stub for future expansion)
RegisterNUICallback('assignRank', function(data, cb)
    -- data contains organization key and rank
    TriggerServerEvent('orgsys:assignRank', data.orgKey, data.rank)
    cb('ok')
end)

-- Table to store interaction locations sent by the server
local Locations = {
    armory = {},
    uniforms = {},
    vehicles = {},
    lockers = {}
}

-- Request initial locations when the resource starts
Citizen.CreateThread(function()
    TriggerServerEvent('lspd:requestLocations')
end)

-- Receive updated locations from the server
RegisterNetEvent('lspd:updateLocations', function(locs)
    Locations = locs
end)

-- Main loop to draw markers and handle interactions at locations
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for type, locs in pairs(Locations) do
            for i = 1, #locs do
                local pos = locs[i]
                -- Draw a blue marker at the location
                DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 100, 255, 150, false, false, 2, false, nil, nil, false)
                -- Compute distance to player
                local dist = #(coords - vector3(pos.x, pos.y, pos.z))
                if dist < 1.5 then
                    -- Show help notification
                    SetTextComponentFormat('STRING')
                    AddTextComponentString('Pulsa ~INPUT_CONTEXT~ para interactuar')
                    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                    if IsControlJustReleased(0, 38) then -- E key
                        if type == 'armory' then
                            TriggerServerEvent('lspd:getArmory')
                        elseif type == 'vehicles' then
                            TriggerServerEvent('lspd:getVehicles')
                        elseif type == 'uniforms' then
                            TriggerServerEvent('lspd:getUniforms')
                        elseif type == 'lockers' then
                            -- Lockers system placeholder
                            TriggerEvent('chat:addMessage', { args = { '^1Locker', 'Sistema de casilleros no implementado.' } })
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

-- Open the selector menu for armory/uniforms/vehicles
RegisterNetEvent('lspd:openSelector', function(menuType, items, rank)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'openSelector', menuType = menuType, items = items, rank = rank })
end)

-- NUI callback when an item is selected
RegisterNUICallback('selectItem', function(data, cb)
    -- data.menuType indicates the menu (armory, vehicles, uniforms)
    local menuType = data.menuType
    local item = data.item
    if menuType == 'armory' then
        TriggerServerEvent('lspd:giveWeapon', item.name)
    elseif menuType == 'vehicles' then
        TriggerServerEvent('lspd:spawnVehicle', item.model)
    elseif menuType == 'uniforms' then
        TriggerServerEvent('lspd:applyUniform', item.key)
    end
    -- Close the selector UI
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeSelector' })
    cb('ok')
end)

-- NUI callback to close the selector without selection
RegisterNUICallback('closeSelector', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeSelector' })
    cb('ok')
end)

-- Apply a uniform to the player when instructed by the server
RegisterNetEvent('lspd:applyUniform', function(uniformKey)
    local ped = PlayerPedId()
    local uniform = Config.Uniforms[uniformKey]
    if not uniform then return end
    -- Determine gender based on model
    local model = GetEntityModel(ped)
    local isMale = (model == GetHashKey('mp_m_freemode_01'))
    local compList = uniform.male
    local propList = uniform.maleProps
    if not isMale then
        compList = uniform.female
        propList = uniform.femaleProps
    end
    -- Apply clothing components
    for _, comp in ipairs(compList) do
        SetPedComponentVariation(ped, comp.component, comp.drawable, comp.texture, 2)
    end
    -- Apply props like hats or glasses
    if propList then
        for _, prop in ipairs(propList) do
            SetPedPropIndex(ped, prop.prop, prop.drawable, prop.texture, true)
        end
    end
end)
