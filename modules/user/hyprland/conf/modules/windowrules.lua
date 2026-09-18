------------Supress Maximize
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

----------Kitty
-- hl.window_rule({
-- 	match = { class = "kitty" },
-- 	opacity = 0.75,
-- })

----------File Picker
hl.window_rule({
	match = { title = "^(Open Folder)$" },
	float = true,
	size = "700 500",
})

----------Obsidian
-- hl.window_rule({
-- 	match = { class = "^(obsidian)$" },
-- 	opacity = 0.97,
-- })

----------Blueman
hl.window_rule({
	match = { class = "^(blueman-manager)$" },
	float = true,
	size = "500 700",
})

----------Zathura
-- hl.window_rule({
-- 	match = { class = "^(Zathura)$" },
-- 	opacity = 0.75,
-- })

----------Zotero
-- hl.window_rule({
-- 	match = { class = "^(Zotero)$" },
-- 	opacity = 0.85,
-- })

----------Emacs
-- hl.window_rule({
-- 	match = { class = "^(Emacs)$" },
-- 	opacity = 0.90,
-- })

----------Calculator
hl.window_rule({
	match = { title = "^(Calculator)$" },
	float = true,
})

----------File Manager
hl.window_rule({
	match = { class = "^(org.gnome.Nautilus)$" },
	float = true,
})

--------------- Layer Rules

----------Rofi
hl.layer_rule({
	match = { namespace = "rofi" },
	blur = true,
})

----------Swaync
hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	animation = "slide right",
})
