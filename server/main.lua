-- Server-side script for LSPD system

-- When players request organizations, send them the configuration
RegisterNetEvent('orgsys:getOrganizations', function()
    local src = source
    TriggerClientEvent('orgsys:openMenu', src, Config.Organizations)
end)
