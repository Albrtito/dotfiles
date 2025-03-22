local theme = os.getenv("THEME")

local function loadFromFile(filename)
	local chunk, err = loadfile(filename)
	if not chunk then
		error("Error loading file: " .. (err or "unknown error"))
		return nil
	end

	local success, result = pcall(chunk)
	if not success then
		error("Error executing file: " .. (result or "unknown error"))
		return nil
	end

	return result
end

local themes_path = vim.fn.stdpath("config") .. "/lua/plugins/themes/"
if theme == "catppuccin" then
    print("Theme: Catppuccin")
	return loadFromFile(themes_path .. "catppuccin.lua")
elseif theme == "kanagawa" then
    print("Theme: Kanagawa")
	return loadFromFile(themes_path .. "kanagawa.lua")
else
    print("Theme not found, using default theme")
	return loadFromFile(themes_path .. "catppuccin.lua")
end
