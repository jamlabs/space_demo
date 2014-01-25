--ingameMenu.lua

function ingameMenu_load()
  ingameMenuOpen = false;
end
function ingameMenu_focus(f)
  if not f then ingameMenuOpen = true;
  else ingameMenuOpen = false; end
end
function ingameMenu_keyreleased(key)
  if key == 'p' then ingameMenuOpen = not ingameMenuOpen; end -- pause game
end
function ingameMenu_draw()
  if ingameMenuOpen then lg.rectangle('line', lg.getWidth()/2-50, 0, 125, 275); end --draw ingame menu
end

