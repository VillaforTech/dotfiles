local wezterm = require("wezterm")
local config = require("config")
require("events")

-- Apply color scheme without spawning a shell during config evaluation.
local themes = {
	nord = "Nord (Gogh)",
	onedark = "One Dark (Gogh)",
}
local selected_theme = os.getenv("WEZTERM_THEME") or "nord"
config.color_scheme = themes[selected_theme] or themes.nord

return config
