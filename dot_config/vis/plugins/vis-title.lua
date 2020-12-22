-- Vis Title Plugin
-- Set window title to filename.

require("vis")


local no_name =
  "[No Name]"


local function filename(path)
  return
    path
    and string.gsub(path, ".*/(.+)$", "%1")
end


local function set_title(title)
  vis:command([[:!echo -ne '\033]0;]] .. title .. [[\007']])
end


vis.events.subscribe
( vis.events.WIN_OPEN
, function(win)
    set_title
    ( filename(win.file.name)
      or no_name
    )
  end
)


vis.events.subscribe
( vis.events.FILE_SAVE_POST
, function(file, _path)
    set_title(filename(file.name))
  end
)
