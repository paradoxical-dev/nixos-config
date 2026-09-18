-- INFO: conditional check for ambxst
local ambxstConfig = os.getenv("HOME") .. "/.local/share/ambxst/hyprland.lua"
local f = io.open(ambxstConfig, "r")
if f then
	f:close()
	loadfile(ambxstConfig)()
end

require("modules/keybinds")
require("modules/general")
require("modules/monitors")
require("modules/inputs")
require("modules/windowrules")
require("modules/env")
