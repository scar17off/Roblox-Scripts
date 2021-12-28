-- lua loader by gorenz / alternative loader in ScarSploit
local env = getgenv()
env.scarhack = {}
env.scarhack.key = "YOURKEYHERE"
loadstring(game:HttpGet("https://github.com/scar17off/Roblox-Scripts/raw/main/ScarHack/ScarHack.lua"))()
