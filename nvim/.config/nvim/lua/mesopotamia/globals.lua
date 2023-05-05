P = function(thing)
  vim.print(thing)
  return thing
end

RELOAD = function(p)
  package.loaded[p] = nil
  return require(p)
end
