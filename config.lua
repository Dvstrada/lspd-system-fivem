Config = {}

-- Organization categories
Config.Organizations = {
    ['government'] = {
        label = 'Gobierno',
        organizations = {
            ['lspd'] = {
                label = 'Los Santos Police Department',
                ranks = {
                    [20] = 'Chief of Police',
                    [19] = 'Assistant Chief of Police',
                    [18] = 'Deputy Chief of Police',
                    [17] = 'Commander',
                    [16] = 'Captain III',
                    [15] = 'Captain II',
                    [14] = 'Captain I',
                    [13] = 'Lieutenant II',
                    [12] = 'Lieutenant I',
                    [11] = 'Sergeant II',
                    [10] = 'Sergeant I',
                    [9]  = 'Detective III',
                    [8]  = 'Detective II',
                    [7]  = 'Detective I',
                    [6]  = 'Police Officer III',
                    [5]  = 'Police Officer II',
                    [4]  = 'Police Officer I',
                    [3]  = 'Probationary Officer',
                    [2]  = 'Recruit',
                    [1]  = 'Cadet'
                }
            }
        }
    },
    ['business'] = {
        label = 'Empresas',
        organizations = {
            -- Add company organizations here
        }
    },
    ['gangs'] = {
        label = 'Bandas criminales',
        organizations = {
            -- Add gang organizations here
        }
    }
}

-- Locations for armory, uniforms, vehicles and lockers
Config.Locations = {
    armory = {},
    uniforms = {},
    vehicles = {},
    lockers = {}
}

-- Weapons available in the armory (vanilla GTA weapons)
Config.Weapons = {
    {label = 'Pistola', name = 'WEAPON_PISTOL', minRank = 1},
    {label = 'Escopeta corredera', name = 'WEAPON_PUMPSHOTGUN', minRank = 5},
    {label = 'Rifle Carbine', name = 'WEAPON_CARBINERIFLE', minRank = 10},
    {label = 'Subfusil (SMG)', name = 'WEAPON_SMG', minRank = 8},
    {label = 'Porra', name = 'WEAPON_NIGHTSTICK', minRank = 0}
}

-- Vehicles available in the motor pool
Config.Vehicles = {
    {label = 'Police Cruiser', model = 'police', minRank = 1},
    {label = 'Police Buffalo', model = 'police2', minRank = 5},
    {label = 'Police Interceptor', model = 'police3', minRank = 8},
    {label = 'Police Bike', model = 'policeb', minRank = 3},
    {label = 'Riot Van', model = 'riot', minRank = 15}
}

-- Uniform presets using vanilla component variations
-- Each uniform has a male and female table listing component variations and props
Config.Uniforms = {
    classb = {
        label = 'Uniforme Clase B (Patrulla)',
        male = {
            {component=3, drawable=0, texture=0},    -- Arms
            {component=4, drawable=35, texture=0},   -- Pants
            {component=6, drawable=25, texture=0},   -- Shoes
            {component=8, drawable=58, texture=0},   -- Undershirt
            {component=11, drawable=55, texture=0}  -- Shirt / Vest
        },
        maleProps = {
            {prop=0, drawable=46, texture=0}
        },
        female = {
            {component=3, drawable=0, texture=0},
            {component=4, drawable=34, texture=0},   -- female pants approximate
            {component=6, drawable=25, texture=0},
            {component=8, drawable=35, texture=0},   -- female undershirt
            {component=11, drawable=48, texture=0}   -- female shirt
        },
        femaleProps = {
            {prop=0, drawable=45, texture=0}
        }
    },
    swat = {
        label = 'Uniforme SWAT',
        male = {
            {component=3, drawable=17, texture=0},   -- Arms heavy
            {component=4, drawable=32, texture=1},   -- Tactical pants
            {component=6, drawable=24, texture=0},   -- Boots
            {component=8, drawable=54, texture=0},   -- Utility shirt
            {component=9, drawable=27, texture=0},   -- Body armour
            {component=11, drawable=53, texture=0}   -- Tactical jacket
        },
        maleProps = {
            {prop=0, drawable=52, texture=0},        -- Helmet
            {prop=1, drawable=1, texture=1}          -- Glasses
        },
        female = {
            {component=3, drawable=14, texture=0},
            {component=4, drawable=30, texture=1},
            {component=6, drawable=24, texture=0},
            {component=8, drawable=52, texture=0},
            {component=9, drawable=25, texture=0},
            {component=11, drawable=50, texture=0}
        },
        femaleProps = {
            {prop=0, drawable=52, texture=0},
            {prop=1, drawable=1, texture=1}
        }
    }
}
