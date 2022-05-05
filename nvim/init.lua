for _, config in ipairs({ "options", "plugins", "keymap", "events" }) do
  require(config)
end
