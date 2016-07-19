class = require 'middleclass.middleclass'

lines = {}

Line = class('Line')

function Line:initialize(x, y, xspeed, yspeed)
    self.sx = x
    self.sy = y
    self.ex = x
    self.ey = y
    self.xspeed = xspeed
    self.yspeed = yspeed
end

function Line:update(dt)
    self.ex = self.ex + self.xspeed*dt
    self.ey = self.ey + self.yspeed*dt
end

function love.load()
    table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 10, 0))
    table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, -10, 0))
    table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 10))
    table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, -10))
end

function love.update(dt)
    for k, v in pairs(lines) do
        v:update(dt)
    end
end

function love.draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255, 255, 255)
    for k, v in pairs(lines) do
        love.graphics.line(v.sx, v.sy, v.ex, v.ey)
    end
end