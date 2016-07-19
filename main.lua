class = require 'middleclass.middleclass'

lines = {}

Line = class('Line')

function Line:initialize(x, y, xspeed, yspeed, scale, generation)
    self.sx = x
    self.sy = y
    self.ex = x
    self.ey = y
    self.xspeed = xspeed
    self.yspeed = yspeed
    if scale < 2 then
        self.scale = 10*scale
    else
        self.scale = scale
    end
    self.lifetime = love.math.random()
    self.generation = generation
end

function Line:respawn(direction)
    if direction == 1 then
        table.insert(lines, Line:new(self.ex, self.ey, self.yspeed*love.math.random()+0.1, self.xspeed*love.math.random()*2+0.1, self.scale*love.math.random()*1.1, self.generation+1))
    elseif direction == 2 then
        table.insert(lines, Line:new(self.ex, self.ey, self.yspeed*love.math.random()+0.1, -self.xspeed*love.math.random()*2+0.1, self.scale*love.math.random()*1.1, self.generation+1))
    elseif direction == 3 then
        table.insert(lines, Line:new(self.ex, self.ey, -self.yspeed*love.math.random()+0.1, self.xspeed*love.math.random()*2+0.1, self.scale*love.math.random()*1.1, self.generation+1))
    elseif direction == 4 then
        table.insert(lines, Line:new(self.ex, self.ey, -self.yspeed*love.math.random()+0.1, -self.xspeed*love.math.random()*2+0.1, self.scale*love.math.random()*1.1, self.generation+1))
    end
end

function Line:update(dt)
    if self.lifetime > 0 then
        self.lifetime = self.lifetime - dt
        self.ex = self.ex + self.xspeed*dt
        self.ey = self.ey + self.yspeed*dt
        if self.lifetime <= 0 then
            self:respawn(love.math.random(4))
            self:respawn(love.math.random(4))
        end
    else

    end
end

table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 100, 0, 10, 1))
table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, -100, 0, 10, 1))
table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 100, 10, 1))
table.insert(lines, Line:new(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, -100, 10, 1))

function love.update(dt)
    for k, v in pairs(lines) do
        v:update(dt)
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    for k, v in pairs(lines) do
        love.graphics.setLineWidth(v.scale)
        love.graphics.line(v.sx, v.sy, v.ex, v.ey)
        if v.lifetime <= 0 then
            table.remove(lines, k)
        end
    end
end

function love.run()
    love.math.setRandomSeed(os.time())
    love.timer.step()
    local dt = 0
    while true do
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a
                    end
                    love.handlers[name](a,b,c,d,e,f)
                end
            end
        end
        love.timer.step()
        dt = love.timer.getDelta()
        love.update(dt)
        love.graphics.origin()
        love.draw()
        love.graphics.present()
        love.timer.sleep(0.001)
    end
end