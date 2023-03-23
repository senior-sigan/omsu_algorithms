local function lerp(a, b, t)
  return a * (1-t) + b * t
end

local function lerp2d(a, b, t)
  return {
    x=lerp(a.x, b.x, t),
    y=lerp(a.y, b.y, t),
  }
end

local function invLerp(a, b, v)
  return (v-a) / (b - a)
end

local function invLerp2d(a, b, v)
  return {
    x= invLerp(a.x, b.x, v),
    y= invLerp(a.y, b.y, v),
  }
end

local function remap(a1,a2, b1,b2, a)
  local t = invLerp(a1,a2, a)
  return lerp(b1, b2, t)
end

local function remap2d(a1,a2, b1,b2, a)
  local t = invLerp(a1,a2, a)
  return lerp2d(b1, b2, t)
end



local function clamp01(a)
  return math.min(1, math.max(a, 0))
end

local function quad_bezier(p1, p2, p3, t)
  local a = lerp2d(p1, p2, t)
  local b = lerp2d(p2, p3, t)
  local p = lerp2d(a, b, t)
  return p, a, b
end

local function cubic_bezier(p1, p2, p3, p4, t)
  local a = lerp2d(p1, p2, t)
  local b = lerp2d(p2, p3, t)
  local c = lerp2d(p3, p4, t)
  local aa = lerp2d(a, b, t)
  local bb = lerp2d(b, c, t)
  local aaa = lerp2d(aa, bb, t)
  return aaa
end

local function pointCircle(point, circle)
  local dist = (point.x - circle.x) ^ 2 + (point.y - circle.y) ^ 2
  return dist < circle.r ^ 2
end

local function Grabber(points)
  local grabbedPoint = nil

  local function update(dt)
    local x, y = love.mouse.getPosition()
    if love.mouse.isDown(1) then
      for _, pt in ipairs(points) do
        if pointCircle({ x = x, y = y }, { x = pt.x, y = pt.y, r = 16 }) then
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
  end

  return { update = update }
end

return {
  lerp=lerp,
  lerp2d=lerp2d,
  remap=remap,
  remap2d=remap2d,
  clamp01=clamp01,
  quad_bezier = quad_bezier,
  cubic_bezier = cubic_bezier,
  pointCircle = pointCircle,
  Grabber = Grabber,
}