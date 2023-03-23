local lib = require('lib')

local time = 0
local speed = 1 / 2

local p1 = { x = 140, y = 50 }
local p2 = { x = 145, y = 220 }
local p3 = { x = 605, y = 300 }
local p4 = { x = 395, y = 430 }
local points = { p1, p2, p3, p4 }

local p = p1

local grabbedPoint = nil

local function update(dt)
  time = time + speed * dt
  if time > 1 or time < 0 then
    time = lib.clamp01(time)
    speed = -1 * speed
  end


  local x, y = love.mouse.getPosition()
  if love.mouse.isDown(1) then
    for _, pt in ipairs(points) do
      if lib.pointCircle({ x = x, y = y }, { x = pt.x, y = pt.y, r = 16 }) then
        grabbedPoint = pt
      end
    end
  else
    grabbedPoint = nil
  end

  if grabbedPoint ~= nil then
    grabbedPoint.x = x
    grabbedPoint.y = y
  end

  p = lib.cubic_bezier(p1, p2, p3, p4, time)
end

local function draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle('fill', p1.x, p1.y, 8)
  love.graphics.circle('fill', p2.x, p2.y, 4)
  love.graphics.circle('fill', p3.x, p3.y, 4)
  love.graphics.circle('fill', p4.x, p4.y, 8)

  love.graphics.line(p1.x, p1.y, p2.x, p2.y)
  love.graphics.line(p3.x, p3.y, p4.x, p4.y)

  love.graphics.setColor(1, 0, 0)
  love.graphics.circle('fill', p.x, p.y, 8)
end

return {
  update = update,
  draw = draw,
}
