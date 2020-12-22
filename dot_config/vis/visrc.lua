-- Load standard vis module, providing parts of the Lua API
require("vis")

require("plugins/vis-elm")
require("plugins/vis-sleuth")
require("plugins/vis-smart-backspace")
require("plugins/vis-title")


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


vis.events.subscribe
( vis.events.INIT
, function()
    -- Global configuration options
    map
    ( command
    , { autoindent = "on"
      , expandtab = "on"
      , layout = "v"
      , tabwidth = 2
      , theme = "base16-material-accents"
      }
    )
  end
)


vis.events.subscribe
( vis.events.WIN_OPEN
, function(win)
    -- Per-window configuration options
    map
    ( command
    , { colorcolumn = 0 --81
      , cursorline = "on"
      --, numbers = "on"
      , relativenumbers = "on"
      , ["show-eof"] = "off"
      , ["show-newlines"] = "on"
      --, ["show-spaces"] = "on"
      , ["show-tabs"] = "on"
      
      }
    )
  end
)


local function match_script(lexer, commands)
  if nil == commands then
    commands =
      { lexer }
  end

  vis.ftdetect.filetypes[lexer].detect =
    function(file, data)
      for _index, command in pairs(commands) do
        if data:match("^#!/usr/bin/env[ ]+" .. command .. "[%d%s]") then
          return true
        end
      end

      return false
    end
end


-- Syntax highlighting detection by matching #!/usr/bin/env cmd
-- keys = lexers
-- values = nil | an array of commands to match against
-- if values == nil, use the lexer name as the command to match against
map
( match_script
, { awk
  , bash = { "bash", "csh", "dash", "sh", "zsh" }
  , fish
  , julia
  , lua
  , perl
  , php
  , python
  , ruby
  }
)


-- Use makefile syntax highlighting for justfile
table.insert
( vis.ftdetect.filetypes.makefile.ext
, "^[Jj][Uu][Ss][Tt][Ff][Ii][Ll][Ee]$"
)
