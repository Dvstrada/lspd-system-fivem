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
