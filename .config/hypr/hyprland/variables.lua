-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 15,
		gaps_out = 15,

		border_size = 2,

		col = {
			active_border = {
				colors = {
					"#232634",
					"#949cbb",
				},
				angle = 45,
			},
			-- inactive_border = "rgba(595959aa)",
			inactive_border = "#232634",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 8,
		rounding_power = 3,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.85,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "#303446",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},

		glow = {
			enabled = false,
			range = 15,
			render_power = 4,
		},
	},

	animations = {
		enabled = true,
	},
})
