local lib = require('lib')
local lerp_scene = require('lerp_scene')
local bezier2_scene = require('bezier2_scene')
local bezier3_scene = require('bezier3_scene')
local catmull_scene = require('catmull_scene')

function love.update(dt)
  -- lerp_scene.update(dt)
  -- bezier2_scene.update(dt)
  -- bezier3_scene.update(dt)
  catmull_scene.update(dt)
end

function love.draw()
  -- lerp_scene.draw()
  -- bezier2_scene.draw()
  -- bezier3_scene.draw()
  catmull_scene.draw()
end