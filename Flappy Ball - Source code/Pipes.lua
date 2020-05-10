Pipes = Class{}

function Pipes:init(pipe_x, pipe_y, speed)
	math.randomseed(os.time())
	self.x_cord = pipe_x
	self.y_cord = pipe_y	
	self.width = 80
	self.height = 20
	self.speed = speed
	self.collided = false
end

function Pipes: update()
	self.x_cord = self.x_cord - self.speed 
end

function Pipes:draw()
	if (self.collided == false) then
		love.graphics.setColor(0.85,0.85,0.85)
	else
		love.graphics.setColor(1,0,0)
	end
	love.graphics.rectangle("fill", self.x_cord, self.y_cord, self.width, self.height)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("line", self.x_cord, self.y_cord, self.width, self.height)
end


function Pipes:Collision_check(x,y)
	if (self.x_cord <= x + 4) and (self.x_cord + self.width >= x - 4) and 
	   (self.y_cord + self.height >= y + 4) and (self.y_cord <= y - 4) then	
		self.collided = true
		return true   
	end
end
