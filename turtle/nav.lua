-- Define your home coordinates
local homeX, homeY, homeZ = 100, 64, 100  -- change these as needed

-- Assume the turtle initially faces North
local direction = 0  -- 0: North, 1: East, 2: South, 3: West

-- Function to turn the turtle so it faces a specific cardinal direction
local function face(targetDir)
  local diff = targetDir - direction
  -- Normalize the difference to fall between 0 and 3
  if diff < 0 then diff = diff + 4 end
  if diff == 1 then
    turtle.turnRight()
  elseif diff == 2 then
    turtle.turnRight()
    turtle.turnRight()
  elseif diff == 3 then
    turtle.turnLeft()
  end
  direction = targetDir
end

-- Function to move forward a specified number of blocks
local function moveForward(steps)
  for i = 1, steps do
    while not turtle.forward() do
      -- If forward movement fails (e.g., due to a temporary obstruction),
      -- wait and try again.
      sleep(0.5)
    end
  end
end

-- Function that uses the GPS to get current coordinates
local function getCurrentPosition()
  local x, y, z = gps.locate(5)  -- waits up to 5 seconds to get a fix
  if not x then
    error("GPS signal not found!")
  end
  return x, y, z
end

-- Main function to navigate to target coordinates
local function navigateTo(xTarget, yTarget, zTarget)
  local currentX, currentY, currentZ = getCurrentPosition()
  
  -- Calculate differences along X and Z axes
  local dx = xTarget - currentX
  local dz = zTarget - currentZ

  -- Move along the X-axis (east/west)
  if dx ~= 0 then
    local targetDir = dx > 0 and 1 or 3  -- east if positive, west if negative
    face(targetDir)
    moveForward(math.abs(dx))
  end

  -- Move along the Z-axis (north/south)
  if dz ~= 0 then
    local targetDir = dz > 0 and 2 or 0  -- south if positive, north if negative
    face(targetDir)
    moveForward(math.abs(dz))
  end
  
  -- Optionally, adjust Y (vertical) if needed on non-flat terrain
  if yTarget ~= currentY then
    local dy = yTarget - currentY
    if dy > 0 then
      for i = 1, dy do
        turtle.up()
      end
    else
      for i = 1, -dy do
        turtle.down()
      end
    end
  end
  
  print("Arrived at home!")
end

-- Navigate the turtle to the defined home coordinates
navigateTo(homeX, homeY, homeZ)