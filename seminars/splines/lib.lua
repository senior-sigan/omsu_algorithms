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

return {
  lerp=lerp,
  clamp01=clamp01,
  lerp2d=lerp2d,
}