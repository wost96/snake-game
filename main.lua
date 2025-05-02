local Direction = require "src.Direction"
local Board = require "src.Board"
local Snake = require "src.Snake"
local Fruit = require "src.Fruit"
local inspect = require "util.inspect"
local math = require "math"

local SCORE = 0
local MAX_DIMENSIONS = { x = 10, y = 10 }
local SIZE = 40
local snake, fruit, board, fakeClock

local moveTimer = 0
local moveInterval = .1

local colors = {
  white = { 200 / 255, 200 / 255, 200 / 255 },
  gray = {20 / 255, 20 / 255, 20 / 255},
  green = {10 / 255, 200 / 255, 150 / 255},
  dgreen = {6 / 255, 127 / 255, 95 / 255},
  red = { 210 / 255, 4 / 255, 45 / 255 },
  border = { 0, 0, 0, .4 }
}

function color(c)
  love.graphics.setColor(unpack(c))
end

function love.load()
  -- inspect = require "util.inspect"
  snake = Snake:new(MAX_DIMENSIONS.x / 2, MAX_DIMENSIONS.y / 2)
  board = Board:new(MAX_DIMENSIONS.x, MAX_DIMENSIONS.y)
  fruit = Fruit:new(board)
  fakeClock = 1

  math.randomseed(os.time())
end

function love.update(dt)
  -- check collision between snake and fruit
  if board:collide( snake:getHead().x, snake:getHead().y, fruit:getX(), fruit:getY() ) then
    SCORE = SCORE + 1
    snake:addSegment()
    fruit = Fruit:new(board)
  end

  -- update board
  board:update(dt)

  -- update fruit on board
  fruit:update(dt, board)
  
  -- update snake on board
  snake:update(dt, board)
end

function love.keypressed(key)
  if key == "up" or key == "down" or key == "right" or key == "left" then
    snake:setDirection( Direction[string.upper(key)] )
    snake:move(board)
    -- board:debugPrint()
  end
end

function love.draw()
  love.graphics.setColor( 1, 1, 1 )
  love.graphics.print("Score: " .. SCORE)

  fakeClock = fakeClock + 1
  local fakeClockIndex = 1
  if(fakeClock % 100 == 0) then
    if fakeClockIndex == 1 then fakeClockIndex = 2
    else fakeClockIndex = 1 end
  end

  color(colors.white)

  for i = 1, board:getLength() do

    if board:getValueAt(i) == "." then
      color(colors.white)
    elseif board:getValueAt(i) == "#" then
      color(colors.gray)
    elseif board:getValueAt(i) == "o" then 
      color(colors.green)
    elseif board:getValueAt(i) == "*" then 
      color(Fruit:colorAt(fakeClockIndex))
    elseif board:getValueAt(i) == "^" then
      color(colors.dgreen)
    end

    love.graphics.rectangle("fill", 
      (board:getCoorAt(i).x * SIZE) - SIZE, (board:getCoorAt(i).y * SIZE),
      SIZE, SIZE
    )

    color(colors.border)
    
    love.graphics.rectangle("line", 
      (board:getCoorAt(i).x * SIZE) - SIZE, (board:getCoorAt(i).y * SIZE),
      SIZE, SIZE
    )
  end
end