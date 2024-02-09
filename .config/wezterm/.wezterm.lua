-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changig the color scheme:
config.color_scheme = 'catppuccin-frappe'
config.default_domain = "WSL:Ubuntu"
config.font = wezterm.font("Monaspace Argon")
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}
config.window_decorations = "RESIZE"
config.use_dead_keys = false
config.scrollback_lines = 5000
config.font_size = 13
config.line_height = 1.2
window_frame = {
 font = wezterm.font { family = 'Monaspace Argon', weight = 'Regular' },
}
config.hide_tab_bar_if_only_one_tab = true
config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
  { key = "h", mods = "CTRL|SHIFT",       action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|SHIFT",       action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL|SHIFT",       action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL|SHIFT",       action = act.ActivatePaneDirection("Down") },
  { key = "c", mods = "LEADER",     action = act.SpawnTab("CurrentPaneDomain") },
  { key = "f", mods = "LEADER",     action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "LEADER",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "x", mods = "LEADER",     action = act.CloseCurrentPane({ confirm = false }) },
  { key = "w", mods = "LEADER",     action = act.CloseCurrentTab({ confirm = false }) },
  { key = "[", mods = "LEADER",     action = act.ActivateCopyMode },
  { key = "r", mods = "LEADER",     action = act.ReloadConfiguration },
  { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("PrimarySelection")},
  {
    key = "k",
    mods = "CTRL|ALT",
    action = act.Multiple({
      act.ClearScrollback("ScrollbackAndViewport"),
      act.SendKey({ key = "L", mods = "CTRL" }),
    }),
  },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

-- and finally, return the configuration to wezterm
return config