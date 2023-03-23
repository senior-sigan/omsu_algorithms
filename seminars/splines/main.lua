local lib = require('lib')
local lerp_scene = require('lerp_scene')

function love.update(dt)
  lerp_scene.update(dt)
end

function love.draw()
  lerp_scene.draw()
end