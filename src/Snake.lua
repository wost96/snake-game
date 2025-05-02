-- Table to store all information pertaining to the snake
-- like its segments, its length, its current direction.
local Direction = require 'src.Direction'
local Snake = {segments = {}, dir = Direction.RIGHT}

-- Initialize a new Snake.
function Snake:new(xPos, yPos)
  table.insert(self.segments, {x = xPos, y = yPos})
  return self
end

function Snake:getHead()
  return self.segments[1]
end

function Snake:getTail()
  return self.segments[#self.segments]
end

function Snake:getSegments()
  return self.segments
end

function Snake:setDirection(dir)
  self.dir = dir
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(self.dir, 100, 100)
end

-- Variable `dir` is of "type" Direction, and
-- is one of four values with a corresponding
-- `{x, y}`-table.
function Snake:addSegment()
  local newHead = {
    x = self:getHead().x + self.dir.x,
    y = self:getHead().y + self.dir.y
  }
  
  table.insert(self.segments, 1, newHead)
end

-- Return true if fruit is eaten.
function Snake:move(board)
  local newHead = {
    x = self:getHead().x + self.dir.x,
    y = self:getHead().y + self.dir.y
  }

  -- just debugging
  self.dir = Direction.STOP

  -- Check if moved to space
  -- is valid.
  local nextSpace = board:find(newHead.x, newHead.y)
  if(nextSpace.value == "#") then return end

  table.remove(self.segments, #self.segments)
  table.insert(self.segments, 1, newHead)
end

function Snake:update(dt, b)
  for i = 1, #self.segments do
    b:find(self.segments[i].x, self.segments[i].y).value = "o"
  end
  b:find(self:getHead().x, self:getHead().y).value = "^"
end

return Snake