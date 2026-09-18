local mainMod = "SUPER"
local terminal = "kitty"
local browser = "brave"
local fileManager = "nautilus"

--------------- Shortcuts
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- killactive
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float()) -- togglefloating (action defaults to "toggle")
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

--------------- Launchers/Pickers
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/launchers/apps.rasi"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper.sh"))

--------------- Window Nav
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

--------------- Workspace Nav + Window To Workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

--------------- Special Workspace
hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:magic" }))

--------------- Window Move/Resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

--------------- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 10%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

--------------- Screenshot
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y-%m-%d-%H-%M-%S).png]]))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim ~/Pictures/screenshot-$(date +%Y-%m-%d-%H-%M-%S).png]]))

-- SCRIPTS
-- hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("~/dots/system/wm/hypr/conf/scripts/home_layout.sh"))
-- hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd("~/dots/system/wm/hypr/conf/scripts/alpaca-sidebar.sh"))
