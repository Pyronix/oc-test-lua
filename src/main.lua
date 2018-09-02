print("Starting....")

local charts = require("charts")

local container = charts.Container()
local payload = charts.Histogram {
  max = 100,
  align = charts.sides.RIGHT,
  colorFunc = function(index, norm, value, self, container)
    return 0x20ff20
  end
}
container.payload = payload
 
local current, current_max, p

while true do
	current = component.energy_device.getEnergyStored()
	current_max = component.energy_device.getMaxEnergyStored()

	p = current / current_max * 100

	table.insert(payload.values, p)
	container:draw()
	os.sleep(1)
end

return true