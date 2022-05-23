P = function(thing)
  vim.pretty_print(thing)
  return thing
end

RELOAD = function(p)
  package.loaded[p] = nil
  return require(p)
end
