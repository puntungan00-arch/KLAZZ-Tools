-- KLAZZ IMPORTER GUI v6 - MINIMIZE + TEMA
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- LOAD SAVEINSTANCE
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/7granddadPGN.github.io/main/saveinstance.lua"))()

-- SAVE DATA
local SAVE_FILE = "KLAZZ_Importer_Save.json"
local savedData = {history = {}, preset = "", theme = "dark"}
if isfile and isfile(SAVE_FILE) then
	local success, data = pcall(function() return HttpService:JSONDecode(readfile(SAVE_FILE)) end)
	if success then savedData = data end
end
local function SaveData() if writefile then writefile(SAVE_FILE, HttpService:JSONEncode(savedData)) end
local function AddHistory(link)
	if link == "" then return end
	for i,v in ipairs(savedData.history) do if v == link then table.remove(savedData.history, i) end end
	table.insert(savedData.history, 1, link)
	if #savedData.history > 5 then table.remove(savedData.history) end
	SaveData()
end

-- TEMA
local Themes = {
	dark = {bg=Color3.fromRGB(15,15,15), top=Color3.fromRGB(25,25,25), text=Color3.new(1,1,1), accent=Color3.fromRGB(255,215,0)},
	light = {bg=Color3.fromRGB(240,240,240), top=Color3.fromRGB(220,220,220), text=Color3.fromRGB(20,20,20), accent=Color3.fromRGB(255,140,0)}
}
local currentTheme = Themes[savedData.theme or "dark"]

-- GUI UTAMA
local gui = Instance.new("ScreenGui")
gui.Name = "KLAZZ_Importer"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,330,0,280)
frame.Position = UDim2.new(0.5,-165,0.5,-140)
frame.BackgroundColor3 = currentTheme.bg
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-120,0,35)
title.Text = "👑 KLAZZ IMPORTER"
title.TextColor3 = currentTheme.accent
title.BackgroundColor3 = currentTheme.top
title.Font = Enum.Font.GothamBold
title.Parent = frame

local themeBtn = Instance.new("TextButton") -- TOMBOL TEMA
themeBtn.Size = UDim2.new(0,35,0,35)
themeBtn.Position = UDim2.new(1,-80,0,0)
themeBtn.Text = "🌙"
themeBtn.BackgroundColor3 = currentTheme.top
themeBtn.Parent = frame

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0,40,0,35)
clearBtn.Position = UDim2.new(1,-120,0,0)
clearBtn.Text = "🗑️"
clearBtn.BackgroundColor3 = currentTheme.top
clearBtn.Parent = frame

local miniBtn = Instance.new("TextButton") -- TOMBOL MINIMIZE
miniBtn.Size = UDim2.new(0,35,0,35)
miniBtn.Position = UDim2.new(1,-40,0,0)
miniBtn.Text = "_"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.BackgroundColor3 = currentTheme.top
miniBtn.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1,-20,0,35)
box.Position = UDim2.new(0,10,0,45)
box.PlaceholderText = "Paste Link RBXM atau Nama File"
box.Text = savedData.history[1] or ""
box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.TextColor3 = currentTheme.text
box.Parent = frame

local dropBtn = Instance.new("TextButton")
dropBtn.Size = UDim2.new(0,25,0,35)
dropBtn.Position = UDim2.new(1,-30,0,45)
dropBtn.Text = "▼"
dropBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
dropBtn.Parent = frame

local dropList = Instance.new("Frame")
dropList.Size = UDim2.new(1,-20,0,0)
dropList.Position = UDim2.new(0,10,0,80)
dropList.BackgroundColor3 = currentTheme.top
dropList.Visible = false
dropList.ZIndex = 2
dropList.Parent = frame

local presetBox = Instance.new("TextBox")
presetBox.Size = UDim2.new(1,-20,0,25)
presetBox.Position = UDim2.new(0,10,0,85)
presetBox.PlaceholderText = "Folder Preset: KLAZZ_Presets/"
presetBox.Text = savedData.preset or ""
presetBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
presetBox.TextColor3 = currentTheme.accent
presetBox.Parent = frame

local btnLink = Instance.new("TextButton")
btnLink.Size = UDim2.new(0.5,-12,0,45)
btnLink.Position = UDim2.new(0,10,0,170)
btnLink.Text = "Import Link"
btnLink.BackgroundColor3 = Color3.fromRGB(255,0,0)
btnLink.TextColor3 = Color3.new(1,1,1)
btnLink.Font = Enum.Font.GothamBold
btnLink.Parent = frame

local btnFile = Instance.new("TextButton")
btnFile.Size = UDim2.new(0.5,-12,0,45)
btnFile.Position = UDim2.new(0.5,2,0,170)
btnFile.Text = "Import File"
btnFile.BackgroundColor3 = Color3.fromRGB(0,100,255)
btnFile.TextColor3 = Color3.new(1,1,1)
btnFile.Font = Enum.Font.GothamBold
btnFile.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,-20,0,30)
status.Position = UDim2.new(0,10,0,225)
status.Text = "Status: Idle | K = sembunyi"
status.TextColor3 = currentTheme.text
status.BackgroundTransparency = 1
status.TextScaled = true
status.Parent = frame

local minimized = false
local originalSize = frame.Size

-- FUNGSI UPDATE TEMA
local function UpdateTheme()
	currentTheme = Themes[savedData.theme]
	frame.BackgroundColor3 = currentTheme.bg
	title.BackgroundColor3 = currentTheme.top
	title.TextColor3 = currentTheme.accent
	themeBtn.BackgroundColor3 = currentTheme.top
	clearBtn.BackgroundColor3 = currentTheme.top
	miniBtn.BackgroundColor3 = currentTheme.top
	box.TextColor3 = currentTheme.text
	status.TextColor3 = currentTheme.text
	presetBox.TextColor3 = currentTheme.accent
	themeBtn.Text = savedData.theme == "dark" and "🌙" or "☀️"
end

local function ImportFromData(data)
	status.Text = "Status: Importing..."
	TweenService:Create(status, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	local success, err = pcall(function() SaveInstance(data, workspace) end)
	status.Text = success and "Status: Berhasil!" or "Status: Gagal - "..err
	task.wait(2)
	status.Text = "Status: Idle | K = sembunyi"
end

-- EVENTS
themeBtn.MouseButton1Click:Connect(function()
	savedData.theme = savedData.theme == "dark" and "light" or "dark"
	SaveData()
	UpdateTheme()
end)

miniBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local tween = TweenService:Create(frame, TweenInfo.new(0.3), {Size = minimized and UDim2.new(0,330,0,35) or originalSize})
	tween:Play()
	for _,v in pairs(frame:GetChildren()) do
		if v ~= title and v ~= miniBtn and v ~= themeBtn and v ~= clearBtn then
			v.Visible = not minimized
		end
	end
end)

clearBtn.MouseButton1Click:Connect(function()
	savedData.history = {}
	SaveData()
	status.Text = "Status: History Dihapus"
end)

presetBox.FocusLost:Connect(function()
	savedData.preset = presetBox.Text
	SaveData()
end)

dropBtn.MouseButton1Click:Connect(function()
	dropList.Visible = not dropList.Visible
	dropList:ClearAllChildren()
	local y = 0
	for _,link in ipairs(savedData.history) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1,0,0,25)
		btn.Position = UDim2.new(0,0,0,y)
		btn.Text = link
		btn.TextScaled = true
		btn.TextColor3 = currentTheme.text
		btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
		btn.ZIndex = 2
		btn.Parent = dropList
		btn.MouseButton1Click:Connect(function() box.Text = link dropList.Visible = false end)
		y = y + 25
	end
	dropList.Size = UDim2.new(1,-20,0,y)
end)

btnLink.MouseButton1Click:Connect(function()
	local url = box.Text
	if url == "" then return end
	AddHistory(url)
	status.Text = "Status: Downloading..."
	local success, data = pcall(function() return game:HttpGet(url, true) end)
	success and ImportFromData(data) or status.Text = "Status: Gagal Download"
end)

btnFile.MouseButton1Click:Connect(function()
	local filename = box.Text
	if filename == "" then return end
	if not readfile then return status.Text = "Status: Ga support readfile" end
	local folder = presetBox.Text ~= "" and presetBox.Text or "KLAZZ_Presets/"
	status.Text = "Status: Baca File..."
	local success, data = pcall(function() return readfile(folder..filename..".rbxm") end)
	success and ImportFromData(data) or status.Text = "Status: File ga ketemu"
end)

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.K then gui.Enabled = not gui.Enabled end
end)
