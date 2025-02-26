Config = {}

Config.Debug = false

Config.Cooldown = 600000 -- Global cooldown for containers and peds in ms (10 minutes)

Config.inventoryURL = "nui://vorp_inventory/html/img/items/"

Config.Containers = {
    [`p_chest02x`] = {
        label = "Chest",
        rewards = {
            money = {
                enabled = true,
                min = 5.0,
                max = 25.0,
                chance = 60 -- 60% chance
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldbar",     min = 1,  max = 3,  chance = 60 },
                    { name = "goldwatch",   min = 1,  max = 2,  chance = 50 },
                    { name = "diamond",     min = 1,  max = 1,  chance = 60 },
                    { name = "pistol_ammo", min = 10, max = 20, chance = 70 }
                }
            }
        }
    },
    [`p_coffer01x`] = {
        label = "Coffer",
        rewards = {
            money = {
                enabled = true,
                min = 5.0,
                max = 25.0,
                chance = 60 -- 60% chance
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldbar",     min = 1,  max = 3,  chance = 60 },
                    { name = "goldwatch",   min = 1,  max = 2,  chance = 50 },
                    { name = "diamond",     min = 1,  max = 1,  chance = 60 },
                    { name = "pistol_ammo", min = 10, max = 20, chance = 70 }
                }
            }
        }
    },
    [`p_chest_lg_01`] = {
        label = "Large Chest",
        rewards = {
            money = {
                enabled = true,
                min = 5.0,
                max = 25.0,
                chance = 60 -- 60% chance
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldbar",     min = 1,  max = 3,  chance = 30 },
                    { name = "goldwatch",   min = 1,  max = 2,  chance = 50 },
                    { name = "diamond",     min = 1,  max = 1,  chance = 15 },
                    { name = "pistol_ammo", min = 10, max = 20, chance = 70 }
                }
            }
        }
    },
    [`p_chest_med_01`] = {
        label = "Medium Chest",
        rewards = {
            money = {
                enabled = true,
                min = 3.0,
                max = 15.0,
                chance = 50
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 40 },
                    { name = "pistol_ammo",   min = 5, max = 15, chance = 60 },
                    { name = "medicine_poor", min = 1, max = 2,  chance = 50 }
                }
            }
        }
    },
    [`p_chest_sm_01`] = {
        label = "Small Chest",
        rewards = {
            money = {
                enabled = true,
                min = 1.0,
                max = 10.0,
                chance = 40
            },
            items = {
                enabled = true,
                list = {
                    { name = "medicine_poor", min = 1, max = 1,  chance = 40 },
                    { name = "pistol_ammo",   min = 5, max = 10, chance = 50 },
                    { name = "bread",         min = 1, max = 2,  chance = 60 }
                }
            }
        }
    },
    [`p_drawer01x`] = {
        label = "Drawer",
        rewards = {
            money = {
                enabled = true,
                min = 0.5,
                max = 5.0,
                chance = 30
            },
            items = {
                enabled = true,
                list = {
                    { name = "cigarettepack", min = 1, max = 2, chance = 50 },
                    { name = "bread",         min = 1, max = 1, chance = 30 }
                }
            }
        }
    },
    [`p_drawer02x`] = {
        label = "Drawer",
        rewards = {
            money = {
                enabled = true,
                min = 0.5,
                max = 5.0,
                chance = 30
            },
            items = {
                enabled = true,
                list = {
                    { name = "cigarettepack", min = 1, max = 2, chance = 50 },
                    { name = "bread",         min = 1, max = 1, chance = 30 }
                }
            }
        }
    },
    [`p_drawer03x`] = {
        label = "Drawer",
        rewards = {
            money = {
                enabled = true,
                min = 0.5,
                max = 5.0,
                chance = 30
            },
            items = {
                enabled = true,
                list = {
                    { name = "cigarettepack", min = 1, max = 2, chance = 50 },
                    { name = "bread",         min = 1, max = 1, chance = 30 }
                }
            }
        }
    },

    [`p_dresserval01x`] = {
        label = "Drawer",
        rewards = {
            money = {
                enabled = true,
                min = 0.5,
                max = 5.0,
                chance = 30
            },
            items = {
                enabled = true,
                list = {
                    { name = "cigarettepack", min = 1, max = 2, chance = 50 },
                    { name = "bread",         min = 1, max = 1, chance = 30 }
                }
            }
        }
    },

    [`p_cabinet02x`] = {
        label = "Cabinet",
        rewards = {
            money = {
                enabled = true,
                min = 1.0,
                max = 7.0,
                chance = 40
            },
            items = {
                enabled = true,
                list = {
                    { name = "medicine_poor", min = 1, max = 1, chance = 30 },
                    { name = "pistol_ammo",   min = 3, max = 8, chance = 40 },
                    { name = "whiskey",       min = 1, max = 1, chance = 50 }
                }
            }
        }
    },
    [`p_cabinet03x`] = {
        label = "Cabinet",
        rewards = {
            money = {
                enabled = true,
                min = 1.0,
                max = 7.0,
                chance = 40
            },
            items = {
                enabled = true,
                list = {
                    { name = "medicine_poor", min = 1, max = 1, chance = 30 },
                    { name = "pistol_ammo",   min = 3, max = 8, chance = 40 },
                    { name = "whiskey",       min = 1, max = 1, chance = 50 }
                }
            }
        }
    },
    [`p_cabinet04x`] = {
        label = "Cabinet",
        rewards = {
            money = {
                enabled = true,
                min = 1.0,
                max = 7.0,
                chance = 40
            },
            items = {
                enabled = true,
                list = {
                    { name = "medicine_poor", min = 1, max = 1, chance = 30 },
                    { name = "pistol_ammo",   min = 3, max = 8, chance = 40 },
                    { name = "whiskey",       min = 1, max = 1, chance = 50 }
                }
            }
        }
    },
    [`p_dresser01x`] = {
        label = "Dresser",
        rewards = {
            money = {
                enabled = true,
                min = 2.0,
                max = 12.0,
                chance = 45
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 30 },
                    { name = "pistol_ammo",   min = 5, max = 10, chance = 45 },
                    { name = "cigarettepack", min = 1, max = 3,  chance = 60 }
                }
            }
        }
    },
    [`p_dresser02x`] = {
        label = "Dresser",
        rewards = {
            money = {
                enabled = true,
                min = 2.0,
                max = 12.0,
                chance = 45
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 30 },
                    { name = "pistol_ammo",   min = 5, max = 10, chance = 45 },
                    { name = "cigarettepack", min = 1, max = 3,  chance = 60 }
                }
            }
        }
    },
    [`p_dresser03x`] = {
        label = "Dresser",
        rewards = {
            money = {
                enabled = true,
                min = 2.0,
                max = 12.0,
                chance = 45
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 30 },
                    { name = "pistol_ammo",   min = 5, max = 10, chance = 45 },
                    { name = "cigarettepack", min = 1, max = 3,  chance = 60 }
                }
            }
        }
    },
    [`p_trunk01x`] = {
        label = "Trunk",
        rewards = {
            money = {
                enabled = true,
                min = 3.0,
                max = 20.0,
                chance = 50
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 35 },
                    { name = "pistol_ammo",   min = 5, max = 15, chance = 55 },
                    { name = "medicine_good", min = 1, max = 1,  chance = 30 }
                }
            }
        }
    },
    [`p_trunk02x`] = {
        label = "Trunk",
        rewards = {
            money = {
                enabled = true,
                min = 3.0,
                max = 20.0,
                chance = 50
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 35 },
                    { name = "pistol_ammo",   min = 5, max = 15, chance = 55 },
                    { name = "medicine_good", min = 1, max = 1,  chance = 30 }
                }
            }
        }
    },
    [`p_wardrobe01x`] = {
        label = "Wardrobe",
        rewards = {
            money = {
                enabled = true,
                min = 2.0,
                max = 15.0,
                chance = 45
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 25 },
                    { name = "pistol_ammo",   min = 3, max = 12, chance = 45 },
                    { name = "cigarettepack", min = 1, max = 4,  chance = 65 }
                }
            }
        }
    },
    [`s_footlocker06x`] = {
        label = "Looker",
        rewards = {
            money = {
                enabled = true,
                min = 2.0,
                max = 15.0,
                chance = 45
            },
            items = {
                enabled = true,
                list = {
                    { name = "goldwatch",     min = 1, max = 1,  chance = 25 },
                    { name = "pistol_ammo",   min = 3, max = 12, chance = 45 },
                    { name = "cigarettepack", min = 1, max = 4,  chance = 65 }
                }
            }
        }
    }



}

Config.Peds = {
    blacklist = {
        [`A_M_M_SDUpperClass_01`] = true,
        [`A_F_M_ARMTOWNFOLK_01`] = true
    },
    rewards = {
        money = {
            enabled = true,
            min = 0.25,
            max = 3.0,
            chance = 40
        },
        items = {
            enabled = true,
            list = {
                { name = "medicine_poor", min = 1, max = 1, chance = 20 },
                { name = "cigarettepack", min = 1, max = 2, chance = 35 },
                { name = "whiskey",       min = 1, max = 1, chance = 15 },
                { name = "bread",         min = 1, max = 1, chance = 25 },
                { name = "pistol_ammo",   min = 2, max = 5, chance = 10 }
            }
        }
    }
}

Config.Animals = {
    [`a_c_hawk_01`] = {
        label = "Bear",
        rewards = {
            items = {
                enabled = true,
                list = {
                    { name = "hawkf",                        min = 3, max = 6 },
                    { name = "provision_trinket_hawk_talon", min = 1, max = 1 },
                }
            }
        }
    },
}

Config.Notifications = {
    Empty = {
        enabled = true,
        messages = {
            { title = "Empty",        message = "Nothing useful found",              type = "ERROR" },
            { title = "No Loot",      message = "This container is empty",           type = "ERROR" },
            { title = "Nothing Here", message = "You didn't find anything of value", type = "ERROR" }
        }
    },
    Cooldown = {
        enabled = true,
        messages = {
            { title = "Already Searched", message = "This has been searched recently",      type = "ERROR" },
            { title = "Nothing Left",     message = "There's nothing more to find here",    type = "ERROR" },
            { title = "Empty Container",  message = "Someone has already taken everything", type = "ERROR" }
        }
    }
}
