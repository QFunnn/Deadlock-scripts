--[[
     ~ wod shop abuse • World Of Dota abuse
     ~ t.me/windguild ~ via jon.kaus, rou, qfun
]]

local wod = {}
local JSON = require("assets.JSON")

local a = function(...)
	return ...
end

local shop_data = {
	{
		label = "Sets",
		items = {
			{ "New Player Bundle", 99991 },
			{ "Double Rating x10", "double_rating_pack" },
			{ "Dark Carnaval Bundle", 1091 },
		},
	},
	{
		label = "Pets",
		items = {
			{ "Fearless Badge", 1 },
			{ "Morok`s", 2 },
			{ "Skip the Delivery Frog", 3 },
			{ "Speed Demon", 4 },
			{ "Mighty Boar", 5 },
			{ "Stumpy", 7 },
			{ "Tickled Tegu", 8 },
			{ "Trusty Mountain Yak", 9 },
			{ "Alphid of Lecaciida", 10 },
			{ "Arnabus the Fairy Rabbit", 11 },
			{ "Axolotl", 12 },
			{ "Breaver Knight", 13 },
			{ "Butch", 14 },
			{ "Captain Bamboo", 15 },
			{ "Coco The Courageous", 16 },
			{ "Coral the Furryfish", 17 },
			{ "Spooly", 18 },
			{ "Duskie", 20 },
			{ "El Gato", 22 },
			{ "Serac the Seal", 23 },
			{ "Inky the Haxapus", 24 },
			{ "Porcine Princess Penelope", 26 },
			{ "Ol' Joe", 28 },
			{ "Itsy", 29 },
			{ "Yonex`s Rage", 30 },
			{ "White Fox Spirits", 31 },
			{ "Black Fox Spirits", 32 },
			{ "Hexgill the Lane Shark", 33 },
			{ "Jumo", 34 },
			{ "Kupu the Metamorpher", 35 },
			{ "The Llama Llama", 37 },
			{ "Eager Drocsnozzle", 38 },
			{ "Mango the Newt", 40 },
			{ "Mei Nei the Jade Rabbit", 41 },
			{ "Cluckless the Brave", 42 },
			{ "Mok", 43 },
			{ "Hyeonmu", 44 },
			{ "Wynchell the Wyrmeleon", 45 },
			{ "Scuttling Scotty", 48 },
			{ "Shroomy", 49 },
			{ "Amaterasu", 50 },
			{ "Boooofus", 51 },
			{ "Lord of Tempests", 52 },
			{ "Shagbark", 54 },
			{ "Hakobi and Tenneko", 55 },
			{ "Butter Blunder", 56 },
			{ "Redpaw", 57 },
			{ "Snelfret the Snail", 58 },
			{ "Snapjaw", 59 },
			{ "Snowl", 60 },
			{ "Tinkbot", 62 },
			{ "Tory the Sky Guardian", 63 },
			{ "Dire Construct", 64 },
			{ "Radiant Construct", 65 },
			{ "Wibbley", 68 },
			{ "Waldi the Faithful", 69 },
			{ "Woodchopper", 70 },
			{ "Travelling Automaton", 71 },
			{ "White the Blueheart", 72 },
			{ "Krane the Enlightened", 73 },
			{ "Fraidy Jack", 74 },
			{ "Nilbog the Mad", 75 },
			{ "Trod & Cheddar", 76 },
			{ "Zombie Hopper", 77 },
			{ "Huntling", 78 },
			{ "Seekling", 79 },
			{ "Venoling", 80 },
			{ "Devourling", 81 },
			{ "Krobeling", 82 },
			{ "Doomling", 83 },
			{ "Blazing Hatchling", 85 },
			{ "Faceless Rex", 86 },
			{ "Lil' Nova", 87 },
			{ "Pouches Gem of True Sight", 88 },
			{ "Pouches Ultimate Orb", 89 },
			{ "Pouches Linken`s Sphere", 90 },
			{ "Pouches Refresher Orb", 91 },
			{ "Pouches Octarine", 92 },
			{ "Lefty Gem of Truesight", 93 },
			{ "Lefty Ultimate Orb", 94 },
			{ "Lefty Linken`s Sphere", 95 },
			{ "Lefty Refresher Orb", 96 },
			{ "Lefty Octarine Core", 97 },
			{ "Brightskye Gem", 98 },
			{ "Brightskye Ultimate Orb", 99 },
			{ "Brightskye Soul Booster", 100 },
			{ "Brightskye Refresher Orb", 101 },
			{ "Brightskye Octarine Core", 102 },
			{ "Baby Roshan", 103 },
			{ "Platinum Baby Roshan", 104 },
			{ "Desert Sands Baby Roshan", 105 },
			{ "Jade Baby Roshan", 106 },
			{ "Lave Boby Roshan", 107 },
			{ "Ice Baby Roshan", 108 },
			{ "Honey Heist Baby Roshan", 109 },
			{ "Gingerbread Baby Roshan", 112 },
			{ "Golden Huntling", 113 },
			{ "Golden Seekling", 114 },
			{ "Golden Venoling", 115 },
			{ "Golden Devourling", 116 },
			{ "Golden Krobeling", 117 },
			{ "Golden Doomling", 118 },
			{ "Golden Greevil", 119 },
			{ "Golden Pouches", 120 },
			{ "Golden Lefty", 121 },
			{ "Golden Brightskye", 122 },
			{ "Golden Baby Roshan", 123 },
			{ "Radiant Courier", 701 },
			{ "Dire Courier", 702 },
			{ "Flopjaw the Boxhound", 938 },
			{ "Patch, Stash, and Hobb", 939 },
			{ "Dark Demon", 940 },
		},
	},
	{
		label = "Effects",
		items = {
			{ "Halloween Yellow", 124 },
			{ "Hallowen Green", 125 },
			{ "Hallowen Orange", 126 },
			{ "Hallowen Violet", 127 },
			{ "Timeless Aghanim", 128 },
			{ "Lava Sphere", 129 },
			{ "Eternal Nature", 130 },
			{ "Black Gold", 131 },
			{ "Full Moon Lotus", 132 },
			{ "Green Crystals", 133 },
			{ "Ocean Blue", 134 },
			{ "Golden Heal", 175 },
			{ "Red Ribbon", 176 },
			{ "Water Style", 177 },
			{ "Red Crystals", 178 },
			{ "Green Mark", 179 },
			{ "Universe", 180 },
			{ "Purple Love", 181 },
			{ "Blue Wizard", 182 },
			{ "Desert Storm", 183 },
			{ "Aura of the Dead", 184 },
			{ "Orbit", 185 },
			{ "Blood Flame", 186 },
			{ "Wings of Light", 187 },
			{ "Classic Music", 188 },
			{ "Neon Music", 189 },
			{ "Ice Mist", 190 },
			{ "Butterfly Effect", 191 },
			{ "Flame", 192 },
			{ "Angel Slayer", 193 },
			{ "Shine Maker", 194 },
			{ "Natural Grass", 195 },
			{ "Ghost", 196 },
			{ "Parasites", 197 },
			{ "Purple Glow", 198 },
			{ "Green Glow", 199 },
			{ "Clown Hat", 200 },
			{ "Sailor Moon", 201 },
			{ "Ping Spark", 203 },
			{ "Arcana Ghost", 204 },
			{ "New Year Hat", 205 },
			{ "Ghost Wings", 206 },
			{ "Shields", 207 },
			{ "Mark of Darkness", 208 },
			{ "Mark of Light", 209 },
			{ "Gold Pig", 433 },
			{ "Ice Frog", 434 },
			{ "Baby Roshan Stone", 700 },
			{ "Swords", 705 },
			{ "Ringmaster", 706 },
			{ "Blue Champion", 722 },
			{ "Red Champion", 723 },
			{ "Pumpkin Head", 724 },
			{ "Tiny Head", 725 },
			{ "Spark Glow", 728 },
			{ "Little Gold", 841 },
			{ "Toxic Weapon", 847 },
			{ "Powerful Weapon", 851 },
			{ "Overpower Master", 858 },
			{ "Gold Seal", 860 },
			{ "Golden Thoughts Head", 866 },
			{ "Guardian Angel", 867 },
			{ "Pink Weapon", 919 },
			{ "Wizard Weapon", 920 },
			{ "Yellow Weapon", 921 },
			{ "Green Champion", 922 },
			{ "Purple Champion", 923 },
			{ "Blue Hat", 926 },
			{ "Fire Bat Wings", 928 },
			{ "Blue Bat Wings", 929 },
			{ "Spectre Glow", 930 },
			{ "Ghost Glow", 931 },
			{ "Old Jungle Io", 932 },
			{ "Wraith Gate", 933 },
			{ "Morphling Splash", 934 },
			{ "Portal Pink Head", 936 },
			{ "Infinity Space Head", 937 },
			{ "Radiance Burst", 990 },
			{ "Aghanim 2025", 991 },
			{ "White Circle", 1076 },
			{ "Red Circle", 1077 },
			{ "Orange Circle", 1078 },
			{ "Lime Circle", 1079 },
			{ "Green Circle", 1080 },
			{ "Sky Circle", 1081 },
			{ "Blue Circle", 1082 },
			{ "Purple Circle", 1083 },
		},
	},
	{
		label = "TIPS",
		items = {
			{ "Creep, Creep!", 435 },
			{ "Well done!", 942 },
			{ "What did you do?", 437 },
			{ "Seeeeeeeeeeeeeb!", 438 },
			{ "Clown!", 439 },
			{ "Ingeniously!", 440 },
			{ "Are you in a clan?", 941 },
			{ "42 42 42 42 42", 942 },
			{ "Stop time?", 943 },
			{ "Final stop", 944 },
			{ "Tip me, tip me!", 441 },
			{ "Are you okay?", 442 },
			{ "I condemn!", 443 },
			{ "Oops, that`s for the wards!", 444 },
			{ "Daubi, daubi!", 445 },
			{ "Ahahahaha!", 446 },
			{ "Hey bandit!", 447 },
			{ "Bon apetit!", 448 },
			{ "Subscribe!", 449 },
			{ "Panda Live?", 450 },
			{ "I`m a talent!", 451 },
			{ "1000-7", 452 },
			{ "Chponk!", 453 },
			{ "Where is help?", 454 },
			{ "Oyoyoy!", 455 },
			{ "Catch the first aid kit!", 456 },
			{ "You stink of weakness!", 457 },
			{ "It`s GG", 458 },
			{ "And how to tip?!", 459 },
			{ "For the Alliance!", 460 },
			{ "For the Horde!", 461 },
			{ "Bear? Bear!", 462 },
			{ "Will you cry?", 475 },
			{ "Not by chance, friend", 476 },
			{ "What`s the hate?!", 477 },
			{ "Fix please", 478 },
			{ "Oh, lucky, lucky", 479 },
			{ "Uncle, are you okay?", 480 },
			{ "Bruh!", 481 },
			{ "Well guys, I`m leaving", 482 },
			{ "Easier for Radiacne.", 463 },
			{ "Rest!", 464 },
			{ "Oh, what`s wrong?", 465 },
			{ "He`s a genius", 466 },
			{ "Farmed?", 467 },
			{ "Regular Top-8", 468 },
			{ "Is this even legal?", 469 },
			{ "Again -40", 470 },
			{ "Hush brother, hush", 471 },
			{ "GG, tima rakov", 472 },
			{ "Fresh meat", 473 },
			{ "I love me", 474 },
			{ "Chipi Chipi", 405 },
			{ "Chapa Chapa", 406 },
			{ "Dubi Dubi", 407 },
			{ "Daba Daba", 408 },
			{ "Mediocrity", 409 },
			{ "Disgrace yourself", 410 },
			{ "Out of balance", 411 },
			{ "Another TIP", 412 },
			{ "NYAH!", 413 },
			{ "Wrong, but where?", 414 },
			{ "Not your level!", 415 },
			{ "Well played!", 416 },
			{ "Is this a hateshow?", 417 },
			{ "TORA! TORA! TORA!", 418 },
			{ "Did i hear a squeak?", 419 },
			{ "Did you run around?", 420 },
			{ "This is way...", 421 },
			{ "No need uncle", 422 },
			{ "Catching flashbacks", 423 },
			{ "Adyos Pajasos", 424 },
			{ "Did you get it?", 425 },
			{ "(x_x)", 426 },
			{ "Actors in the lobby!", 427 },
			{ "322 is 322!", 428 },
			{ "Bad luck...", 429 },
			{ "Cheeeeampics!", 430 },
			{ "Yameta Kudasai!", 431 },
			{ "Three spaces, go", 432 },
			{ "Old god", 703 },
			{ "A swarm of fleas!", 704 },
			{ "CHMA!", 717 },
			{ "Good!", 718 },
			{ "Strenght!", 719 },
			{ "Weakness!", 720 },
			{ "1st", 721 },
			{ "What`s the point?", 884 },
			{ "I`m not losing", 885 },
			{ "The bottom is torn...", 886 },
			{ "Golden pig!", 886 },
		},
	},
	{

		label = "High Five",
		items = {
			{ "Zombie", 707 },
			{ "Aghanim", 708 },
			{ "Lava", 709 },
			{ "Cookie", 710 },
			{ "Dota Mug", 711 },
			{ "Indie", 712 },
			{ "Fire", 713 },
			{ "Neon", 714 },
			{ "Love Paw", 715 },
			{ "Hand of Midas", 716 },
			{ "Dark Carnaval", 1085 },
		},
	},
	{
		label = "Teleports",
		items = {
			{ "Frosty Freshness", 995 },
			{ "Sands of Eternity", 996 },
			{ "Prism", 997 },
			{ "Quantum Beam", 998 },
			{ "Heart of Nature", 1001 },
			{ "Techno Rift", 1002 },
			{ "Crimson Frontier", 1003 },
			{ "Obsidian Vortex", 1004 },
		},
	},
}

local cfg = {
	action_interval = 2.5,

	category_names = {
		"1. Sets",
		"2. Pets",
		"3. Effects",
		"4. TIPS",
		"5. High Five",
		"6. Teleports",
	},

	visual = {
		text = Color(255, 255, 255, 255),
		shadow = Color(0, 0, 0, 180),
		good = Color(120, 235, 150, 255),
		hack = Color(210, 120, 255, 255),
	},
}

local ui, state, render_ctx

do
	local giver = Menu.Create("Scripts", "WOD Abuse", "Shop Giver")
	giver:Icon("\u{f0e7}")

	local page = giver:Create("Main")
	local items_giver = page:Create("Items", 1)
	local op_buttons = page:Create("OP")

	ui = {
		category = items_giver:Combo("Category", cfg.category_names, 0),
		search_item = items_giver:Input("Search shop item", ""),
		items_combo = items_giver:Combo("Items", {}),
		give_item = items_giver:Button("Give", function()
			local item = state.filtered_items[ui.items_combo:Get() + 1]

			if item then
				wod.give_item(item)
			end
		end),

		give_selected_category = op_buttons:Button("Give selected category", function()
			local category = shop_data[ui.category:Get() + 1]
			wod.give_category_items(category)
		end),
		give_all_items = op_buttons:Button("Give all items", function(this)
			wod.give_all_items()
		end),

		update_shop = a(function()
			local category = shop_data[ui.category:Get() + 1]

			state.filtered_items = {}
			local names = {}

			for i, item in ipairs(category.items) do
				state.filtered_items[i] = item
				names[i] = item[1]
			end

			ui.items_combo:Update(names, 0)
		end),
	}

	ui.category:SetCallback(function()
		if ui.search_item:Get() == "" then
			ui.update_shop()
		end
	end)

	ui.search_item:SetCallback(function(self)
		local query = self:Get():lower()

		if query == "" then
			ui.update_shop()
			return
		end

		local category = shop_data[ui.category:Get() + 1]

		state.filtered_items = {}

		local names = {}

		for _, item in ipairs(category.items) do
			if item[1]:lower():find(query, 1, true) then
				state.filtered_items[#state.filtered_items + 1] = item
				names[#names + 1] = item[1]
			end
		end

		ui.items_combo:Update(names, 0)
	end)

	render_ctx = {
		font = Render.LoadFont("Arial", Enum.FontCreate.FONTFLAG_ANTIALIAS, 16),
	}

	state = {
		game_id = nil,
		pending = {},
		filtered_items = {},
		last_action = 0,
		status = "idle",
	}

	ui.update_shop()
end

local helpers, valve
do
	helpers = {
		log = a(function(...)
			local out = {}
			for i = 1, select("#", ...) do
				out[#out + 1] = tostring(select(i, ...))
			end
			Log.Write("[ WOD ] " .. table.concat(out, " "))
		end),

		in_game = a(function()
			return (state.game_id ~= nil) and Engine.IsInGame()
		end),

		send = a(function(event, fields)
			local body = table.concat(fields, ", ")

			Engine.RunScript(string.format('GameEvents.SendCustomGameEventToServer("%s", { %s });', event, body))
		end),

		give_item = a(function(item_id)
			helpers.send("donate_shop_buy_item", {
				string.format(
					'currency: "%s"',
					valve.decode_base64(
						"0JAg0YLRiyDRh9C1INGB0YvQvSDRiNC70Y7RhdC4INC90LDRhdGD0Y8g0YHRjtC00LAg0L/QvtC70LXQtz8="
					)
				),
				string.format('item_id: "%s"', item_id),
				string.format("n: %i", state.game_id),
				string.format('price: "%s"', 0),
			})
		end),

		--@note table { [1] = name, [2] = code }
		request = a(function(item)
			if not item or (item[1] == "" or item[2] == "") then
				return
			end
			state.pending[#state.pending + 1] = {
				name = item[1],
				code = item[2],
			}
		end),
	}
	valve = {
		-- https://devforum.roblox.com/t/base64-encoding-and-decoding-in-lua/1719860 Ачё
		decode_base64 = function(data)
			local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
			data = data:gsub("[^" .. b .. "=]", "")
			return (
				data:gsub(".", function(x)
					if x == "=" then
						return ""
					end
					local r, f = "", b:find(x) - 1
					for i = 6, 1, -1 do
						r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
					end
					return r
				end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
					if #x ~= 8 then
						return ""
					end
					local c = 0
					for i = 1, 8 do
						c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
					end
					return string.char(c)
				end)
			)
		end,
		-- Индус забрал фейма и я не справился с этим car maboy?
		decode_valuekey = function(binary)
			local pos = 1
			local len = #binary

			local function byte()
				local b = binary:byte(pos)
				pos = pos + 1
				return b
			end
			local function cstr()
				local s = pos
				while pos <= len and binary:byte(pos) ~= 0 do
					pos = pos + 1
				end
				local str = binary:sub(s, pos - 1)
				pos = pos + 1
				return str
			end
			local function int32()
				local b1, b2, b3, b4 = binary:byte(pos, pos + 3)
				pos = pos + 4
				return b1 + b2 * 256 + b3 * 65536 + b4 * 16777216
			end

			if binary:sub(1, 4) == "VBKV" then
				pos = 11
			end

			local result = {}
			while pos <= len do
				local t = byte()
				if t == 0x0B or t == 0x08 or t == nil then
					break
				end
				local key = cstr()
				if t == 0x01 then
					result[key] = cstr()
				elseif t == 0x02 then
					result[key] = int32()
				elseif t == 0x00 then
					result[key] = "<nested>"
				else
					result[key] = string.format("<type 0x%02X>", t)
					break
				end
			end
			return result
		end,
	}
end

wod.give_item = a(function(item)
	if not item or item[1] == "" or not helpers.in_game() then
		return
	end

	helpers.request(item)
	helpers.log("queued:", item[2])
end)

wod.give_category_items = a(function(category)
	if not helpers.in_game() then
		return
	end

	for _, item in ipairs(category.items) do
		helpers.request(item)
	end

	helpers.log("queued items from category", category.label)
end)

wod.give_all_items = a(function()
	if not helpers.in_game() then
		return
	end

	for _, category in ipairs(shop_data) do
		wod.give_category_items(category)
	end

	helpers.log("queued items from all categories")
end)

wod.clear_shop_queue = a(function()
	state.pending = {}
	state.status = "idle"

	helpers.log("shop give queue cleared")
end)

local core
do
	core = {
		process_shop = a(function()
			local i = 1
			while i <= #state.pending do
				local p = table.remove(state.pending, 1)
				if not p then
					return
				end

				helpers.give_item(p.code)
				helpers.log("sent", p.name)

				i = i + 1
			end
			if #state.pending > 0 then
				state.status = string.format("giving %s (x%d)", state.pending[1].name, #state.pending)
			end
		end),

		run = a(function()
			local now = GameRules.GetGameTime()
			if now - state.last_action < cfg.action_interval then
				return
			end
			state.last_action = now

			state.status = "idle"
			core.process_shop()
		end),
	}
end

local callbacks
do
	local event_mt = {
		__call = function(self, bool, fn)
			local action = bool and self.set or self.unset
			action(self, fn)
		end,
		set = function(self, fn)
			self[2] = fn
		end,
		unset = function(self, fn)
			if not fn or self[2] == fn then
				self[2] = nil
			end
		end,
		fire = function(self, ...)
			local fn = self[2]
			if fn then
				return fn(...)
			end
		end,
	}
	event_mt.__index = event_mt

	callbacks = setmetatable({}, {
		__index = function(self, key)
			self[key] = setmetatable({ key }, event_mt)
			return self[key]
		end,
	})
end

callbacks.draw:set(a(function()
	if not Engine.IsInGame() then
		return
	end

	local screen = Render.ScreenSize()
	local text = string.format("WOD: %s | pending: %i | game_id: %s ", state.status, #state.pending, state.game_id)
	local text_size = Render.TextSize(render_ctx.font, 16, text) / 2
	local pos = Vec2(screen.x * 0.5 - text_size.x, screen.y * 0.16 - text_size.y)

	Render.Text(render_ctx.font, 16, text, Vec2(pos.x + 1, pos.y + 1), cfg.visual.shadow)
	Render.Text(render_ctx.font, 16, text, pos, #state.pending > 0 and cfg.visual.hack or cfg.visual.good)
end))

callbacks.update:set(a(function()
	core.run()
end))

callbacks.game_end:set(a(function()
	state.game_id = nil
end))

function wod.OnUpdate()
	callbacks.update:fire()
end

function wod.OnDraw()
	callbacks.draw:fire()
end

function wod.OnGameEnd()
	callbacks.game_end:fire()
end

function wod.OnSendNetMessage(msg)
	local json = JSON:decode(protobuf.decodeToJSONfromObject(msg.msg_object))
	if json.data == nil or msg.message_id ~= 280 then
		return
	end
	local data = valve.decode_base64(json.data)
	local key_value = valve.decode_valuekey(data)
	if key_value.n == nil then
		return
	end

	state.game_id = key_value.n
end

return wod
