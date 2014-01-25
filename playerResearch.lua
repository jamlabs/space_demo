--playerResearch.lua

function playerResearch_load()
	flying, boostActive, f1released, uiOut = false, false, false, false;
	f1releasedCount, uiOutReleasedCount = 0, 0;
	ui = { bordcomputer =  lg.newImage("assets/playerships/bordcomputer1.png") };
	logo = lg.newImage("assets/playerships/playerResearch.png");
  width, windoWidth, height, windowHeight = logo:getWidth(), lg.getHeight(), logo:getHeight(), lg.getHeight();
	mainShipResearch = {boost = 5, boostSpeed=10,x = 400, y = 300, vy=0,vx=0, rotation = math.rad(.0), rotationAdjust = math.rad(math.pi/3),
		surp=7.5, fric = .99, factor=22.25}
end
function playerResearch_movement()
	dt = lt.getDelta();
	--move spaceship (surp decreases vx/y)
	mainShipResearch.x = mainShipResearch.x + mainShipResearch.vx/mainShipResearch.surp; 
	mainShipResearch.y = mainShipResearch.y + mainShipResearch.vy/mainShipResearch.surp;
 
  mainShipResearch.vx = mainShipResearch.vx* (1 - math.min(mainShipResearch.fric*dt, 1));
  mainShipResearch.vy = mainShipResearch.vy* (1 - math.min(mainShipResearch.fric*dt, 1));
 
 if (lk.isDown("w") or  lk.isDown("up")) then
    mainShipResearch.vx = math.cos(mainShipResearch.rotation)* mainShipResearch.factor;
	  mainShipResearch.vy = math.sin(mainShipResearch.rotation)* mainShipResearch.factor;
 end        
  if lk.isDown("d") or lk.isDown("right") then
		mainShipResearch.rotation = mainShipResearch.rotation + mainShipResearch.rotationAdjust; -- adjust rot about rad(pi/2) depending on dir 
  end
	if lk.isDown("a") or lk.isDown("left") then 
    mainShipResearch.rotation = mainShipResearch.rotation - mainShipResearch.rotationAdjust; 
   end   
	if lk.isDown(" ") then  -- implement fuel some time in the near future
    mainShipResearch.vx = math.cos(mainShipResearch.rotation)*mainShipResearch.factor*3; 
	 	mainShipResearch.vy = math.sin(mainShipResearch.rotation)*mainShipResearch.factor*3;
		boostActive =  true; 
	elseif mainShipResearch.vx < math.cos(mainShipResearch.rotation)*mainShipResearch.factor*1.01 or mainShipResearch.vy < math.sin(mainShipResearch.rotation)*mainShipResearch.factor*1.01 then 
		boostActive = false;
	end
	if ((mainShipResearch.vx > 1 or mainShipResearch.vx < -1) or (mainShipResearch.vy < -1 or mainShipResearch.vy > 1)) then flying=true; else flying=false; end
  
  -- focus on the player (camera)
  if mainShipResearch.x > lg.getWidth()/2 then camera._x = mainShipResearch.x - lg.getWidth()/2; 
  elseif mainShipResearch.x < lg.getWidth()/2 then camera._x = mainShipResearch.x - lg.getWidth()/2; end 
  if mainShipResearch.y > lg.getHeight()/2 then camera._y = mainShipResearch.y - lg.getHeight()/2;
  elseif mainShipResearch.y < lg.getHeight()/2 then camera._y = mainShipResearch.y - lg.getHeight()/2; end
end
function playerResearch_collide(dt)
end
function playerResearch_keyreleased(key)
	if key == 'f1' then f1released = true; f1releasedCount = f1releasedCount + 1;
		if f1releasedCount == 2 then f1released = false; f1releasedCount = f1releasedCount - 2; end
	end
	if key == 'lctrl' or key == 'rctrl' then uiOut = true; uiOutReleasedCount = uiOutReleasedCount + 1;
		if uiOutReleasedCount == 2 then uiOut = false; uiOutReleasedCount = uiOutReleasedCount - 2; end
	end
end
-- make a seperate debug file for this
function debug_draw()
  if uiOut then table.remove(ui, bordcomputer); 
	elseif not uiOut then lg.draw(ui.bordcomputer,0 , windowHeight-75.25, 0, 1, 1); end
	if f1released then 
		lg.print("Debug: space_demo(JUN)", 0, 0);
		lg.print("actRot: " .. mainShipResearch.rotation, 0, 12.5);
		lg.print("rotAngle: " .. math.deg(mainShipResearch.rotation), 0, 25);
		lg.print("dRot: " .. math.abs(mainShipResearch.rotationAdjust), 0, 37.5);
		lg.print("Flying: " .. tostring(flying), 0, 50);
		lg.print("Velocity:", 0, 62.5);
		lg.print("xVel: " .. mainShipResearch.vx, 0, 75); --testing velocity state condition without math.floor 
		lg.print("yVel: " .. mainShipResearch.vy, 0, 87.5);
		lg.print("boostActive: " .. tostring(boostActive), 0, 100);
		lg.print("f1 released: " .. tostring(f1released), 0, 112.5);
		lg.print("UI inactive: " .. tostring(uiOut), 0, 125);
	end
end
function playerResearch_draw()
	lg.draw(logo, mainShipResearch.x, mainShipResearch.y, mainShipResearch.rotation, 0.5, 0.5, width/2, height/2);
end
