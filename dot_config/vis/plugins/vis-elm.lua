-- Vis Elm Plugin
-- Auto-format Elm code on save.

require("vis")


local cmd =
  "elm-format --stdin"


local indent =
  4


vis:option_register
( "elm-format"
, "bool"
, function(value)
    vis.win.elm_format =
      value
    return true
  end
, "Auto-format Elm files on write"
)


vis:option_register
( "elm-format-cmd"
, "string"
, function(value)
    vis.win.elm_format_cmd =
      value
    return true
  end
, "Command to format Elm code (" .. cmd .. ")"
)


vis:option_register
( "elm-format-indent"
, "number"
, function(value)
    vis.win.elm_format_indent =
      value
    return true
  end
, "Indentation width for Elm code formatting (0 for tab)"
)


local function elm_format(file, path)
  local win =
    vis.win

  if win.syntax ~= "elm"
  or win.elm_format == false then
    return true
  end

  local function pipe(cmd)
    local pos =
      win.selection.pos

    local status, out, err =
      vis:pipe(file, { start = 0, finish = file.size }, cmd)

    if status ~= 0
    or not out then
      if err then
        vis:info(err)
      end
      return false
    end

    file:delete(0, file.size)
    file:insert(0, out)
    win.selection.pos =
      pos
  end

  pipe
  ( win.elm_format_cmd
    or cmd
  )

  if win.elm_format_indent
  and win.elm_format_indent ~= indent then
    local find =
      string.rep(" ", indent)
    local replace =
      (win.elm_format_indent == 0)
      and [[\t]]
      or string.rep(" ", win.elm_format_indent)

    pipe
    ( "sed"
      .. [[ -e 's/^/~/']]
      .. [[ -e ': r']]
      .. [[ -e 's/^\(\s*\)~]] .. find .. [[/\1]] .. replace .. [[~/']]
      .. [[ -e 't r']]
      .. [[ -e 's/~//']]
    )
  end

  return true
end


vis.events.subscribe(vis.events.FILE_SAVE_PRE, elm_format)
