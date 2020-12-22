-- Vis Sleuth Plugin
-- Detect and set indentation.

require("vis")


local tab_width =
  2


local defaults =
  { expandtab = "on"
  , softtabstop = tab_width
  , tabwidth = tab_width
  }


local function vis_sleuth(win)
  local function map(fn, list)
    local mapped =
      {}
    for key, value in pairs(list) do
      mapped[key] =
        fn(key, value)
    end
    return mapped
  end

  local function command(option, value)
    vis:command("set " .. option .. " " .. value)
    return true
  end

  local function commands(options)
    local merged =
      options
    for key, value in pairs(defaults) do
      if not merged[key] then
        merged[key] = value
      end
    end
    return map(command, merged)
  end

  local new_file =
  { elixir =
    function()
      commands(defaults)
    end

  , elm =
    function()
      commands({ ["elm-format-indent"] = tab_width })
    end

  , python =
    function()
      local tab_width = 4
      commands
      ( { softtabstop = tab_width
        , tabwidth = tab_width
        }
      )
    end
  }

  if type(new_file[win.syntax]) == "function" then
    new_file[win.syntax]()
  else
    commands(defaults)
  end
end


vis.events.subscribe(vis.events.WIN_OPEN, vis_sleuth)
