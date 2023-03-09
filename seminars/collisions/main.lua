local Circle = require('circle')
local Vec = require('vec')

---
---@param circleA Circle
---@param circleB Circle
local function circleCircle(circleA, circleB)
  local dir = circleA.c - circleB.c --[[@as Vec]]
  return dir:length() < (circleA.r + circleB.r)
end

---@param circleA Circle
---@param circleB Circle
local function staticCircleResolution(circleA, circleB)
  local dir = circleA.c - circleB.c --[[@as Vec]]
  local overlap = (dir:length() - circleA.r - circleB.r) / 2.0
  local mov = dir:norm() * overlap --[[@as Vec]]
  circleA.c.x = circleA.c.x - mov.x
  circleA.c.y = circleA.c.y - mov.y

  circleB.c.x = circleB.c.x + mov.x
  circleB.c.y = circleB.c.y + mov.y
end

---@param circle Circle
---@param point Vec
local function circlePoint(circle, point)
  local dir = circle.c - point
  return dir:length() < circle.r
end

local selected = nil
local circles = {}

function love.load()
  for i = 1, 15, 1 do
    local x = math.random() * love.graphics.getWidth()
    local y = math.random() * love.graphics.getHeight()
    table.insert(circles, Circle:new(x, y, 32))
  end
end

function love.update(dt)
  local mousePos = Vec.new(love.mouse.getPosition())

  if love.mouse.isDown(1) and not selected then
    for _, circle in ipairs(circles) do
      if circlePoint(circle, mousePos) then
        selected = circle
        break
      end
    end
  end
  if not love.mouse.isDown(1) and selected then
    selected = nil
  end

  if selected ~= nil then
    selected.c.x = mousePos.x
    selected.c.y = mousePos.y
  end

  for i = 1, #circles, 1 do
    for j = i + 1, #circles, 1 do
      local ci = circles[i]
      local cj = circles[j]
      if circleCircle(ci, cj) then
        staticCircleResolution(ci, cj)
      end
    end
  end
end

function love.draw()
  for _, circle in ipairs(circles) do
    if circle.collides == true then
      love.graphics.setColor(1, 0, 0)
    else
      love.graphics.setColor(1, 1, 1)
    end
    love.graphics.circle('fill', circle.c.x, circle.c.y, circle.r)
  end
end
