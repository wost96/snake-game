-- Table to store all information pertaining to the snake
-- like its segments, its length, its current direction.
local Direction = require 'src.Direction'
local Snake = {segments = {}, dir = Direction.STOP}

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
      y = self:getHead().x + self.dir.y
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
  -- self.dir = Direction.STOP

  -- Check if moved to space
  -- is valid.
  local nextSpace = find(board, newHead.x, newHead.y)
  if(nextSpace.value == "#") then return false end
  if(nextSpace.value == "*") then
    self:addSegment()
    return true
  end

  table.remove(self.segments, #self.segments)
  table.insert(self.segments, 1, newHead)

  return false
end

return Snake