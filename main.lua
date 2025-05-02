local Direction = require "src.Direction"
local Snake = require "src.Snake"
local Fruit = require "src.Fruit"
local score = 0
local MAX_DIMENSIONS = { x = 10, y = 10 }
local SIZE = 40

local colors = {
  white = { 200 / 255, 200 / 255, 200 / 255 },
  gray = {20 / 255, 20 / 255, 20 / 255},
  green = {10 / 255, 200 / 255, 150 / 255},
  red = { 200 / 255, 10 / 255, 80 / 255 },
  border = { 0, 0, 0, .4 }
}

function find(board, x, y)
  -- Find specific point on board with x, y positions
  local pos = (x - 1) * MAX_DIMENSIONS.y + y
  return board[pos]
end

function findClearSpace(b)
  local rX = math.random(1, MAX_DIMENSIONS.x)
  local rY = math.random(1, MAX_DIMENSIONS.y)

  while(find(b, rX, rY).value == "#" or find(b, rX, rY) == "o") do
    rX = math.random(1, MAX_DIMENSIONS.x)
    rY = math.random(1, MAX_DIMENSIONS.y)
  end

  return {rX, rY}
end

function color(c)
  love.graphics.setColor(unpack(c))
end

function love.load()
  -- inspect = require "util.inspect"
  snake = Snake:new(MAX_DIMENSIONS.x / 2, MAX_DIMENSIONS.y / 2)
  board = { }

  for i = 1, MAX_DIMENSIONS.y do
    for j = 1, MAX_DIMENSIONS.x do
      table.insert(board, {coor = {x = i, y = j}, value = "."})
    end
  end

  fruit = Fruit:new(unpack(findClearSpace(board)))
  find(board, fruit:getX(), fruit:getY()).value = "*"
end

function love.update(dt)
  -- refresh board
  for i = 1, #board do
    local cur = board[i].coor
    if      cur.y == 1 or cur.y == MAX_DIMENSIONS.y then board[i].value = "#"
    elseif  cur.x == 1 or cur.x == MAX_DIMENSIONS.x then board[i].value = "#"
    else    board[i].value = "." end
  end

  find(board, fruit:getX(), fruit:getY()).value = "*"

  local fruitEaten = snake:move(board)
  if fruitEaten then
    score = score + 1
    fruit = Fruit:new(unpack(findClearSpace(board)))
  end
  
  local snakeSegments = snake:getSegments()
  for i = 1, #snakeSegments do
    find(board, snakeSegments[i].x, snakeSegments[i].y).value = "o"
  end
end

function love.keypressed(key)
  if key == "up"    then snake:setDirection(Direction.UP) end
  if key == "down"  then snake:setDirection(Direction.DOWN) end
  if key == "right" then snake:setDirection(Direction.RIGHT) end
  if key == "left"  then snake:setDirection(Direction.LEFT) end
end

function love.draw()
  love.graphics.setColor( 1, 1, 1 )
  love.graphics.print("Score: " .. score)

  color(colors.white)

  for i = 1, #board do

    if board[i].value == "." then color(colors.white)
    elseif board[i].value == "#" then color(colors.gray)
    elseif board[i].value == "o" then color(colors.green)
    elseif board[i].value == "*" then color(colors.red)
    end

    love.graphics.rectangle("fill", 
      (board[i].coor.x * SIZE) - SIZE, (board[i].coor.y * SIZE),
      SIZE, SIZE
    )

    color(colors.border)
    
    love.graphics.rectangle("line", 
      (board[i].coor.x * SIZE) - SIZE, (board[i].coor.y * SIZE),
      SIZE, SIZE
    )
  end
end