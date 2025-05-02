-- Direction table to make direction more easily readable.
-- (For later, I will also make this table read-only for my
-- own learning experience)

local Direction = {
  -- Temporary STOP value to not crash the program.
  STOP  = {x = 0, y = 0},
  UP    = {x = 0, y = -1}, 
  DOWN  = {x = 0, y = 1}, 
  RIGHT = {x = 1, y = 0}, 
  LEFT  = {x = -1, y = 0}
}

return Direction