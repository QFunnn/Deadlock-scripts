local arch_mother
local hidden_king

do
    local tab = Menu.Create("Miscellaneous", "", "Player Notes"):Create("Main")
    tab:Parent():Icon("\u{e4d8}")

    local global_group = tab:Create("Player Notes", Enum.GroupSide.FullWidth)

    arch_mother = tab:Create("Arch Mother", Enum.GroupSide.Left)
    hidden_king = tab:Create("Hidden King", Enum.GroupSide.Right)


    global_group:Switch("Enabled", false, "\u{f00c}"):SetCallback(function(switch)
        local value = not switch:Get()

        arch_mother:Disabled(value)
        hidden_king:Disabled(value)
    end, true)
end


-- Action logic
local like_player
local dislike_player
local clear_player


local ACTIONS = {
    { "like",    "panorama/images/post_game/attributes/icon_heart.vsvg_c", false },
    { "dislike", "panorama/images/icons/report.vsvg_c",                    false },
}

--#region Types

---@class Player
---@field index integer
---@field name string
---@field steam_id string
---@field hero_image string


---@class GameTeams
---@field ARCH_MOTHER CMenuGroup
---@field HIDDEN_KING CMenuGroup

---@type GameTeams
GameTeams = {
    ARCH_MOTHER = arch_mother,
    HIDDEN_KING = hidden_king
}

---@alias NameColor "red" | "green" | "white"
NameColor = {
    RED = "red",
    GREEN = "green",
    NONE = "white"
}


--#endregion Types

--#region Utility functions
--- Get TopBarPlayer uipanel from TAB panorama
---@param player_index integer Player index in TAB, starts from 1
---@return uipanel | nil
local get_bar_by_index = function(player_index)
    return panorama.get_panel_by_id("TopBarPlayer" .. player_index)
end

--- Get player name from TAB menu
---@param player_index integer Player index in TAB, starts from 1
---@return uipanel | nil
local get_name_by_index = function(player_index)
    local panel = get_bar_by_index(player_index)
    if panel == nil then
        return nil
    end

    -- Exists only 1 element with PlayerName class:
    -- https://i.imgur.com/c7lYhrT.png
    return panel:find_children_with_class_traverse("PlayerName")[1]
end

--- Set player name color in TAB menu
---@param player_index integer Player index in TAB, starts from 1
---@param style NameColor Name color
---@return nil
local set_name_color = function(player_index, style)
    local name = get_name_by_index(player_index)
    if name == nil then
        return
    end

    name:set_style("color: " .. style .. ";")
end

local get_index_by_hero_name = function(hero_name)
    hero_name = hero_name:gsub("^hero_", "")

    for i = 0, 12, 1 do
        local panel = panorama.get_panel_by_id("TopBarPlayer" .. i)
        if panel == nil then
            goto continue
        end
        local hero_icon = panel:find_children_with_id_traverse("HeroImage")[1]:get_image_src()

        if hero_icon:find(hero_name, 1, true) then
            return i
        end

        ::continue::
    end
end

--#endregion Utility functions


--todo: to config and cloud sync
like_player = function(player_index)
    set_name_color(player_index, NameColor.GREEN)
end

dislike_player = function(player_index)
    set_name_color(player_index, NameColor.RED)
end

clear_player = function(player_index)
    set_name_color(player_index, NameColor.NONE)
end



local actions = {
    like = like_player,
    dislike = dislike_player
}
local colors = {
    like = "\a30FF30",
    dislike = "\aFF3030"
}

--- Add player to team in menu
---@param player Player Player entry
---@param team CMenuGroup Team in menu to add player
---@return nil
local add_player_to_team = function(player, team)
    local player_label = team:MultiSelect(player.steam_id, ACTIONS, true)
    player_label:DragAllowed(false)
    player_label:OneItemSelection(true)
    player_label:Image(player.hero_image)

    -- ForceLocalization don`t change widget path. I delegated like/dislike state holding to cheat
    player_label:ForceLocalization(player.name)

    -- todo: refactor
    player_label:SetCallback(function(select)
        local state = select:ListEnabled()[1]


        local action = actions[state]

        if action then
            action(player.index)
        else
            clear_player(player.index)
        end

        select:ForceLocalization((colors[state] or "") .. player.name)
    end, true)
end

-- todo: bullshit
local HERO_META = {
    hero_atlas = { name = "Abrams", icon = "panorama/images/heroes/bull_sm_psd.vtex_c" },
    hero_bull = { name = "Abrams", icon = "panorama/images/heroes/bull_sm_psd.vtex_c" },
    hero_bebop = { name = "Bebop", icon = "panorama/images/heroes/bebop_sm_psd.vtex_c" },
    hero_punkgoat = { name = "Billy", icon = "panorama/images/heroes/punkgoat_sm_psd.vtex_c" },
    hero_nano = { name = "Calico", icon = "panorama/images/heroes/nano_sm_psd.vtex_c" },
    hero_doorman = { name = "Doorman", icon = "panorama/images/heroes/doorman_sm_psd.vtex_c" },
    hero_doorman_alt = { name = "Doorman", icon = "panorama/images/heroes/doorman_sm_psd.vtex_c" },
    hero_drifter = { name = "Drifter", icon = "panorama/images/heroes/drifter_sm_psd.vtex_c" },
    hero_dynamo = { name = "Dynamo", icon = "panorama/images/heroes/sumo_psd.vtex_c" },
    hero_ghost = { name = "Lady Geist", icon = "panorama/images/heroes/spectre_sm_psd.vtex_c" },
    hero_orion = { name = "Grey Talon", icon = "panorama/images/heroes/archer_sm_psd.vtex_c" },
    hero_haze = { name = "Haze", icon = "panorama/images/heroes/haze_sm_psd.vtex_c" },
    hero_astro = { name = "Holiday", icon = "panorama/images/heroes/holiday_sm_psd.vtex_c" },
    hero_inferno = { name = "Infernus", icon = "panorama/images/heroes/inferno_sm_psd.vtex_c" },
    hero_tengu = { name = "Ivy", icon = "panorama/images/heroes/tengu_sm_psd.vtex_c" },
    hero_ivy = { name = "Ivy", icon = "panorama/images/heroes/tengu_sm_psd.vtex_c" },
    hero_kelvin = { name = "Kelvin", icon = "panorama/images/heroes/kelvin_sm_psd.vtex_c" },
    hero_lash = { name = "Lash", icon = "panorama/images/heroes/lash_sm_psd.vtex_c" },
    hero_mirage = { name = "Mirage", icon = "panorama/images/heroes/mirage_sm_psd.vtex_c" },
    hero_krill = { name = "Mo & Krill", icon = "panorama/images/heroes/digger_sm_psd.vtex_c" },
    hero_bookworm = { name = "Paige", icon = "panorama/images/heroes/bookworm_psd.vtex_c" },
    hero_chrono = { name = "Paradox", icon = "panorama/images/heroes/paradox_sm_psd.vtex_c" },
    hero_synth = { name = "Pocket", icon = "panorama/images/heroes/synth_psd.vtex_c" },
    hero_familiar = { name = "Rem", icon = "panorama/images/heroes/familiar_sm_psd.vtex_c" },
    hero_gigawatt = { name = "Seven", icon = "panorama/images/heroes/gigawatt_sm_psd.vtex_c" },
    hero_shiv = { name = "Shiv", icon = "panorama/images/heroes/shiv_sm_psd.vtex_c" },
    hero_magician = { name = "Sinclair", icon = "panorama/images/heroes/magician_sm_psd.vtex_c" },
    hero_hornet = { name = "Vindicta", icon = "panorama/images/heroes/vindicta_sm_psd.vtex_c" },
    hero_viscous = { name = "Viscous", icon = "panorama/images/heroes/viscous_sm_psd.vtex_c" },
    hero_frank = { name = "Victor", icon = "panorama/images/heroes/frank_sm_psd.vtex_c" },
    hero_viper = { name = "Vyper", icon = "panorama/images/heroes/kali_sm_psd.vtex_c" },
    hero_warden = { name = "Warden", icon = "panorama/images/heroes/warden_sm_psd.vtex_c" },
    hero_wraith = { name = "Wraith", icon = "panorama/images/heroes/wraith_sm_psd.vtex_c" },
    hero_yamato = { name = "Yamato", icon = "panorama/images/heroes/yamato_sm_psd.vtex_c" },
}
local get_hero_image = function(hero)
    return HERO_META[hero].icon
end


local teamMap = {
    [2] = GameTeams.HIDDEN_KING,
    [3] = GameTeams.ARCH_MOTHER,
}
callback.on_scripts_loaded:set(function()
    for _, player in ipairs(entity_list.by_class_name("C_CitadelPlayerPawn")) do
        local controller = player:get_player_controller()

        local hero_name = player:get_name()
        if hero_name == "hero_targetdummy" then
            goto continue
        end

        local index = get_index_by_hero_name(hero_name)
        local name = get_name_by_index(index):get_text()

        local steam_id = controller.m_steamID
        local team = teamMap[player.m_iTeamNum]

        ---@type Player
        local entry = {
            index = index,
            name = name,
            steam_id = tostring(steam_id),
            hero_image = get_hero_image(hero_name)
        }

        add_player_to_team(entry, team)
        ::continue::
    end
end)
