local lib = require('lib')

local time = 0
local speed = 1/2

local p1 = {x=40, y=50}
local p2 = {x=300, y=400}
local p = p1

local function update(dt)
  time = time + speed * dt
  if time > 1 or time < 0 then
    time = lib.clamp01(time)
    speed = -1 * speed
  end

  p = lib.lerp2d(p1, p2, time)
end

local function draw()
  love.graphics.setColor(1,1,1)
  love.graphics.circle('fill', p1.x, p1.y, 8)
  love.graphics.circle('fill', p2.x, p2.y, 8)

  love.graphics.setColor(1,0,0)
  love.graphics.circle('fill', p.x, p.y, 8)

  love.graphics.line(p1.x, p1.y, p2.x, p2.y)
end

return {
  update=update,
  draw=draw,
}