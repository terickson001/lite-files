local config = require "core.config"
local style = require "core.style"
local core  = require "core"
local common = require "core.common"
local DocView = require "core.docview"

local function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
        end
    else
        copy = orig
    end
    return copy
end

local syn_config = {}
syn_config.configs = {}
local default_config = deepcopy(config)
local current_file = nil

function syn_config.add(t)
  for _, cfg in pairs(t) do
    table.insert(syn_config.configs, cfg)
  end
end

local function get_active_file()
  if getmetatable(core.active_view) == DocView then
    return core.active_view.doc.filename
  end
end

local function find(file)
  for i = #syn_config.configs, 1, -1 do
    local t = syn_config.configs[i]
    if common.match_pattern(file, t.files or {}) then
      return t.config
    end
  end
end

local step = core.step
function core.step()
  step()

  local file = get_active_file()
  if not file then
    current_file = file
    for k, v in pairs(default_config) do
      config[k] = v
    end
    return
  elseif file == current_file then
    return
  end
  current_file = file

  local cfg = find(file)
  if not cfg then
    for k, v in pairs(default_config) do
      config[k] = v
    end
    return
  end

  for k, v in pairs(cfg) do
    config[k] = v
  end
end

local load_project_module = core.load_project_module
function core.load_project_module()
  local res = load_project_module()
  default_config = deepcopy(config)
  return res
end

return syn_config
