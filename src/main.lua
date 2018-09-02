print("Starting....")

local charts = require("charts")

local container = charts.Container()
local payload = charts.Histogram {
  max = 80,
  align = charts.sides.RIGHT,
  colorFunc = function(index, norm, value, self, container)
    return 0x20ff20
  end
}
container.payload = payload

for i = 1, 400, 1 do
  table.insert(payload.values, math.random(0, 80))
  container:draw()

  os.sleep(.05)
end

return true