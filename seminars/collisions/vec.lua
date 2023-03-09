---@class Vec
local Vec = {x=0, y=0}
Vec.__index = Vec

---@param x number|nil
---@param y number|nil
---@return Vec
local function new(x, y)
  return setmetatable({x=x or 0, y=y or 0}, Vec)
end

---@param a Vec
---@param b Vec
---@return Vec
function Vec.__sub(a, b)
  return new(a.x - b.x, a.y - b.y)
end

---@param a Vec
---@param b Vec
---@return Vec
function Vec.__add(a, b)
  return new(a.x + b.x, a.y + b.y)
end

---@param a Vec|number
---@param b Vec|number
---@return Vec
function Vec.__mul(a, b)
  if type(a) == "number" then
    return new(a*b.x, a*b.y)
  elseif type(b) == "number" then
    return new(a.x*b, a.y*b)
  else
    return new(a.x * b.x, a.y * b.y)
  end
end

---@param b Vec
---@return number
function Vec:dot(b)
  return self.x*b.x + self.y*b.y
end

---@return number
function  Vec:length()
  return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vec:norm()
  local len = self:length()
  return new(self.x / len, self.y / len)
end

return setmetatable({
  new=new,
}, {__call = function(_,...) return new(...) end})