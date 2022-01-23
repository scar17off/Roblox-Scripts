-- lua loader by gorenz / alternative loader in ScarSploit
local env = getgenv()
env.sh = {
	key = "YOURKEYHERE",
	isR6 = false,
	tabs = {
		"FE" = true,
		"Aimbot" = false,
		"Visuals" = true,
		"Misc" = true,
		"Fun" = false,
		"HvH" = false
		"Settings" = true
	}
}
loadstring(game:HttpGet("https://github.com/scar17off/Roblox-Scripts/raw/main/ScarHack/ScarHack.lua"))()
