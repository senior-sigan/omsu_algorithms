local Vec = require('vec')

---@class Circle
local Circle = {
  c = Vec.new(0, 0),
  r = 1,
  m = 1,
  vel = Vec.new(0, 0),
  acc = Vec.new(0, 0),
}

function Circle:new(x, y, r)
  local newobj = { c = Vec.new(x, y), r = r }
  self.__index = self
  return setmetatable(newobj, self)
end

return Circle
