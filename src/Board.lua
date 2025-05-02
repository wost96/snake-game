local Board = { }
local math = require "math"

function Board:new(xMAX, yMAX)
  self.max_x = xMAX
  self.max_y = yMAX
  self.content = {}
  self.max_size = self.max_x * self.max_y

  for i = 1, self.max_y do
    for j = 1, self.max_x do
      table.insert(self.content, {coor = {x = i, y = j}, value = "."})
    end
  end

  return self
end

function Board:getLength()
  return self.max_size
end

function Board:getValueAt(i)
  return self.content[i].value
end

function Board:getCoorAt(i)
  return self.content[i].coor
end

function Board:find(x, y)
    -- Find specific point on board with x, y positions
    local pos = (x - 1) * self.max_y + y
    return self.content[pos]
end

function Board:findClearSpace()
  local _x = math.random(1, self.max_x)
  local _y = math.random(1, self.max_y)

  local temp = self:find(_x, _y).value

  local safe = 0

  while(temp ~= "." and safe < self.max_size) do
    _x = math.random(1, self.max_x)
    _y = math.random(1, self.max_y)

    temp = self:find(_x, _y).value

    safe = safe + 1
  end

  if safe > self.max_size - 5 then love.event.quit() end

  return {x=_x, y=_y}
end

function Board:update(dt)

  for i = 1, self.max_size do
    local cur = self.content[i].coor
    if      cur.y == 1 or cur.y == self.max_x then self.content[i].value = "#"
    elseif  cur.x == 1 or cur.x == self.max_y then self.content[i].value = "#"
    else    self.content[i].value = "." end
  end
end

function Board:collide(x1, y1, x2, y2)
  return x1 == x2 and y1 == y2
end

function Board:debugPrint()
  io.write("\n\n")
  for i=1, self.max_size do
    io.write(self:getValueAt(i))
    if self:getCoorAt(i).x == self.max_x then io.write("\n") end
  end
end

return Board