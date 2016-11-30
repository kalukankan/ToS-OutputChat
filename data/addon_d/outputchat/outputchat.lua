-- Globals
local addonPrefix = "ADDONS"
local addonName = "OutputChat"
local author = "kalukankan"
_G[addonPrefix] = _G[addonPrefix] or {}
_G[addonPrefix][author] = _G[addonPrefix][author] or {}
_G[addonPrefix][author][addonName] = _G[addonPrefix][author][addonName] or {}
local g = _G[addonPrefix][author][addonName]
g.hasLoaded = false
g.isOutputChat = true
g.logDir = "../addons/" .. addonName:lower() .. "/"
g.vanilla = {}
g.vanilla.Chat

-- Functions
function OUTPUTCHAT_ON_INIT(addon, frame)
	if g.hasLoaded then
		return
	end
	g.hasLoaded = true

	if not ui.Chat then
		g.vanilla.Chat = ui.Chat
		ui.Chat = g.AddonChat
	end

end

function g.AddonChat(msg)
	g.vanilla.Chat(msg)
	g.WriteLog(msg)
end

function g.WriteLog(msg)
	local f, errMsg = io.open(g.logDir .. addonName .. "_" .. os.date("%Y%m%d") .. ".log", "a+")
	if not f then
		g.vanilla.Chat("[" .. addonName .. "] ERROR! failed to open log file.\n" .. errMsg)
		return
	end
	f:write("[" .. os.date("%H:%M:%S") .. "]" .. msg .. "\n")
	f:close()
end

CHAT_SYSTEM("[" .. addonName .. "] loaded.")