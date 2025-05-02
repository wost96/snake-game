local Fruit = { x = 0, y = 0 }

function Fruit:new(x, y)
  self.x = x
  self.y = y
  return self
end

function Fruit:getX()
  return self.x
end

function Fruit:getY()
  return self.y
end

return Fruit