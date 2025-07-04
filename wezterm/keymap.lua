local wezterm = require 'wezterm'
local act = wezterm.action

local function is_macos()
  local handle = io.popen("uname")
  if handle == nil then
    return false
  end

  local os_name = handle:read("*a")
  handle:close()

  os_name = os_name:gsub("%s+", ""):lower() -- Remove whitespace and convert to lowercase for easier comparison
  return os_name == "darwin"
end


local keymap = {
  keys = {
    { key = 'n',  mods = 'ALT',        action = act.ActivateTabRelative(1) },
    { key = 'p',  mods = 'ALT',        action = act.ActivateTabRelative(-1) },
    { key = '-',  mods = 'ALT',        action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '\\', mods = 'ALT',        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '=',  mods = 'CTRL',       action = act.IncreaseFontSize },
    { key = '-',  mods = 'CTRL',       action = act.DecreaseFontSize },
    { key = '0',  mods = 'CTRL',       action = act.ResetFontSize },
    { key = '1',  mods = 'ALT',        action = act.ActivateTab(0) },
    { key = '2',  mods = 'ALT',        action = act.ActivateTab(1) },
    { key = '3',  mods = 'ALT',        action = act.ActivateTab(2) },
    { key = '4',  mods = 'ALT',        action = act.ActivateTab(3) },
    { key = '5',  mods = 'ALT',        action = act.ActivateTab(4) },
    { key = '6',  mods = 'ALT',        action = act.ActivateTab(5) },
    { key = '7',  mods = 'ALT',        action = act.ActivateTab(6) },
    { key = '8',  mods = 'ALT',        action = act.ActivateTab(7) },
    { key = '9',  mods = 'ALT',        action = act.ActivateTab(8) },
    { key = '0',  mods = 'ALT',        action = act.ActivateTab(9) },
    { key = 'f',  mods = 'ALT',        action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'F',  mods = 'ALT',        action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'P',  mods = 'ALT|SHIFT',  action = act.ActivateCommandPalette },
    { key = 'R',  mods = 'SHIFT|ALT',  action = act.ReloadConfiguration },
    { key = 'c',  mods = 'ALT',        action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'V',  mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = '[',  mods = 'ALT',        action = act.ActivateCopyMode },
    { key = 'c',  mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'h',  mods = 'ALT',        action = act.ActivatePaneDirection 'Left' },
    { key = 'H',  mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l',  mods = 'ALT',        action = act.ActivatePaneDirection 'Right' },
    { key = 'L',  mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k',  mods = 'ALT',        action = act.ActivatePaneDirection 'Up' },
    { key = 'K',  mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j',  mods = 'ALT',        action = act.ActivatePaneDirection 'Down' },
    { key = 'J',  mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { 'Down', 1 } },
    -- { key = 'K',          mods = 'CTRL',           action = act.ClearScrollback 'ScrollbackOnly' },
    -- { key = 'L',          mods = 'CTRL',           action = act.ShowDebugOverlay },
    -- { key = 'M',          mods = 'CTRL',           action = act.Hide },
    -- { key = 'C',  mods = 'SHIFT|ALT',  action = act.SpawnWindow },
    -- { key = 'W',          mods = 'CTRL',           action = act.CloseCurrentTab { confirm = true } },
    -- { key = 'U',          mods = 'SHIFT|CTRL',     action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
    -- { key = 'Z',          mods = 'CTRL',           action = act.TogglePaneZoomState },
    -- { key = 'phys:Space', mods = 'SHIFT|CTRL',     action = act.QuickSelect },
  },

  key_tables = {
    copy_mode = {
      { key = 'Enter',  mods = 'NONE',  action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } } },
      { key = 'Escape', mods = 'NONE',  action = act.CopyMode 'Close' },
      { key = '[',      mods = 'CTRL',  action = act.CopyMode 'Close' },
      { key = 'Space',  mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = '$',      mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '$',      mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = ',',      mods = 'NONE',  action = act.CopyMode 'JumpReverse' },
      { key = '0',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';',      mods = 'NONE',  action = act.CopyMode 'JumpAgain' },
      { key = 'F',      mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = false } } },
      { key = 'F',      mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
      { key = 'G',      mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G',      mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'L',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M',      mods = 'NONE',  action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M',      mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'O',      mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O',      mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'T',      mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = true } } },
      { key = 'T',      mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
      { key = 'V',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = 'V',      mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = '^',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^',      mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b',      mods = 'NONE',  action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b',      mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b',      mods = 'CTRL',  action = act.CopyMode 'PageUp' },
      { key = 'c',      mods = 'CTRL',  action = act.CopyMode 'Close' },
      { key = 'd',      mods = 'CTRL',  action = act.CopyMode { MoveByPage = (0.5) } },
      { key = 'e',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'f',      mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = false } } },
      { key = 'f',      mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
      { key = 'f',      mods = 'CTRL',  action = act.CopyMode 'PageDown' },
      { key = 'g',      mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'h',      mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
      { key = 'j',      mods = 'NONE',  action = act.CopyMode 'MoveDown' },
      { key = 'k',      mods = 'NONE',  action = act.CopyMode 'MoveUp' },
      { key = 'l',      mods = 'NONE',  action = act.CopyMode 'MoveRight' },
      { key = 'm',      mods = 'ALT',   action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o',      mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 't',      mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = true } } },
      { key = 'u',      mods = 'CTRL',  action = act.CopyMode { MoveByPage = (-0.5) } },
      { key = 'v',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = 'v',      mods = 'CTRL',  action = act.CopyMode { SetSelectionMode = 'Block' } },
      { key = 'w',      mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
      { key = 'y',      mods = 'NONE',  action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } } },
    },

    search_mode = {
      { key = 'Enter',     mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape',    mods = 'NONE', action = act.CopyMode 'Close' },
      { key = '[',         mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'c',         mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'n',         mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p',         mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r',         mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u',         mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp',    mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown',  mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },

  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
  }
}

if is_macos() then
  table.insert(keymap.keys, { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' })
  table.insert(keymap.keys, { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' })
  table.insert(keymap.keys, { key = '=', mods = 'SUPER', action = act.IncreaseFontSize })
  table.insert(keymap.keys, { key = '-', mods = 'SUPER', action = act.DecreaseFontSize })
  table.insert(keymap.keys, { key = '0', mods = 'SUPER', action = act.ResetFontSize })
end

return keymap
