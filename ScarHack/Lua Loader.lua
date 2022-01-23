-- lua loader by gorenz / alternative loader in ScarSploit
local env = getgenv()
env.sh = {
	key = "YOURKEYHERE",
	isR6 = false,
	features = {
		external_executor = false
	}
}
loadstring(game:HttpGet("https://github.com/scar17off/Roblox-Scripts/raw/main/ScarHack/ScarHack.lua"))()
