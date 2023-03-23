local lib = require('lib')
local lerp_scene = require('lerp_scene')
local bezier3_scene = require('bezier3_scene')
local bezier4_scene = require('bezier4_scene')

function love.update(dt)
  lerp_scene.update(dt)
  bezier3_scene.update(dt)
  bezier4_scene.update(dt)
end

function love.draw()
  -- lerp_scene.draw()
  -- bezier3_scene.draw()
  bezier4_scene.draw()
end