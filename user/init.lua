-- put user settings here

-- this module will be loaded after everything else when the application starts
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"
local core  = require "core"
local common = require "core.common"
local DocView = require "core.docview"
local syn_config = require "plugins.synconfig"
local console    = require "plugins.console"

-- light theme:
require "user.colors.liqube"

-- key binding:
keymap.add {
  ["ctrl+shift+q"] = "core:quit",
  ["alt+x"] = "core:find-command",
  ["ctrl+i"] = "core:find-file",
  ["ctrl+l"] = "doc:duplicate-lines",
  ["ctrl+a"] = "doc:move-to-start-of-line",
  ["ctrl+e"] = "doc:move-to-end-of-line",
  ["ctrl+pageup"] = "doc:move-to-start-of-doc",
  ["ctrl+pagedown"] = "doc:move-to-end-of-doc",
  ["ctrl+shift+pageup"] = "doc:select-to-start-of-doc",
  ["ctrl+shift+pagedown"] = "doc:select-to-end-of-doc",

  ["ctrl+p"]       = "project-manager:open-project",
  ["ctrl+shift+p"] = "project-manager:switch-project",
}

syn_config.add({
  {
    files = {"%.c$", "%.h$", "%.cpp$", "%.hpp$", "%.inl$", "%.odin", "%.glsl"},
    config = {
      indent_size = 4,
    }
  },
})

