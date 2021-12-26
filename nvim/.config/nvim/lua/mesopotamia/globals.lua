P = function(thing)
  print(vim.inspect(thing))
  return thing
end

RELOAD = function(p)
  package.loaded[p] = nil
  return require(p)
end
