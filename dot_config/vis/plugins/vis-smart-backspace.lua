-- Vis Smart Backspace Plugin
-- Rebinds the backspace so that it deletes multiple spaces when at
-- the start of the line, similar to VIm's softtabstop option.

require("vis")


local tabstop =
  1


vis:option_register
( "softtabstop"
, "number"
, function(value)
    vis.win.softtabstop =
      value
    return true
  end
, "Indentation width for smart backspace (0 or 1 to disable)"
)


local function is_spaces(str)
  return string.match(str, "^ +$")
end


local function utf8_prefix_byte(byte)
  local number =
    byte:byte()
  return
    number < 128
    or number >= 191
end


local function delete_characters(position, num_chars)
  local win =
    vis.win
  local prefixes_seen =
    0
  local num_bytes =
    0

  repeat
    num_bytes =
      num_bytes + 1
    byte =
      win.file:content(position - num_bytes, 1)
    if utf8_prefix_byte(byte) then
      prefixes_seen =
        prefixes_seen + 1
    end
  until (prefixes_seen >= num_chars)

  win.file:delete(position - num_bytes, num_bytes)

  return num_bytes
end


local function near_space_indent(selection)
  local line_start =
    selection.pos - selection.col + 1
  local line_prefix =
    vis.win.file:content(line_start, selection.col - 1)
  return is_spaces(line_prefix)
end


local function modulus_big(dividend, divisor)
  local quotient =
    dividend % divisor
  if quotient == 0 then
    return divisor
  end
  return quotient
end


local function constrain(num, minimum, maximum)
  return math.max(minimum, math.min(num, maximum))
end


local function get_selections(win)
  local selections =
    {}

  for selection in win:selections_iterator() do
    if selection.pos ~= nil
    and selection.pos ~= 0 then
      table.insert(selections, selection)
    end
  end

  -- handle deletions backwards so as not to invalidate indices
  table.sort(selections, function(a, b) return a.pos > b.pos end)

  return selections
end


local function smart_backspace()
  local win =
    vis.win

  local tab_width =
    win.softtabstop
    or tabstop
  if tab_width < 1 then
    tab_width =
      1
  end

  for _, selection in ipairs(get_selections(win)) do
    local length =
      1

    if near_space_indent(selection) then
      local tab_stop =
        modulus_big(selection.col - 1, tab_width)

      length =
        math.floor(constrain(tab_stop, 1, selection.col))
    end

    if length then
      local pos =
        selection.pos
      local deleted_bytes =
        delete_characters(pos, length)
      selection.pos =
        pos - deleted_bytes
    end
  end

  -- vis doesn't seem to update the syntax highlighting in other splits of
  -- the same file when we edit the file directly like this.
  -- a workaround is to send vis a no-op insert command.
  -- https://github.com/ingolemo/vis-smart-backspace/issues/2
  vis:insert("")
end

vis.events.subscribe
( vis.events.INIT
, function()
    vis:map(vis.modes.INSERT, "<Backspace>", smart_backspace)
  end
)
