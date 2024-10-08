local config_path = vim.fn.stdpath("config")
local colors_path = config_path .. "/colors/turbovision/turboc/init.lua"

-- Add the path to package.path
if not string.find(package.path, colors_path) then
	package.path = package.path .. ";" .. colors_path
end

require("turboc.init").loadcolors({ ["mode"] = "base" })
