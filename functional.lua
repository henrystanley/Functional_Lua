module(..., package.seeall)

-----------------------
-- Utility Functions --
-----------------------


-- Returns copy of object --
function clone(x)
  if type(x) ~= "table" then return x
  else 
    local copy = {}
    for i, v in ipairs(x) do
      copy[i] = v
    end
    return copy
  end
end

-- Pretty print --
function show(x)
  if type(x) ~= "table" then return x end
  str = "{ "
  for i, v in ipairs(x) do
    str = str .. show(v) .. " "
  end
  str = str .. "}"
  return str
end

--------------------
-- List Functions --
--------------------


-- Returns first item of list (i.e. number indexed table) --
function head(xs)
  return xs[1]
end


-- Returns rest of list, minus first element --
function tail(xs)
  local temp_xs = clone(xs)
  table.remove(temp_xs, 1)
  return temp_xs
end


-- Combines two objects into one list (similar to "cons", "++", and ":") --
function glue(x, y)
  local temp_x = clone(x)
  local temp_y = clone(y)
  if type(temp_x) ~= "table" then temp_x = {temp_x} end
  if type(temp_y) ~= "table" then temp_y = {temp_y} end
  for i, v in ipairs(temp_y) do
    table.insert(temp_x, v)
  end
  return temp_x
end


-- Determines if list includes value --
function includes(xs, x)
  for i, v in ipairs(xs) do
    if v == x then return true end
  end
  return false
end

----------------------------
-- Higher Order Functions --
----------------------------


-- Maps function over table of values (leaves original table alone) --
function map(f, xs)
  local temp_xs = {}
  for i, v in ipairs(xs) do
    temp_xs[i] = f(v)
  end
  return temp_xs
end


-- Same as map, but destructive (maps over original table) --
function dest_map(f, xs)
  for i, v in ipairs(xs) do
    xs[i] = f(v)
  end
end


-- Folds function over list (foldr) --
function fold(f, x, xs)
  local seed_value = x
  for i, v in ipairs(xs) do
    seed_value = f(seed_value, v)
  end
  return seed_value
end


-- Filters list by boolean function --
function filter(f, xs)
  local filtered = {}
  for i, v in ipairs(xs) do
    if f(v) then table.insert(filtered, v) end
  end
  return filtered
end  
  
  
-- Partially applies f to first arg x --
function par(f, x)
  return function(...) return f(x, ...) end
end


-- Composes two functions --
function comp(f1, f2)
  return function(...) return f1(f2(...)) end
end
