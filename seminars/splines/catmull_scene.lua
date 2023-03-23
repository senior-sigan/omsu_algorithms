local lib = require('lib')

local time = 0
local speed = 1 / 2

local points = {
  { x = 140, y = 50 },
  { x = 145, y = 220 },
  { x = 605, y = 300 },
  { x = 395, y = 430 }
}

local grabber = lib.Grabber(points)

local alpha = 0.5

local function knotInterval(ti, pi, pj)
  local l = math.sqrt((pi.x - pj.x) ^ 2 + (pi.y - pj.y) ^ 2)
  return ti + l ^ alpha
end

local function getPoint(p0, p1, p2, p3, t)
  local k0 = 0
  local k1 = knotInterval(k0, p0, p1)
  local k2 = knotInterval(k1, p1, p2)
  local k3 = knotInterval(k2, p2, p3)

  local u = lib.lerp(k1, k2, t)
  local a1 = lib.remap2d(k0, k1, p0, p1, u)
  local a2 = lib.remap2d(k1, k2, p1, p2, u)
  local a3 = lib.remap2d(k2, k3, p2, p3, u)
  local b1 = lib.remap2d(k0, k2, a1, a2, u)
  local b2 = lib.remap2d(k1, k3, a2, a3, u)
  return lib.remap2d(k1, k2, b1, b2, u)
end


local function update(dt)
  time = time + speed * dt
  if time > 1 or time < 0 then
    time = lib.clamp01(time)
    speed = -1 * speed
  end

  grabber.update(dt)
end

local function draw()
  love.graphics.setColor(1, 1, 1)
  for _, point in ipairs(points) do
    love.graphics.circle('fill', point.x, point.y, 4)
  end

  local p = getPoint(points[1], points[2], points[3], points[4], time)
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle('fill', p.x, p.y, 8)

  local z0 = points[2]
  for t = 0, 1, 0.01 do
    local z1 = getPoint(points[1], points[2], points[3], points[4], t)
    love.graphics.line(z0.x, z0.y, z1.x, z1.y)
    z0 = z1
  end
end

return {
  update = update,
  draw = draw,
}
