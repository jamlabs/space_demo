--main.lua

-- data pool
require("playerResearch");
require("libraries/camera");
require("ingameMenu");

--shortenings
lg,le,lk, lt = love.graphics, love.event, love.keyboard, love.timer;

local tuxi = lg.newImage("tux.png");
function love.load()
	playerResearch_load();
  ingameMenu_load();
end
function love.update(dt)
  if not ingameMenuOpen then playerResearch_movement(); end
  collectgarbage(collect);
end
function love.draw() 
  camera:set();
  lg.draw(tuxi, lg.getWidth()/2, lg.getHeight()/2, 0, 1, 1);
 
  playerResearch_draw();
  camera:unset();
 
 ingameMenu_draw();
 debug_draw();
end
function love.focus(f) 
  ingameMenu_focus(f);
end
function love.keyreleased(key) 
	if key == 'q' then le.quit(); end
	playerResearch_keyreleased(key);
  ingameMenu_keyreleased(key);
end
