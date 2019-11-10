Barrier = {}
Barrier.__index = Barrier

function Barrier:create(location, velocity)
    local barrier = {}
    setmetatable(barrier, Barrier)
    barrier.velocity = velocity
    barrier.location = location
    barrier.height = 120
    barrier.width = 10
    return barrier
end

function Barrier:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.width, self.height)
end

function Barrier:update()
    top = 660
    bottom = 60
    if self.location.y > top - self.height then
        self.location.y = top - self.height
    elseif self.location.y < bottom then
        self.location.y = bottom
    else
        self.location = self.location + self.velocity
    end
end

function Barrier:auto_control(ball)
    if ball.location.x > width/2 then
        if ball.location.y + 200 - (player_score_left * 10) > self.location.y-60 then
            self.velocity.y = 4;
        end
        if ball.location.y - 200 + (player_score_left * 10) < self.location.y-60 then
            self.velocity.y = -4;
        end
    end
end