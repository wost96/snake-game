local Fruit = { coor={x = 0, y = 0} }
local inspect = require "util.inspect"

function Fruit:new(b)
  local pos = b:findClearSpace()

  self.coor.x = pos.x
  self.coor.y = pos.y

  self.animationFrame = {
    { 210 / 255, 4 / 255, 45 / 255 }, -- Frame 1
    { 215 / 255, 0 / 255, 64 / 255 }  -- Frame 2
  }

  return self
end

function Fruit:getCoor()
  return self.coor
end

function Fruit:getX()
  return self.coor.x
end

function Fruit:getY()
  return self.coor.y
end

function Fruit:update(dt, b)
  b:find(self.coor.x, self.coor.y).value = "*"
end

function Fruit:colorAt(i)
  return self.animationFrame[i]
end

return Fruit