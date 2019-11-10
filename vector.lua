Vector = {}
Vector.__index = Vector

function Vector:create(x, y)
    local vector = {}
    setmetatable(vector, Vector)
    vector.x = x
    vector.y = y
    return vector
end

function Vector:random(minx, maxx, miny, maxy)
    local x = 0
    while x == 0 do
        x = love.math.random(minx,maxx)
    end
    local y = love.math.random(miny,maxy)
    return Vector:create(x, y)
end

function Vector:__tostring()
    return "Vector(x= " .. self.x .. ",y = " .. self.y .. ")"
end

function Vector:__add(other)
    return Vector:create(self.x + other.x, self.y + other.y)
end

function Vector:__sub(other)
    return Vector:create(self.x - other.x, self.y - other.y)
end

function Vector:__mul(value)
    return Vector:create(self.x * value, self.y * value)
end

function Vector:__div(value)
    return Vector:create(self.x / value, self.y / value)
end

function Vector:mag()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector:norm()
    m = self:mag()
    return self / m 
end

function Vector:limit(max)
    if self:mag() > max then
        return self:norm() * max
    end
    return self
end