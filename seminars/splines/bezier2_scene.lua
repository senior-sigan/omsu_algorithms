local lib = require('lib')

local time = 0
local speed = 1 / 2

local p1 = { x = 440, y = 50 }
local p2 = { x = 445, y = 220 }
local p3 = { x = 695, y = 430 }
local p = p1
local a = p1
local b = p2

local grabber = lib.Grabber({ p1, p2, p3 })

local function update(dt)
  time = time + speed * dt
  if time > 1 or time < 0 then
    time = lib.clamp01(time)
    speed = -1 * speed
  end

  grabber.update(dt)

  p, a, b = lib.quad_bezier(p1, p2, p3, time)
end

local function draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle('fill', p1.x, p1.y, 8)
  love.graphics.circle('fill', p2.x, p2.y, 8)
  love.graphics.circle('fill', p3.x, p3.y, 8)

  love.graphics.setColor(0, 1, 0)
  love.graphics.circle('fill', a.x, a.y, 4)
  love.graphics.circle('fill', b.x, b.y, 4)

  love.graphics.setColor(1, 0, 0)
  love.graphics.circle('fill', p.x, p.y, 8)

  local z0 = p1
  for t = 0, 1, 0.01 do
    local z1, _, _ = lib.quad_bezier(p1, p2, p3, t)
    love.graphics.line(z0.x, z0.y, z1.x, z1.y)
    z0 = z1
  end
end

return {
  update = update,
  draw = draw,
}
