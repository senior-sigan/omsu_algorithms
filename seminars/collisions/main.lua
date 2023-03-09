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

local function handleSelection()
  local mousePos = Vec.new(love.mouse.getPosition())

  if love.mouse.isDown(1) and not selected then
    for _, circle in ipairs(circles) do
      if circlePoint(circle, mousePos) then
        selected = circle
        break
      end
    end
  end
  if not love.mouse.isDown(1) and selected ~= nil then
    local dir = selected.c - mousePos
    selected.vel = dir * 3
    selected = nil
  end
end


function love.update(dt)
  handleSelection()

  for _, circle in ipairs(circles) do
    circle.acc = circle.vel * -0.5 -- эмуляция трения

    circle.vel = circle.vel + circle.acc * dt
    circle.c = circle.c + circle.vel * dt

    if circle.vel:length() < 0.1 then
      circle.vel = Vec(0, 0)
    end

    if circle.c.x < 0 then
      circle.c.x = love.graphics.getWidth() + circle.c.x
    end
    if circle.c.y < 0 then
      circle.c.y = love.graphics.getHeight() + circle.c.y
    end
    if circle.c.x > love.graphics.getWidth() then
      circle.c.x = circle.c.x - love.graphics.getWidth()
    end
    if circle.c.y > love.graphics.getHeight() then
      circle.c.y = circle.c.y - love.graphics.getHeight()
    end
  end

  local collisions = {}

  for i = 1, #circles, 1 do
    for j = i + 1, #circles, 1 do
      local ci = circles[i]
      local cj = circles[j]
      if circleCircle(ci, cj) then
        table.insert(collisions, { ci, cj })
        staticCircleResolution(ci, cj)
      end
    end
  end

  for _, col in ipairs(collisions) do
    local a, b = unpack(col)
    local dir = b.c - a.c
    local dist = dir:length()

    local normal = dir:norm()
    local tangent = Vec(-normal.y, normal.x)

    local dpNormA = a.vel:dot(normal)
    local dpNormB = b.vel:dot(normal)

    local dpTangA = a.vel:dot(tangent)
    local dpTangB = b.vel:dot(tangent)

    -- сохранение импульса
    local p1 = (dpNormA * (a.m - b.m) + 2 * b.m * dpNormB) / (a.m + b.m)
    local p2 = (dpNormB * (b.m - a.m) + 2 * a.m * dpNormA) / (a.m + b.m)

    a.vel = tangent * dpTangA + normal * p1
    b.vel = tangent * dpTangB + normal * p2
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

  if love.mouse.isDown(1) and selected ~= nil then
    love.graphics.push()
    love.graphics.setColor(0, 0, 1)
    love.graphics.setLineWidth(4)
    love.graphics.line(selected.c.x, selected.c.y, love.mouse.getX(), love.mouse.getY())
    love.graphics.pop()
  end
end
