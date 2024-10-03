local M = {}

local set_hl = vim.api.nvim_set_hl

---@function Function to convert RGB to hexadecimal
---@param rgb table The RGB color
---@return string hex The hexadecimal color
local function rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

---@function Function to get the foreground color of a highlight group
---@param hlgroup string The name of the highlight group
---@return string|nil hex The foreground color of the highlight group
local function get_fg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local fg = hl.fg
  if fg then
    return rgb_to_hex({
      bit.rshift(bit.band(fg, 0xFF0000), 16),
      bit.rshift(bit.band(fg, 0x00FF00), 8),
      bit.band(fg, 0x0000FF),
    })
  end
  return nil
end

---@function Function to get the background color of a highlight group
---@param hlgroup string The name of the highlight group
---@return string|nil hex The background color of the highlight group
local function get_bg_color(hlgroup)
  local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
  local bg = hl.bg
  if bg then
    return rgb_to_hex({
      bit.rshift(bit.band(bg, 0xFF0000), 16),
      bit.rshift(bit.band(bg, 0x00FF00), 8),
      bit.band(bg, 0x0000FF),
    })
  end
  return nil
end

local function setup_avante_highlights()
  -- Disable inline hint in visual mode / but also in other places...
  -- set_hl(0, "AvanteInlineHint", {
  --   bg = get_bg_color("Normal"),
  --   fg = get_bg_color("Normal"),
  -- })

  -- Hightlights for the main title
  set_hl(0, "AvanteTitle", { link = "Normal" })
  set_hl(0, "AvanteReversedTitle", {
    bg = get_bg_color("Normal"),
    fg = get_bg_color("Normal"),
  })

  -- Apply highlights for prompt
  set_hl(0, "AvanteThirdTitle", { link = "Normal" })
  set_hl(0, "AvanteReversedThirdTitle", {
    bg = get_bg_color("Normal"),
    fg = get_bg_color("Normal"),
  })
end

setup_avante_highlights()
