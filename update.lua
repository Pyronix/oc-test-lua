local _REPO = "https://raw.githubusercontent.com/Pyronix/oc-test-lua"
local _BRANCH = "master"

local component = require("component")
local event = require("event")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")
local mkdir = loadfile("/bin/mkdir.lua")

local gpu = component.gpu

local internet
local wget

local args, options = shell.parse(...)

local function getInternet()
  if not component.isAvailable("internet") then
    io.stderr:write("This program requires an internet card to run.")
    return false
  end
  internet = require("internet")
  wget = loadfile("/bin/wget.lua")
  return true
end

local function downloadFile(url,path,force,soft)
  if options.f or force then
    return wget("-fq",url,path)
  else
    if fs.exists(path) then
      if soft then
        return true
      else
        error("file already exists and option -f is not enabled")
      end
    end
    return wget("-q",url,path)
  end
end

local function downloadFromRepo(file)
	downloadFile(
		_REPO.."/".._BRANCH.."/"..file, file, true, false
	)
end

if not getInternet() then
    os.exit()
end

downloadFromRepo("run.lua")

if not fs.isDirectory("src/") then 
	mkdir("src/")
end

downloadFromRepo("src/main.lua")

return true