-- Функция для извлечения среза
local function slice(array, startIndex, endIndex)
  local sliced = {}
  for i = startIndex, endIndex do
    table.insert(sliced, array[i])
  end
  return sliced
end


local function kdtree(points, k, depth)
  if #points == 0 then
    return nil
  end

  local axis = depth % k + 1

  table.sort(points, function (a, b)
    return a[axis] < b[axis]
  end)

  local pi = math.floor(#points / 2) + 1
  local pt = points[pi]

  print(pt[1], pt[2])
  local node = {
    point = pt,
    left = kdtree(slice(points, 0, pi - 1), k, depth + 1),
    right = kdtree(slice(points, pi + 1, #points), k, depth + 1),
  }

  return node
end

local function dist(p1, p2)
  -- todo: assert #p1 == #p2
  local s = 0
  for i = 1, #p1, 1 do
    s = s + (p1[i] - p2[i]) ^ 2
  end
  return math.sqrt(s)
end

local function findClosestDummy(points, target)
  if #points == 0 then
    return nil
  end
  if #points == 1 then
    return points[1]
  end

  print(points[1], points[2])
  local bestDist = dist(points[1],points[2])
  local bestPoint = points[1]
  for _, point in ipairs(points) do
    local d = dist(point, target)
    if d < bestDist then
      bestDist = d
      bestPoint = point
    end
  end

  return bestPoint, bestDist
end

local function findClosestKDNaive(tree, target, k, depth, best)
  if tree == nil then
    return best
  end

  local axis = depth % k + 1

  local pt = tree.point

  if best == nil then
    best = pt
  else
    local rootDist = dist(pt, target)
    local bestDist = dist(best, target)

    if rootDist < bestDist then
      bestDist = rootDist
      best = pt
    end
  end

  if target[axis] > pt[axis] then
    return findClosestKDNaive(tree.right, target, k, depth + 1, best)
  else
    return findClosestKDNaive(tree.left, target, k, depth + 1, best)
  end
end

local function generatePoints(n, maxX, maxY)
  local points = {}
  for i = 1, n, 1 do
    local point = {
      love.math.random(0, maxX),
      love.math.random(0, maxY)
    }
    table.insert(points, point)
  end

  return points
end

local points = generatePoints(11, 640, 480)
local tree = kdtree(points, 2, 1)



function love.draw()
  local tx, ty = love.mouse.getPosition()
  local cp, cd = findClosestDummy(points, {tx,ty})

  for _, point in ipairs(points) do
    love.graphics.setColor(1,1,1)
    love.graphics.circle('fill', point[1], point[2], 8)
  end

  if cp ~= nil then
    love.graphics.push()
    love.graphics.setColor(1,0,0)
    love.graphics.circle('fill', cp[1], cp[2], 9)
    love.graphics.pop()
  end

  local best = findClosestKDNaive(tree, {tx, ty}, 2, 1, nil)
  if best ~= nil then
    love.graphics.push()
    love.graphics.setColor(0,1,0)
    love.graphics.circle('fill', best[1], best[2], 5)
    love.graphics.pop()
  end
end