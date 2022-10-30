push = require 'push'

WINDOW_WIDTH = 512
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.jpg')
local backgroundScroll = 0
local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

-- all caps means constant
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60 -- make faster than background

-- loop image to get infinite effect
local BACKGROUND_LOOPING_POINT = 413

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Fifty Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- scroll background by preset speed * dt, looping back to 0 after looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT
    
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0) -- draw in top left corner

    -- subtract 16 since that's image height and we want to draw bottom left corner
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    push:finish()
end