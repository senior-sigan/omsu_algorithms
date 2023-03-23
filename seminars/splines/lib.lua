local function lerp(a, b, t)
  return a * (1-t) + b * t
end

local function clamp01(a)
  return math.min(1, math.max(a, 0))
end

local function lerp2d(a, b, t)
  return {
    x=lerp(a.x, b.x, t),
    y=lerp(a.y, b.y, t),
  }
end

local function qubic_bezier(p1, p2, p3, t)
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

return {
  lerp=lerp,
  clamp01=clamp01,
  lerp2d=lerp2d,
  qubic_bezier = qubic_bezier,
  cubic_bezier = cubic_bezier,
  pointCircle = pointCircle,
}