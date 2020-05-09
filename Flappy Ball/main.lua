Class = require 'class'
require 'Pipes'

player_x = 200
player_y = 100
player_jump = 15
gravity = 10

speed_mult = 1
total_pipes = 1
time_elasped = 0
jump_time = 0
score = 0
spawn_time = 0
spawn_rate = 1
spawn_x = 0
spawn_y = 0

game_over = false

pipes = {}

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Flappy ball')
	math.randomseed(os.time())
	table.insert(pipes, Pipes(700 ,300, 3))
end

function love.update(dt)
	if (game_over == false) then
		player_control(dt)
		pipe_gen(dt)
		time_elasped = time_elasped + (dt * 1)
		Score = math.floor(time_elasped + ((spawn_rate * total_pipes))/10)
	
		for i, Pipes in pairs(pipes) do
			Pipes:update()
			if(Pipes.x_cord <= -100)then
				table.remove(pipes, i)
			end
			if (Pipes:Collision_check(player_x, player_y) == true) then
				game_over = true
			end
		end
		if (player_y > 500) then
			game_over = true
		end
	end
end

function love.draw()	
	if (game_over == false) then
		for i, Pipes in pairs(pipes) do
			Pipes:draw() 
		end
		love.graphics.setColor(1,1,1)
		love.graphics.circle("fill", player_x, player_y, 4)
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill",0,0,50,600)
		love.graphics.rectangle("fill",750,0,50,600)
		love.graphics.rectangle("fill",0,500,800,100)
		love.graphics.setColor(1,1,1)
		love.graphics.polygon("line", 50, 0, 750, 0, 750, 500, 50, 500)
		love.graphics.print('Score: ' .. Score, 375, 575)	
	else
		love.graphics.print('Your Score: ' .. Score, 395, 295)	
		love.graphics.print('Press Esc to quit', 395, 310)
	end
end

function custom_random(min_val, max_val, interval)
	math.randomseed(os.time())
	max_mult = (max_val - min_val)/interval
	return_val = min_val + ((math.random(max_mult) - 1) * interval)
	return return_val
end

function love.keypressed(key)
	if(key == "escape") then
		love.event.quit()
	end
	
	if (game_over == false) then
		if (key == "space") then
			gravity = -25
			jump_time = 0
		end
	end
end

function pipe_gen(delta_time)
	spawn_time = spawn_time + (spawn_rate * delta_time)
	if (spawn_time >=3) then
		spawn_time = 0
		total_pipes = total_pipes + 1
		if(spawn_rate < 2.5) then
			first_phase()
		elseif (spawn_rate>= 2.5) and (spawn_rate < 5) then
			second_phase()
		else
			spawn_rate = 7.5
			spawn_time = -2
			third_phase()
		end
	end
end

function first_phase()
	spawn_x = custom_random(750, 800, 10)
	spawn_y = custom_random(0, 200, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 2))
	
	spawn_x = custom_random(750, 800, 10)
	spawn_y = custom_random(200, 440, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3 * speed_mult))
	
	spawn_x = custom_random(950, 1000, 10)
	spawn_y = custom_random(50, 400, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3))
	
	spawn_x = custom_random(950, 1000, 10)
	spawn_y = custom_random(350, 470, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3 * speed_mult))
	
	spawn_rate = spawn_rate * 1.05
end

function second_phase()
	spawn_x = custom_random(800, 900, 10)
	spawn_y = custom_random(0, 220, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 4))
	
	spawn_x = custom_random(800, 900, 10)
	spawn_y = custom_random(220, 440, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3.8))
	
	spawn_x = custom_random(800, 900, 10)
	spawn_y = custom_random(0, 480, 50)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 4))
	
	spawn_x = custom_random(800, 900, 10)
	spawn_y = custom_random(10, 440, 70)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3.8))
	
	spawn_rate = spawn_rate * 1.03
end

function third_phase()
	
	spawn_x = custom_random(850, 900, 10)
	spawn_y = custom_random(0, 200, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 2 * speed_mult))
	
	spawn_x = custom_random(880, 900, 10)
	spawn_y = custom_random(80, 400, 20)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 4 * speed_mult))
	
	spawn_x = custom_random(800, 900, 10)
	spawn_y = custom_random(260, 440, 20)		
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3 * speed_mult))
	
	spawn_x = custom_random(880, 900, 10)
	spawn_y = custom_random(40, 470, 30)	
	table.insert(pipes, Pipes(spawn_x ,spawn_y, 3 * speed_mult))
	
	speed_mult = speed_mult + 0.007
end

function player_control(delta_time)
	if (gravity < 0) then
		gravity = gravity + 15/6	
	else
		gravity = gravity + 15/11
	end
	player_y = player_y + math.floor((1 * gravity)/6)
	player_y = math.max(0, player_y)
end
