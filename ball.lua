Ball = {}
Ball.__index = Ball

function Ball:create(location, velocity)
    local ball = {}
    setmetatable(ball, Ball)
    ball.velocity = velocity
    ball.location = location
    ball.size = 14
    ball.sound = love.audio.newSource("resources/pong.wav", "static")
    ball.recaptured = 0
    return ball
end

function Ball:draw()
    love.graphics.circle("fill", self.location.x, self.location.y, 10)
end

function Ball:check_borders(top, right, bottom, left)

    if self.location.x <= left then
        self.sound:play()
        player_score_right = player_score_right + 1;
        self.location = Vector:create(width/2,height/2)
        self.velocity = Vector:create(0,0)
        game_status = false;
        self.recaptured = 0
    end

    if self.location.x >= right - self.size then
        self.sound:play()
        player_score_left = player_score_left + 1
        self.location = Vector:create(width/2,height/2)
        self.velocity = Vector:create(0,0)
        game_status = false;
        self.recaptured = 0
    end

    if self.location.y <= top or self.location.y >= bottom - self.size then
        self.sound:play()
        self.velocity.y = self.velocity.y * -1
    end
end

function Ball:update()

    if self.location.x > barrier_right.location.x and
    self.location.x < barrier_right.location.x + barrier_right.width + 30 and
    self.location.y > barrier_right.location.y and 
    self.location.y < barrier_right.location.y + barrier_right.height then
        self.sound:play()
        self.location.x = barrier_right.location.x
        self.velocity.x = - self.velocity.x
        self.recaptured = self.recaptured + 1
    end

    if self.location.x < barrier_left.location.x + barrier_left.width and
    self.location.x > barrier_left.location.x and
    self.location.y > barrier_left.location.y and 
    self.location.y < barrier_left.location.y + barrier_left.height then
        self.sound:play()
        self.location.x = barrier_left.location.x + barrier_left.width
        self.velocity.x = - self.velocity.x
        self.recaptured = self.recaptured + 1
    end

    self.location = self.location + self.velocity * (3 + player_score_right*0.2 + player_score_left*0.1 + self.recaptured * 0.1)
    ball:check_borders(70, 1100, 660, 40)
end

