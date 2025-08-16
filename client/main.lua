-- Client-side script for LSPD system

-- Command and key mapping to open the organizations menu
RegisterCommand('openOrgMenu', function()
    TriggerServerEvent('orgsys:getOrganizations')
end, false)

RegisterKeyMapping('openOrgMenu', 'Abrir menú de organizaciones', 'keyboard', 'TAB')

-- Receive data from the server to open the NUI menu
RegisterNetEvent('orgsys:openMenu', function(orgs)
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'open', data = orgs})
end)

-- Close the NUI menu from JavaScript
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'close'})
    cb('ok')
end)

-- Handle assigning ranks (stub for future expansion)
RegisterNUICallback('assignRank', function(data, cb)
    -- data contains organization, player, and rank information
    -- Trigger server events here to assign rank (not implemented)
    cb('ok')
end)
