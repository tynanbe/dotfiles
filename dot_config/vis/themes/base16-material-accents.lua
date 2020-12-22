-- Base 16 Material Accents theme Copyright (c) Tynan Beatty (https://www.ZSRweb.com/)

local lexers =
  vis.lexers


local colors =
  { base00 = "#212121" -- ----          =  Grey          900
  , base01 = "#424242" -- ---           =  Grey          800
  , base02 = "#757575" -- --            =  Grey          600
  , base03 = "#9e9e9e" -- -             =  Grey          500
  , base04 = "#bdbdbd" -- +             =  Grey          400
  , base05 = "#e0e0e0" -- ++            =  Grey          300
  , base06 = "#f5f5f5" -- +++           =  Grey          100
  , base07 = "#fafafa" -- ++++          =  Grey           50
  , base08 = "#ff80ab" -- red           =  Pink         A100
  , base09 = "#ffd180" -- orange        =  Orange       A100
  , base0A = "#ffff8d" -- yellow        =  Yellow       A100
  , base0B = "#b9f6ca" -- green         =  Green        A100
  , base0C = "#84ffff" -- cyan          =  Cyan         A100
  , base0D = "#80d8ff" -- blue          =  Light Blue   A100
  , base0E = "#b388ff" -- violet        =  Deep Purple  A100
  , base0F = "#ff9e80" -- magenta/brown =  Deep Orange  A100
  }


-- TODO: create a setting to switch between different bg/fg pairs

-- Dark
-- local bg =
--   ",back:"..colors.base00..","
-- local fg =
--   ",fore:"..colors.base05..","

-- Dark (transparent background)
local bg =
  ""
local fg =
  ",fore:"..colors.base05..","


-- Light
-- local bg =
--   ",back:"..colors.base07..","
-- local fg =
--   ",fore:"..colors.base02..","

-- Light (transparent background)
-- local bg =
--   ""
-- local fg =
--   ",fore:"..colors.base02..","


-- Syntax Styles

lexers.STYLE_DEFAULT      = bg..fg
lexers.STYLE_NOTHING      = bg
lexers.STYLE_BRACEBAD     = "fore:"..colors.base08..",reverse"
lexers.STYLE_BRACELIGHT   = "back:"..colors.base0A..",fore:"..colors.base00
lexers.STYLE_CLASS        = "fore:"..colors.base0A
lexers.STYLE_COMMENT      = "fore:"..colors.base03..",italics"
lexers.STYLE_CONSTANT     = "fore:"..colors.base09
lexers.STYLE_DEFINITION   = "fore:"..colors.base0E
lexers.STYLE_EMBEDDED     = "fore:"..colors.base0F
lexers.STYLE_ERROR        = "fore:"..colors.base08..",reverse"
lexers.STYLE_FUNCTION     = "fore:"..colors.base0D
lexers.STYLE_IDENTIFIER   = fg
lexers.STYLE_KEYWORD      = "fore:"..colors.base0E..",italics"
lexers.STYLE_LABEL        = "fore:"..colors.base0A
lexers.STYLE_NUMBER       = "fore:"..colors.base09
lexers.STYLE_OPERATOR     = fg
lexers.STYLE_PREPROCESSOR = "fore:"..colors.base0A
lexers.STYLE_REGEX        = "fore:"..colors.base0C
lexers.STYLE_STRING       = "fore:"..colors.base0B
lexers.STYLE_TAG          = "fore:"..colors.base08
lexers.STYLE_TYPE         = "fore:"..colors.base0A
lexers.STYLE_VARIABLE     = "fore:"..colors.base08
lexers.STYLE_WHITESPACE   = "fore:"..colors.base02


-- UI Styles

lexers.STYLE_COLOR_COLUMN      = "back:"..colors.base01
lexers.STYLE_CURSOR            = "back:"..colors.base05..",fore:"..colors.base00
lexers.STYLE_CURSOR_LINE       = "back:"..colors.base01
lexers.STYLE_CURSOR_PRIMARY    = lexers.STYLE_CURSOR..",back:"..colors.base0A
lexers.STYLE_EOF               = lexers.STYLE_WHITESPACE
lexers.STYLE_INFO              = "back:default,fore:default,bold"
lexers.STYLE_LINENUMBER        = "back:"..colors.base01..",fore:"..colors.base03
lexers.STYLE_LINENUMBER_CURSOR = "back:"..colors.base01..",fore:"..colors.base05
lexers.STYLE_SELECTION         = "back:"..colors.base02
lexers.STYLE_SEPARATOR         = "back:"..colors.base01..",fore:"..colors.base01
lexers.STYLE_STATUS            = "back:"..colors.base01..",fore:"..colors.base03
lexers.STYLE_STATUS_FOCUSED    = "back:"..colors.base01..",fore:"..colors.base04
