local component = require("component")
local event = require("event")
local fs = require("filesystem")
local shell = require("shell")
local term = require("term")

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


if not getInternet() then
    os.exit()
end

print("Welcome!")
