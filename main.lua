require("ball")
require("barrier")
require("vector")

function love.load()
    gameover_sound = love.audio.newSource("resources/gameover.wav", "static")
    victory_sound = love.audio.newSource("resources/victory.wav", "static")
    play_sound = true

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    love.graphics.setBackgroundColor(0/255, 0/255, 0/255)
    font_name = "resources/AtariClassic-Regular.ttf"
    font_small = love.graphics.newFont(font_name, 12)
    font_label = love.graphics.newFont(font_name, 28)

    player_score_left = 0;
    player_score_right = 0;

    greeting_status = false
    game_status = false

    ball = Ball:create(Vector:create(width/2,height/2), Vector:create(0,0))

    barrier_left = Barrier:create(Vector:create(52,305), Vector:create(0,0))
    barrier_right = Barrier:create(Vector:create(1072,305), Vector:create(0,0))
end

function love.draw()
    if greeting_status then
        love.graphics.line(567, 60, 567, 660)
        love.graphics.rectangle("line", 32, 60, 1070, 600)
        
        love.graphics.setFont(font_label)
        love.graphics.print(tostring(player_score_left), 517, 15)
        love.graphics.print(tostring(player_score_right), 593, 15)

        love.graphics.setFont(font_small)
        love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 1015, 20)

        barrier_left:draw()
        barrier_right:draw()
        
        if player_score_left >= 9 then
            if play_sound then
                victory_sound:play()
                play_sound = false
            end
            love.graphics.setFont(font_label)            
            love.graphics.print("Victory!", 450, 220)
            love.graphics.print("Press any button to start over!", 160, 300)
        elseif player_score_right >= 9 then
            if play_sound then
                gameover_sound:play()
                play_sound = false
            end
            love.graphics.setFont(font_label)
            love.graphics.print("Game over!", 435, 220)
            love.graphics.print("Press any button to start over!", 160, 300)
        end

        ball:draw()
        
    else
        love.graphics.setFont(font_label)
        love.graphics.print("Pong Game", 435, 220)
        love.graphics.print("Press any button to play!", 220, 300)
    end

end

function love.update(dt)
    if player_score_left < 9 and player_score_right < 9 then
        barrier_left:update()
        barrier_right:update()
        barrier_right:auto_control(ball)
        ball:update()
    end
end


function love.keypressed(key)
    if greeting_status then
       if game_status then
            if key == "up" then
                barrier_left.velocity = Vector:create(0, -4)
            elseif key == "down" then
                barrier_left.velocity = Vector:create(0, 4)
            end
       else
            if player_score_left >= 9 or player_score_right >= 9 then
                player_score_left = 0
                player_score_right = 0
                play_sound = true
            end

            if key == "space" then
                local x = love.math.random(0.8,1)
                local y = love.math.random(0.8,1)

                local sign = love.math.random(-1,1)
                if sign < 0 then
                    x = x * -1
                end

                sign = love.math.random(-1,1)
                if sign < 0 then
                    y = y * -1
                end
                
                ball.velocity = Vector:create(x, y)
                game_status = true
            end
       end
    else
        greeting_status = true;
    end
end

function love.keyreleased(key)
    if game_status then
        barrier_left.velocity = Vector:create(0, 0)
    end
end