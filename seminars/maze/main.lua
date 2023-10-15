-- массив тайлов уровня 256x256

local MAP_WIDTH, MAP_HEIGHT = 80, 80
local TW, TH = 8,8
local map = {}

local MAX_FORKS = 10
local dig_rotate_after = 8
local dig_energy = 100
local dig_tile = {0, 1, 1}
local dig_dir = {0, 1}
local dig_queue_idx = 1
local dig_queue = {{40, 40}}
local dig_pos = dig_queue[dig_queue_idx] -- откуда начинаем копать

local function vec2_sum(v1, v2)
  return {v1[1] + v2[1], v1[2] + v2[2]}
end

function  love.load()
  map = {}
  for j = 1, MAP_HEIGHT, 1 do
    map[j] = {}
    for i = 1, MAP_WIDTH, 1 do
      map[j][i] = -1
    end
  end
end

local function rotate_dir(dir, angle)
  return {dir[2] * angle, dir[1] * angle}
end

local function spawn_room()
  local size = math.random(3, 6)
  for j = 1, size, 1 do
    for i = 1, size, 1 do
      local y = dig_pos[2] + j - math.ceil(size/2)
      local x = dig_pos[1] + i - math.ceil(size/2)
      map[(y-1) % #map[1] + 1][(x-1) % #map + 1] = dig_tile
    end
  end
end

local timer = 0

function love.update(dt)
  if dig_queue_idx > #dig_queue then
    return
  end

  -- timer = timer + dt
  -- if timer < 0.5 then
  --   return
  -- end
  -- timer = 0

  if dig_energy > 0 then
    dig_energy = dig_energy - 1
    dig_rotate_after = dig_rotate_after - 1
    local next_pos = vec2_sum(dig_pos, dig_dir)
    local next_tile = map[(next_pos[2]-1) % #map[1] + 1][(next_pos[1]-1) % #map + 1]
    if next_tile ~= -1 then
      local angle = 1
      if love.math.random() > 0.5 then
        angle = -1
      end
      dig_dir = rotate_dir(dig_dir, angle)
    end
    dig_pos = next_pos

    map[(dig_pos[2]-1) % #map[1] + 1][(dig_pos[1]-1) % #map + 1] = dig_tile

    if dig_rotate_after < 0 then
      dig_rotate_after = love.math.random(6, 12)
      local angle = 1
      if love.math.random() > 0.5 then
        angle = -1
      end
      dig_dir = rotate_dir(dig_dir, angle)

      if #dig_queue < MAX_FORKS then
        if love.math.random() > 0.5 then
          table.insert(dig_queue, {dig_pos[1], dig_pos[2]})
        end
      end

      if love.math.random() > 0.7 then
        spawn_room()
      end
    end
  else
    dig_tile = {0, math.random(),  math.random()}
    dig_queue_idx = dig_queue_idx + 1
    dig_energy = love.math.random(20, 40)
    dig_pos = dig_queue[dig_queue_idx]
  end
end

function love.draw()
  for j = 1, MAP_HEIGHT, 1 do
    for i = 1, MAP_WIDTH, 1 do
      if map[j][i] ~= -1 then
        love.graphics.setColor(map[j][i])
        love.graphics.rectangle("fill", (i-1)*TW, (j-1)*TH, TW, TH)
      end
    end
  end
end