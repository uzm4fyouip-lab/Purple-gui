local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local IMAGE_ID = "rbxassetid://0"
local speed, spinSpeed, ballSpeed = 16, 100, 95
local selectedVoteSlot, selectedHouseIndex = 1, 1
local currentLang, currentThemeIndex = "EN", 1

local THEMES = {
	{Name="PURPLE", Bg=Color3.fromRGB(29,13,46), Hdr=Color3.fromRGB(65,29,100), Btn=Color3.fromRGB(105,45,165), On=Color3.fromRGB(155,75,220), Acc=Color3.fromRGB(195,125,255), Txt=Color3.fromRGB(255,255,255), Trk=Color3.fromRGB(65,40,85)},
	{Name="MIDNIGHT", Bg=Color3.fromRGB(12,18,36), Hdr=Color3.fromRGB(24,38,74), Btn=Color3.fromRGB(38,62,118), On=Color3.fromRGB(65,115,215), Acc=Color3.fromRGB(120,175,255), Txt=Color3.fromRGB(255,255,255), Trk=Color3.fromRGB(28,42,72)},
	{Name="CRIMSON", Bg=Color3.fromRGB(38,12,18), Hdr=Color3.fromRGB(82,22,36), Btn=Color3.fromRGB(132,34,56), On=Color3.fromRGB(205,52,84), Acc=Color3.fromRGB(255,115,145), Txt=Color3.fromRGB(255,255,255), Trk=Color3.fromRGB(68,24,34)},
	{Name="CYBER", Bg=Color3.fromRGB(10,28,30), Hdr=Color3.fromRGB(18,60,66), Btn=Color3.fromRGB(24,96,104), On=Color3.fromRGB(32,175,185), Acc=Color3.fromRGB(90,245,255), Txt=Color3.fromRGB(255,255,255), Trk=Color3.fromRGB(20,52,58)}
}

local L = {
	EN = {
		T1="UNIV",T2="MM2",T3="R-FRIENDS",T4="BROOKHAVEN",T5="DOORS",T6="SETTINGS",
		SPD="SPEED",SPN="SPIN SPEED",ESP="ESP",SHRAIN="SHADER: RAIN",SHGLOSS="SHADER: GLOSS",SHSUN="SHADER: SUNSET",
		TK="TELEKINESIS",TP10="TP +10 STUDS",HIDE="HIDE (+30)",BHOP="BUNNY HOP",FLY="FLY",CLIP="NOCLIP",INVIS="INVISIBLE",USPIN="ULTRA SPIN",CHAOS="CHAOS MODE",
		RESP="ROLE ESP",SHOOT="AUTO SHOOT",KILL="KILL ALL",COIN="COIN FARM",VSLOT="VOTE SLOT",VOTE="AUTO VOTE + RESET",TPMAP="TP TO MAP",
		RFM="MONSTERS ESP",RFI="ITEMS / LAMPS ESP",
		AK="ANTI-KICK HOUSE",BSPD="BALL SPEED",BALLS="SPAM BASKETBALLS",PH="PLAYER HOUSE",TPH="TP TO PLAYER HOUSE",CIH="CAR IN HOUSE",HBALL="BALL BARRAGE",
		DALERT="MONSTER ALERT",DMESP="MONSTERS ESP",DCESP="COINS ESP",DKESP="KEYS ESP",DBKESP="BOOKS ESP",DWRDESP="WARDROBES ESP",DITEMS="ITEMS ESP",DBRES="BREAKER ESP",DSRUN="SEEK RUN ESP",DDESP="DOOR ESP",DAHIDE="AUTO HIDE R/A",DSAFE="SAFE SPEED",
		NONE="NONE",LANG="LANGUAGE",THEME="THEME"
	},
	RU = {
		T1="УНИВЕРС",T2="MM2",T3="R-FRIENDS",T4="БРУКХЕЙВЕН",T5="DOORS",T6="НАСТРОЙКИ",
		SPD="СКОРОСТЬ",SPN="СК. КРУТКИ",ESP="ЕСП",SHRAIN="ШЕЙДЕР: ДОЖДЬ",SHGLOSS="ШЕЙДЕР: ГЛЯНЕЦ",SHSUN="ШЕЙДЕР: ЗАКАТ",
		TK="ТЕЛЕКИНЕЗ",TP10="ТП +10 СТАДОВ",HIDE="ПРЯТАТЬСЯ (+30)",BHOP="БАННИ ХОП",FLY="ПОЛЁТ",CLIP="NOCLIP",INVIS="НЕВИДИМКА",USPIN="УЛЬТРА КРУТКА",CHAOS="ХАОС РЕЖИМ",
		RESP="ЕСП РОЛЕЙ",SHOOT="АВТО ВЫСТРЕЛ",KILL="УБИТЬ ВСЕХ",COIN="ФАРМ МОНЕТ",VSLOT="СЛОТ ГОЛОСА",VOTE="АВТО ГОЛОС + РЕСЕТ",TPMAP="ТП НА КАРТУ",
		RFM="ЕСП МОНСТРОВ",RFI="ЕСП ВЕЩЕЙ / ЛАМП",
		AK="АНТИ-КИК ИЗ ДОМА",BSPD="СК. МЯЧЕЙ",BALLS="СПАМ МЯЧАМИ",PH="ДОМ ИГРОКА",TPH="ТП К ДОМУ ИГРОКА",CIH="МАШИНА В ДОМ",HBALL="ЗАЛП МЯЧАМИ",
		DALERT="ОПОВЕЩЕНИЕ МОНСТРОВ",DMESP="ЕСП МОНСТРОВ",DCESP="ЕСП МОНЕТ",DKESP="ЕСП КЛЮЧЕЙ",DBKESP="ЕСП КНИГ",DWRDESP="ЕСП ШКАФОВ",DITEMS="ЕСП ПРЕДМЕТОВ",DBRES="ЕСП ЭЛЕКТРОЩИТКА",DSRUN="ЕСП ПУТИ СИКА",DDESP="ЕСП ДВЕРИ",DAHIDE="АВТО ПРЯТКИ R/A",DSAFE="БЕЗОПАСНЫЙ БЕГ",
		NONE="НЕТ",LANG="ЯЗЫК",THEME="ТЕМА"
	}
}
local function tr(k) return (L[currentLang] and L[currentLang][k]) or L.EN[k] or k end

for _, n in ipairs({"PurpleGUIV15","PurpleGUIV16"}) do local o = PG:FindFirstChild(n) if o then o:Destroy() end end

local GUI = Instance.new("ScreenGui", PG)
GUI.Name = "PurpleGUIV16"
GUI.ResetOnSpawn = false

local AlertBanner = Instance.new("TextLabel", GUI)
AlertBanner.Size = UDim2.new(0.6, 0, 0, 38)
AlertBanner.Position = UDim2.new(0.2, 0, 0.12, 0)
AlertBanner.BackgroundColor3 = Color3.fromRGB(35, 10, 18)
AlertBanner.TextColor3 = Color3.fromRGB(255, 90, 90)
AlertBanner.Font = Enum.Font.GothamBlack
AlertBanner.TextSize = 15
AlertBanner.Text = ""
AlertBanner.Visible = false
AlertBanner.ZIndex = 30
Instance.new("UICorner", AlertBanner).CornerRadius = UDim.new(0, 10)
local AlertStroke = Instance.new("UIStroke", AlertBanner)
AlertStroke.Color = Color3.fromRGB(255, 70, 70)
AlertStroke.Thickness = 2

local Main = Instance.new("Frame", GUI)
Main.Size = UDim2.fromOffset(286, 286)
Main.Position = UDim2.new(0.5, -143, 0.34, 0)
Main.BorderSizePixel = 0
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Outline = Instance.new("UIStroke", Main)
Outline.Thickness = 2

local Hdr = Instance.new("Frame", Main)
Hdr.Size = UDim2.new(1, 0, 0, 34)
Hdr.BorderSizePixel = 0
Hdr.Active = true
Instance.new("UICorner", Hdr).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Hdr)
Title.Size = UDim2.new(1, -35, 1, 0)
Title.Position = UDim2.fromOffset(5, 0)
Title.BackgroundTransparency = 1
Title.Text = "PURPLE GUI V16"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local HideBtn = Instance.new("TextButton", Hdr)
HideBtn.Size = UDim2.fromOffset(27, 25)
HideBtn.Position = UDim2.new(1, -31, 0, 4)
HideBtn.Text = "—"
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 18
Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0, 7)

local OpenBtn = Instance.new("ImageButton", GUI)
OpenBtn.Size = UDim2.fromOffset(58, 58)
OpenBtn.Position = UDim2.new(1, -73, 0.5, -29)
OpenBtn.Image = IMAGE_ID
OpenBtn.ScaleType = Enum.ScaleType.Crop
OpenBtn.Visible = false
OpenBtn.ZIndex = 20
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Thickness = 2

HideBtn.MouseButton1Click:Connect(function() Main.Visible, OpenBtn.Visible = false, true end)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible, OpenBtn.Visible = true, false end)

local drag, dStart, sPos
Hdr.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
		drag, dStart, sPos = true, i.Position, Main.Position
	end
end)
UIS.InputChanged:Connect(function(i)
	if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
		local d = i.Position - dStart
		Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)

local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.fromOffset(5, 40)
TabBar.Size = UDim2.new(1, -10, 0, 28)
TabBar.BackgroundTransparency = 1

local refreshList, btnRefs, frameRefs, trackRefs, textRefs = {}, {}, {}, {}, {}
local curTheme = THEMES[1]
local syncThemeEsp = nil

local activeTab = "U"
local function makeTab(k, x, w, xo)
	local b = Instance.new("TextButton", TabBar)
	b.Size = UDim2.new(w, -2, 1, 0)
	b.Position = UDim2.new(x, xo or 0, 0, 0)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 6.5
	b.Text = tr(k)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
	table.insert(textRefs, b)
	table.insert(refreshList, function() b.Text = tr(k) end)
	return b
end
local T1 = makeTab("T1", 0.00, 0.15, 0)
local T2 = makeTab("T2", 0.15, 0.11, 2)
local T3 = makeTab("T3", 0.26, 0.18, 4)
local T4 = makeTab("T4", 0.44, 0.21, 6)
local T5 = makeTab("T5", 0.65, 0.14, 8)
local T6 = makeTab("T6", 0.79, 0.21, 10)

local pages = {}
local function makePage(id)
	local p = Instance.new("ScrollingFrame", Main)
	p.Position = UDim2.fromOffset(8, 75)
	p.Size = UDim2.new(1, -16, 1, -83)
	p.BackgroundTransparency = 1
	p.BorderSizePixel = 0
	p.ScrollBarThickness = 4
	p.AutomaticCanvasSize = Enum.AutomaticSize.Y
	p.CanvasSize = UDim2.new(0,0,0,0)
	p.Visible = (id == "U")
	local l = Instance.new("UIListLayout", p)
	l.Padding = UDim.new(0, 7)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	local pad = Instance.new("UIPadding", p)
	pad.PaddingTop, pad.PaddingBottom = UDim.new(0,2), UDim.new(0,4)
	pages[id] = p
	return p
end
local P1, P2, P3, P4, P5, P6 = makePage("U"), makePage("M"), makePage("R"), makePage("B"), makePage("D"), makePage("S")

local function paint()
	Main.BackgroundColor3, OpenBtn.BackgroundColor3 = curTheme.Bg, curTheme.Bg
	Hdr.BackgroundColor3 = curTheme.Hdr
	Outline.Color, OpenStroke.Color = curTheme.Acc, curTheme.Acc
	for _, f in ipairs(frameRefs) do f.o.BackgroundColor3 = curTheme[f.k] end
	for _, trk in ipairs(trackRefs) do trk.BackgroundColor3 = curTheme.Trk end
	for _, tx in ipairs(textRefs) do tx.TextColor3 = curTheme.Txt end
	for _, b in ipairs(btnRefs) do b.o.BackgroundColor3 = (b.fn and b.fn()) and curTheme.On or curTheme.Btn end
	for _, p in pairs(pages) do p.ScrollBarImageColor3 = curTheme.Acc end
	T1.BackgroundColor3 = activeTab=="U" and curTheme.On or curTheme.Btn
	T2.BackgroundColor3 = activeTab=="M" and curTheme.On or curTheme.Btn
	T3.BackgroundColor3 = activeTab=="R" and curTheme.On or curTheme.Btn
	T4.BackgroundColor3 = activeTab=="B" and curTheme.On or curTheme.Btn
	T5.BackgroundColor3 = activeTab=="D" and curTheme.On or curTheme.Btn
	T6.BackgroundColor3 = activeTab=="S" and curTheme.On or curTheme.Btn
	if syncThemeEsp then syncThemeEsp() end
end

local function setTab(id)
	activeTab = id
	for k, p in pairs(pages) do p.Visible = (k == id) end
	paint()
end
T1.MouseButton1Click:Connect(function() setTab("U") end)
T2.MouseButton1Click:Connect(function() setTab("M") end)
T3.MouseButton1Click:Connect(function() setTab("R") end)
T4.MouseButton1Click:Connect(function() setTab("B") end)
T5.MouseButton1Click:Connect(function() setTab("D") end)
T6.MouseButton1Click:Connect(function() setTab("S") end)

local function addBtn(p, k, cb)
	local b = Instance.new("TextButton", p)
	b.Size = UDim2.new(1, -3, 0, 44)
	b.Font, b.TextSize, b.AutoButtonColor = Enum.Font.GothamBold, 11.5, false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
	local en = false
	local function upd() b.Text = tr(k) .. (en and " : ON" or " : OFF") end
	local function setV(v) en = v; upd(); paint() end
	upd()
	table.insert(textRefs, b); table.insert(btnRefs, {o=b, fn=function() return en end}); table.insert(refreshList, upd)
	b.MouseButton1Click:Connect(function() setV(not en); cb(en) end)
	return {SetState=setV, Upd=upd}
end

local function addAct(p, k, cb)
	local b = Instance.new("TextButton", p)
	b.Size = UDim2.new(1, -3, 0, 44)
	b.Text, b.Font, b.TextSize = tr(k), Enum.Font.GothamBold, 11.5
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
	table.insert(textRefs, b); table.insert(btnRefs, {o=b}); table.insert(refreshList, function() b.Text = tr(k) end)
	b.MouseButton1Click:Connect(function() b.BackgroundColor3 = curTheme.On; cb(); task.delay(0.12, paint) end)
	return b
end

local function addSlider(p, k, init, mn, mx, cb)
	local f = Instance.new("Frame", p)
	f.Size, f.BorderSizePixel = UDim2.new(1, -3, 0, 60), 0
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
	table.insert(frameRefs, {o=f, k="Btn"})
	local lbl = Instance.new("TextLabel", f)
	lbl.Position, lbl.Size, lbl.BackgroundTransparency = UDim2.fromOffset(10, 4), UDim2.new(1, -20, 0, 20), 1
	lbl.Font, lbl.TextSize, lbl.TextXAlignment = Enum.Font.GothamBold, 12.5, Enum.TextXAlignment.Left
	table.insert(textRefs, lbl)
	local trk = Instance.new("Frame", f)
	trk.Position, trk.Size, trk.BorderSizePixel = UDim2.new(0, 10, 0, 35), UDim2.new(1, -20, 0, 8), 0
	Instance.new("UICorner", trk).CornerRadius = UDim.new(1, 0)
	table.insert(trackRefs, trk)
	local fill = Instance.new("Frame", trk)
	fill.BorderSizePixel = 0; Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
	table.insert(frameRefs, {o=fill, k="Acc"})
	local knob = Instance.new("Frame", trk)
	knob.AnchorPoint, knob.Size, knob.BorderSizePixel = Vector2.new(0.5,0.5), UDim2.fromOffset(16,16), 0
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	table.insert(frameRefs, {o=knob, k="Txt"})
	local val, dragS, actIn = init, false, nil
	local function updLbl() lbl.Text = tr(k) .. ": " .. val end
	updLbl(); table.insert(refreshList, updLbl)
	local function setPct(pct)
		pct = math.clamp(pct, 0, 1)
		val = math.floor(mn + pct * (mx - mn) + 0.5)
		fill.Size, knob.Position = UDim2.new(pct, 0, 1, 0), UDim2.new(pct, 0, 0.5, 0)
		updLbl(); cb(val)
	end
	setPct((init - mn) / (mx - mn))
	trk.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragS, actIn = true, i
			if trk.AbsoluteSize.X > 0 then setPct((i.Position.X - trk.AbsolutePosition.X) / trk.AbsoluteSize.X) end
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragS and (i.UserInputType == Enum.UserInputType.MouseMovement or i == actIn) and trk.AbsoluteSize.X > 0 then
			setPct((i.Position.X - trk.AbsolutePosition.X) / trk.AbsoluteSize.X)
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i == actIn or i.UserInputType == Enum.UserInputType.MouseButton1 then dragS, actIn = false, nil end
	end)
end

local function rootOf(c) return c and c:FindFirstChild("HumanoidRootPart") end
local function humOf(c) return c and c:FindFirstChildOfClass("Humanoid") end
local function posOf(o)
	if not o or not o.Parent then return nil end
	if o:IsA("BasePart") then return o.Position end
	if o:IsA("Model") then local p = o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart"); if p then return p.Position end end
	local p = o:FindFirstChildWhichIsA("BasePart", true); return p and p.Position
end
local function isPlrObj(o)
	local cur = o
	while cur and cur ~= workspace do
		if cur:IsA("Model") and Players:GetPlayerFromCharacter(cur) then return true end
		cur = cur.Parent
	end
	return false
end
local function tpPos(p)
	local r = rootOf(LP.Character)
	if r and p then r.AssemblyLinearVelocity = Vector3.zero; r.CFrame = CFrame.new(p + Vector3.new(0, 3, 0)) end
end

local bhopEn, chaosEn, clipEn, hideEn, flyEn, spinEn, invEn, univEspEn, safeSpeedEn = false, false, false, false, false, false, false, false, false
local bhopConn, chaosConn, clipConn, hideConn, flyConn, spinConn, univEspConn, safeSpeedConn, tkSimConn
local bhopBoost, hideAnchor, hideOrigin = 0, nil, nil
local oldCol, savedSz, savedMesh, savedSc = {}, {}, {}, {}

local function setHumSpd()
	local h = humOf(LP.Character)
	if h and not chaosEn then
		if safeSpeedEn then
			h.WalkSpeed = 21
		else
			h.WalkSpeed = bhopEn and math.clamp(speed+bhopBoost,16,185) or speed
		end
	end
end

-- UNIVERSAL ESP (THEME COLOR)
local function applyUnivEspToChar(char)
	if not char then return end
	local hl = char:FindFirstChild("PurpleThemeESP")
	if not univEspEn then
		if hl then hl:Destroy() end
		return
	end
	if not hl then
		hl = Instance.new("Highlight")
		hl.Name = "PurpleThemeESP"
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.FillTransparency = 0.45
		hl.OutlineTransparency = 0
		hl.Adornee = char
		hl.Parent = char
	end
	hl.FillColor = curTheme.Acc
	hl.OutlineColor = curTheme.On
end

local function refreshUnivEsp()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP and p.Character then
			applyUnivEspToChar(p.Character)
		end
	end
end
syncThemeEsp = refreshUnivEsp

addBtn(P1, "ESP", function(e)
	univEspEn = e
	if univEspConn then univEspConn:Disconnect(); univEspConn = nil end
	refreshUnivEsp()
	if e then univEspConn = RS.Heartbeat:Connect(refreshUnivEsp) end
end)

-- UNIVERSAL SHADERS (RAIN / GLOSS / SUNSET)
local activeShader = nil
local savedLighting = nil
local shaderConn = nil
local rainParts = {}
local rainBtn, glossBtn, sunBtn

local function clearRainDrops()
	for i = #rainParts, 1, -1 do
		local p = rainParts[i]
		if p and p.Parent then pcall(function() p:Destroy() end) end
		rainParts[i] = nil
	end
end

local function clearShaderEffects()
	if shaderConn then shaderConn:Disconnect(); shaderConn = nil end
	clearRainDrops()
	for _, inst in ipairs(Lighting:GetChildren()) do
		if string.sub(inst.Name, 1, 12) == "PurpleShader" then
			pcall(function() inst:Destroy() end)
		end
	end
	if savedLighting then
		pcall(function()
			Lighting.Ambient = savedLighting.Ambient
			Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient
			Lighting.ColorShift_Top = savedLighting.ColorShift_Top
			Lighting.ColorShift_Bottom = savedLighting.ColorShift_Bottom
			Lighting.Brightness = savedLighting.Brightness
			Lighting.ClockTime = savedLighting.ClockTime
			Lighting.FogColor = savedLighting.FogColor
			Lighting.FogStart = savedLighting.FogStart
			Lighting.FogEnd = savedLighting.FogEnd
			if Lighting:FindFirstChildOfClass("Atmosphere") then
				Lighting:FindFirstChildOfClass("Atmosphere"):Destroy()
			end
			if savedLighting.Atmo then
				local atmo = Instance.new("Atmosphere")
				for k, v in pairs(savedLighting.Atmo) do
					pcall(function() atmo[k] = v end)
				end
				atmo.Parent = Lighting
			end
		end)
	end
end

local function captureLightingOnce()
	if savedLighting then return end
	local atmoData = nil
	local existingAtmo = Lighting:FindFirstChildOfClass("Atmosphere")
	if existingAtmo then
		atmoData = {
			Density = existingAtmo.Density,
			Offset = existingAtmo.Offset,
			Color = existingAtmo.Color,
			Decay = existingAtmo.Decay,
			Glare = existingAtmo.Glare,
			Haze = existingAtmo.Haze
		}
	end
	savedLighting = {
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
		ColorShift_Top = Lighting.ColorShift_Top,
		ColorShift_Bottom = Lighting.ColorShift_Bottom,
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		FogColor = Lighting.FogColor,
		FogStart = Lighting.FogStart,
		FogEnd = Lighting.FogEnd,
		Atmo = atmoData
	}
end

local function syncShaderButtons()
	if rainBtn then rainBtn.SetState(activeShader == "RAIN") end
	if glossBtn then glossBtn.SetState(activeShader == "GLOSS") end
	if sunBtn then sunBtn.SetState(activeShader == "SUNSET") end
end

local function applyShader(mode)
	clearShaderEffects()
	if activeShader == mode then
		activeShader = nil
		syncShaderButtons()
		return
	end
	captureLightingOnce()
	activeShader = mode

	local cc = Instance.new("ColorCorrectionEffect")
	cc.Name = "PurpleShaderCC"
	cc.Parent = Lighting

	local bloom = Instance.new("BloomEffect")
	bloom.Name = "PurpleShaderBloom"
	bloom.Parent = Lighting

	local atmo = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere")
	atmo.Name = "PurpleShaderAtmo"
	atmo.Parent = Lighting

	if mode == "RAIN" then
		Lighting.ClockTime = 13.5
		Lighting.Brightness = 1.15
		Lighting.Ambient = Color3.fromRGB(70, 82, 98)
		Lighting.OutdoorAmbient = Color3.fromRGB(75, 88, 105)
		Lighting.ColorShift_Top = Color3.fromRGB(110, 125, 145)
		Lighting.FogColor = Color3.fromRGB(95, 108, 124)
		Lighting.FogStart = 20
		Lighting.FogEnd = 165
		atmo.Density = 0.45
		atmo.Haze = 2.4
		atmo.Color = Color3.fromRGB(125, 138, 155)
		atmo.Decay = Color3.fromRGB(75, 85, 100)
		cc.Saturation = -0.25
		cc.Contrast = 0.12
		cc.TintColor = Color3.fromRGB(185, 200, 220)
		bloom.Intensity = 0.25
		bloom.Threshold = 1.2

		for i = 1, 45 do
			local drop = Instance.new("Part")
			drop.Name = "PurpleShaderRainDrop"
			drop.Anchored = true
			drop.CanCollide = false
			drop.Material = Enum.Material.Glass
			drop.Color = Color3.fromRGB(185, 215, 240)
			drop.Transparency = 0.45
			drop.Size = Vector3.new(0.05, 2.2, 0.05)
			drop.Parent = workspace
			table.insert(rainParts, drop)
		end
		shaderConn = RS.RenderStepped:Connect(function()
			local cam = workspace.CurrentCamera
			local center = cam and cam.CFrame.Position or Vector3.zero
			for _, drop in ipairs(rainParts) do
				if drop and drop.Parent then
					local rx = math.random(-36, 36)
					local ry = math.random(-8, 26)
					local rz = math.random(-36, 36)
					drop.CFrame = CFrame.new(center + Vector3.new(rx, ry, rz)) * CFrame.Angles(0, 0, math.rad(-8))
				end
			end
		end)
	elseif mode == "GLOSS" then
		Lighting.Brightness = 2.6
		Lighting.Ambient = Color3.fromRGB(115, 120, 130)
		Lighting.OutdoorAmbient = Color3.fromRGB(135, 140, 150)
		Lighting.ColorShift_Top = Color3.fromRGB(220, 230, 245)
		cc.Saturation = 0.18
		cc.Contrast = 0.24
		cc.Brightness = 0.04
		cc.TintColor = Color3.fromRGB(242, 246, 255)
		bloom.Intensity = 0.85
		bloom.Threshold = 0.72
		bloom.Size = 24
		pcall(function()
			Lighting.EnvironmentSpecularScale = 1
			Lighting.EnvironmentDiffuseScale = 1
		end)
	elseif mode == "SUNSET" then
		Lighting.ClockTime = 18.25
		Lighting.Brightness = 2.1
		Lighting.Ambient = Color3.fromRGB(120, 72, 78)
		Lighting.OutdoorAmbient = Color3.fromRGB(165, 95, 75)
		Lighting.ColorShift_Top = Color3.fromRGB(255, 145, 85)
		Lighting.ColorShift_Bottom = Color3.fromRGB(115, 65, 95)
		Lighting.FogColor = Color3.fromRGB(235, 135, 95)
		Lighting.FogStart = 45
		Lighting.FogEnd = 360
		atmo.Density = 0.32
		atmo.Haze = 2.0
		atmo.Glare = 0.45
		atmo.Color = Color3.fromRGB(255, 150, 95)
		atmo.Decay = Color3.fromRGB(130, 75, 105)
		cc.Saturation = 0.22
		cc.Contrast = 0.16
		cc.TintColor = Color3.fromRGB(255, 195, 160)
		bloom.Intensity = 0.65
		bloom.Threshold = 0.8
	end

	syncShaderButtons()
end

rainBtn = addBtn(P1, "SHRAIN", function() applyShader("RAIN") end)
glossBtn = addBtn(P1, "SHGLOSS", function() applyShader("GLOSS") end)
sunBtn = addBtn(P1, "SHSUN", function() applyShader("SUNSET") end)

-- TELEKINESIS V5
local function giveTelekinesis()
	if tkSimConn then tkSimConn:Disconnect(); tkSimConn = nil end
	local c = LP.Character
	local bp = LP:FindFirstChild("Backpack")
	for _, container in ipairs({c, bp}) do
		if container then
			for _, item in ipairs(container:GetChildren()) do
				if item:IsA("Tool") and item.Name == "Telekinesis V5" then item:Destroy() end
			end
		end
	end
	if c then local oldSb = c:FindFirstChild("PurpleTKBox"); if oldSb then oldSb:Destroy() end end

	local sandbox = function(var, func)
		local env = getfenv(func)
		local newenv = setmetatable({}, {
			__index = function(self, k)
				if k == "script" then return var else return env[k] end
			end,
		})
		setfenv(func, newenv)
		return func
	end

	local cors = {}
	local _Ins, _CF_new, _VTR_new = Instance.new, CFrame.new, Vector3.new
	local mas = _Ins("Model", game:GetService("Lighting"))
	local con = getfenv().sethiddenproperty
	local Tool0 = _Ins("Tool")
	local Part1 = _Ins("Part")
	local Script2 = _Ins("Script")
	local selectionbox = _Ins("SelectionBox", c or LP)
	selectionbox.Name = "PurpleTKBox"
	selectionbox.LineThickness = 0.3
	selectionbox.Color3 = Color3.fromRGB(255, 255, 255)
	local LocalScript3 = _Ins("LocalScript")
	local w = wait

	Tool0.Name = "Telekinesis V5"
	Tool0.Parent = mas
	Tool0.Grip = _CF_new(0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	Tool0.GripPos = _VTR_new(0, 0, 1)

	Part1.Name = "Handle"
	Part1.Parent = Tool0
	Part1.CFrame = _CF_new(-3.5, 5.30000019, -3.5, 1, 0, 0, 0, -1, 0, 0, 0, -1)
	Part1.Orientation = _VTR_new(0, 180, 180)
	Part1.Position = _VTR_new(-3.5, 5.300000190734863, -3.5)
	Part1.Rotation = _VTR_new(-180, 0, 0)
	Part1.Color = Color3.new(0.972549, 0.972549, 0.972549)
	Part1.Transparency = 1
	Part1.Size = _VTR_new(1, 1, 1)
	Part1.BottomSurface = Enum.SurfaceType.Smooth
	Part1.BrickColor = BrickColor.new("Institutional white")
	Part1.Locked = true
	Part1.TopSurface = Enum.SurfaceType.Smooth
	Part1.brickColor = BrickColor.new("Institutional white")

	Script2.Name = "LineConnect"
	Script2.Parent = Tool0

	local Sound = _Ins("Sound", workspace)
	Sound.SoundId = "rbxassetid://1092093337"
	Sound:Play()
	Sound.Ended:Connect(function() Sound:Destroy() end)

	local simRadius = 31
	local mb = UIS.TouchEnabled
	tkSimConn = RS.RenderStepped:Connect(function()
		if not Tool0 or not Tool0.Parent then
			if tkSimConn then tkSimConn:Disconnect(); tkSimConn = nil end
			return
		end
		if con then pcall(function() con(LP, "SimulationRadius", simRadius) end) end
	end)

	table.insert(cors, sandbox(Script2, function()
		w()
		local check = script.Part2
		local part1 = script.Part1.Value
		local part2 = script.Part2.Value
		local parent = script.Par.Value
		local color = script.Color
		local line = _Ins("Part")
		line.TopSurface = 0; line.BottomSurface = 0; line.Reflectance = .5; line.Name = "Laser"
		line.Locked = true; line.CanCollide = false; line.Anchored = true; line.formFactor = 0; line.Size = _VTR_new(1, 1, 1)
		local mesh = _Ins("BlockMesh"); mesh.Parent = line
		while true do
			if (check.Value == nil) then break end
			if (part1 == nil or part2 == nil or parent == nil) then break end
			if (part1.Parent == nil or part2.Parent == nil) then break end
			if (parent.Parent == nil) then break end
			local lv = _CF_new(part1.Position, part2.Position)
			local dist = (part1.Position - part2.Position).magnitude
			line.Parent = parent
			line.BrickColor = color.Value.BrickColor
			line.Reflectance = color.Value.Reflectance
			line.Transparency = color.Value.Transparency
			line.CFrame = _CF_new(part1.Position + lv.lookVector * dist / 2)
			line.CFrame = _CF_new(line.Position, part2.Position)
			mesh.Scale = _VTR_new(.25, .25, dist)
			w()
		end
		line:remove(); script:remove()
	end))
	Script2.Disabled = true

	LocalScript3.Name = "MainScript"
	LocalScript3.Parent = Tool0
	table.insert(cors, sandbox(LocalScript3, function()
		w()
		local tool = script.Parent
		local lineconnect = tool.LineConnect
		local object = nil
		local mousedown = false
		local BP = _Ins("BodyPosition")
		BP.maxForce = _VTR_new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge)
		BP.P = BP.P * 3
		local dist = nil
		local point = _Ins("Part")
		point.Locked = true; point.Anchored = true; point.formFactor = 0; point.Shape = 0
		point.BrickColor = BrickColor.Blue(); point.Size = _VTR_new(1, 1, 1); point.CanCollide = false
		local mesh = _Ins("SpecialMesh"); mesh.MeshType = "Sphere"; mesh.Scale = _VTR_new(.7, .7, .7); mesh.Parent = point
		local front = tool.Handle; local color = tool.Handle; local objval = nil

		local LineConnect = function(part1, part2, parent)
			local p1 = _Ins("ObjectValue"); p1.Value = part1; p1.Name = "Part1"
			local p2 = _Ins("ObjectValue"); p2.Value = part2; p2.Name = "Part2"
			local par = _Ins("ObjectValue"); par.Value = parent; par.Name = "Par"
			local col = _Ins("ObjectValue"); col.Value = color; col.Name = "Color"
			local s = lineconnect:clone(); s.Disabled = false
			p1.Parent = s; p2.Parent = s; par.Parent = s; col.Parent = s; s.Parent = workspace
			if (part2 == object) then objval = p2 end
		end

		local onButton1Down = function(mouse)
			if (mousedown == true) then return end
			mousedown = true
			coroutine.resume(coroutine.create(function()
				local p = point:clone(); p.Parent = tool; LineConnect(front, p, workspace)
				while (mousedown == true) do
					p.Parent = tool
					if (object == nil) then
						if (mouse.Target == nil) then
							local lv = _CF_new(front.Position, mouse.Hit.p)
							p.CFrame = _CF_new(front.Position + (lv.lookVector * 1000))
						else
							p.CFrame = _CF_new(mouse.Hit.p)
						end
					else
						LineConnect(front, object, workspace); break
					end
					w()
				end
				p:remove()
			end))
			while (mousedown == true) do
				if (mouse.Target ~= nil) then
					local t = mouse.Target
					if (t.Anchored == false) then
						object = t; selectionbox.Adornee = object
						dist = (object.Position - front.Position).magnitude; break
					end
				end
				w()
			end
			while (mousedown == true) do
				if (object == nil or object.Parent == nil) then break end
				local lv = _CF_new(front.Position, mouse.Hit.p)
				BP.Parent = object; BP.position = front.Position + lv.lookVector * dist
				w()
			end
			BP:remove(); object = nil
			if objval then objval.Value = nil end
			selectionbox.Adornee = nil
		end

		local onKeyDown = function(key, mouse)
			key = key:lower()
			if (key == "q") and dist and (dist >= 5) then dist = dist - 5 end
			if (key == "u") and object and (dist ~= 1) then
				local BX = _Ins("BodyGyro"); BX.MaxTorque = _VTR_new(math.huge, 0, math.huge)
				BX.CFrame = BX.CFrame * CFrame.Angles(0, math.rad(45), 0); BX.D = 0; BX.Parent = object
			end
			if (key == "p") and object and (dist ~= 1) then
				local BX = _Ins("BodyVelocity"); BX.maxForce = _VTR_new(0, math.huge, 0)
				BX.velocity = _VTR_new(0, 1, 0); BX.Parent = object
			end
			if key == "l" then
				if (object == nil) then return end
				for _, v in pairs(object:children()) do if v.className == "BodyGyro" then return nil end end
				local BG = _Ins("BodyGyro"); BG.maxTorque = _VTR_new(math.huge, math.huge, math.huge)
				BG.cframe = _CF_new(object.CFrame.p); BG.Parent = object
				repeat w() until (object == nil or object.CFrame == _CF_new(object.CFrame.p))
				BG.Parent = nil
				if (object == nil) then return end
				for _, v in pairs(object:children()) do if v.className == "BodyGyro" then v.Parent = nil end end
				object.Velocity = _VTR_new(0, 0, 0); object.RotVelocity = _VTR_new(0, 0, 0)
			end
			if (key == "y") and (dist ~= 100) then dist = 100 end
			if (key == "j") and (dist ~= 5000) then dist = 5000 end
			if (key == "e") and dist then dist = dist + 5 end
			if (key == "x") and dist ~= 15 then dist = 15 end
		end

		local onEquipped = function(mouse)
			local char = tool.Parent
			local human = char:FindFirstChildOfClass("Humanoid")
			if human then
				human.Changed:connect(function()
					if (human.Health == 0) then
						mousedown = false; BP:remove(); point:remove(); selectionbox:Destroy(); tool:remove()
					end
				end)
			end
			mouse.Button1Down:connect(function() onButton1Down(mouse) end)
			mouse.KeyDown:connect(function(key) onKeyDown(key, mouse) end)
			mouse.Icon = "rbxasset://textures\\GunCursor.png"
			if mb then
				UIS.TouchLongPress:Connect(function() onKeyDown("y", mouse) end)
				UIS.TouchEnded:Connect(function() mousedown = false end)
			else
				mouse.Button1Up:connect(function() mousedown = false end)
			end
		end
		tool.Equipped:connect(onEquipped)
		tool.Unequipped:connect(function() mousedown = false; selectionbox.Adornee = nil end)
	end))

	for _, v in pairs(mas:GetChildren()) do
		v.Parent = LP:WaitForChild("Backpack"); pcall(function() v:MakeJoints() end)
	end
	mas:Destroy()
	for _, v in pairs(cors) do task.spawn(function() pcall(v) end) end

	local h = humOf(LP.Character)
	if h and Tool0.Parent == LP:FindFirstChild("Backpack") then pcall(function() h:EquipTool(Tool0) end) end
end

addSlider(P1, "SPD", speed, 16, 150, function(v) speed = v; setHumSpd() end)
addSlider(P1, "SPN", spinSpeed, 0, 150, function(v) spinSpeed = v end)
addAct(P1, "TK", giveTelekinesis)
addAct(P1, "TP10", function() local r = rootOf(LP.Character); if r then local f = r.CFrame.LookVector; local p = r.Position+f*10+Vector3.new(0,2,0); r.CFrame = CFrame.lookAt(p,p+f) end end)

local function stopHide()
	hideEn = false; if hideConn then hideConn:Disconnect(); hideConn = nil end
	local ret, r = hideOrigin, rootOf(LP.Character)
	hideAnchor, hideOrigin = nil, nil
	if r then r.Anchored = false; r.AssemblyLinearVelocity = Vector3.zero; if ret then r.CFrame = ret + Vector3.new(0,1,0) end end
end
addBtn(P1, "HIDE", function(e)
	if not e then stopHide(); return end
	local r = rootOf(LP.Character); if not r then return end
	hideEn, hideOrigin, hideAnchor = true, r.CFrame, r.CFrame + Vector3.new(0,30,0)
	r.AssemblyLinearVelocity = Vector3.zero; r.CFrame = hideAnchor; r.Anchored = true
	hideConn = RS.Heartbeat:Connect(function()
		local rr = rootOf(LP.Character)
		if not hideEn or not rr or not hideAnchor then stopHide(); return end
		rr.Anchored = true; rr.AssemblyLinearVelocity = Vector3.zero; rr.CFrame = hideAnchor
	end)
end)

addBtn(P1, "BHOP", function(e)
	bhopEn, bhopBoost = e, 0; if bhopConn then bhopConn:Disconnect(); bhopConn = nil end
	if not e then setHumSpd(); return end
	bhopConn = RS.Heartbeat:Connect(function(dt)
		local h = humOf(LP.Character); if not h then return end
		local g, m = h.FloorMaterial ~= Enum.Material.Air, h.MoveDirection.Magnitude > 0.05
		if g then if m then bhopBoost = math.min(bhopBoost+dt*28,35); h.Jump = true else bhopBoost = math.max(bhopBoost-dt*50,0) end
		else bhopBoost = math.max(bhopBoost-dt*8,0) end
		setHumSpd()
	end)
end)

local function stopFly()
	if flyConn then flyConn:Disconnect(); flyConn = nil end
	local r = rootOf(LP.Character)
	if r then for _, o in ipairs(r:GetChildren()) do if o.Name=="PurpleFlyV" or o.Name=="PurpleFlyG" then o:Destroy() end end end
end
addBtn(P1, "FLY", function(e)
	flyEn = e; stopFly(); if not e then return end
	local h, r = humOf(LP.Character), rootOf(LP.Character); if not h or not r then return end
	local bv = Instance.new("BodyVelocity", r); bv.Name="PurpleFlyV"; bv.MaxForce=Vector3.new(1e6,1e6,1e6)
	local bg = Instance.new("BodyGyro", r); bg.Name="PurpleFlyG"; bg.MaxTorque=Vector3.new(1e6,1e6,1e6); bg.P=10000
	flyConn = RS.RenderStepped:Connect(function()
		if not r.Parent then stopFly(); return end
		local cam = workspace.CurrentCamera; local mv = h.MoveDirection; local lk = cam.CFrame.LookVector
		bv.Velocity = Vector3.new(mv.X,0,mv.Z)*speed + Vector3.new(0,lk.Y*speed,0); bg.CFrame = cam.CFrame
	end)
end)

local uClip, bClip
local function restCol() for p,v in pairs(oldCol) do if p and p.Parent then p.CanCollide = v end end; table.clear(oldCol) end
local function setClip(e)
	clipEn = e; if clipConn then clipConn:Disconnect(); clipConn = nil end
	if e then clipConn = RS.Stepped:Connect(function()
		local c = LP.Character; if not c then return end
		for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then if oldCol[p]==nil then oldCol[p]=p.CanCollide end; p.CanCollide=false end end
	end) else restCol() end
	if uClip then uClip.SetState(e) end; if bClip then bClip.SetState(e) end
end
uClip = addBtn(P1, "CLIP", setClip)

local function restScale()
	for o,v in pairs(savedSc) do if o and o.Parent then pcall(function() o.Value=v end) end end; table.clear(savedSc)
	for m,v in pairs(savedMesh) do if m and m.Parent then pcall(function() m.Scale=v end) end end; table.clear(savedMesh)
	for p,v in pairs(savedSz) do if p and p.Parent then pcall(function() p.Size=v end) end end; table.clear(savedSz)
end
addBtn(P1, "INVIS", function(e)
	invEn = e; restScale(); local c = LP.Character; if not e or not c then return end
	local h = humOf(c)
	if h then for _, ch in ipairs(h:GetChildren()) do if ch:IsA("NumberValue") and string.find(ch.Name,"Scale",1,true) then savedSc[ch]=ch.Value; pcall(function() ch.Value=math.max(0.05,ch.Value*0.05) end) end end end
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("SpecialMesh") then savedMesh[d]=d.Scale; pcall(function() d.Scale=d.Scale*0.05 end)
		elseif d:IsA("BasePart") then savedSz[d]=d.Size; pcall(function() d.Size=d.Size*0.05 end) end
	end
end)

addBtn(P1, "USPIN", function(e)
	spinEn = e; if spinConn then spinConn:Disconnect(); spinConn = nil end
	local r = rootOf(LP.Character); if not e then if r then r.AssemblyAngularVelocity=Vector3.zero end; return end
	spinConn = RS.Heartbeat:Connect(function() if r and r.Parent and not chaosEn then r.AssemblyAngularVelocity=Vector3.new(0,spinSpeed,0) end end)
end)

local function stopChaos()
	chaosEn = false; if chaosConn then chaosConn:Disconnect(); chaosConn = nil end
	local h, r = humOf(LP.Character), rootOf(LP.Character)
	if h then h.AutoRotate = true; setHumSpd(); h:ChangeState(Enum.HumanoidStateType.GettingUp) end
	if r then r.AssemblyAngularVelocity = Vector3.zero end
end
addBtn(P1, "CHAOS", function(e)
	if not e then stopChaos(); return end
	local h, r = humOf(LP.Character), rootOf(LP.Character); if not h or not r then return end
	chaosEn = true; local baseY, t, jt = r.Position.Y, 0, 0; h.AutoRotate, h.WalkSpeed = false, 0
	chaosConn = RS.Heartbeat:Connect(function(dt)
		if not chaosEn or not r.Parent or not h.Parent then stopChaos(); return end
		t, jt = t+dt, jt+dt
		r.AssemblyAngularVelocity = Vector3.new(0, math.max(130, spinSpeed*1.4), 0)
		if r.Position.Y < baseY-2.5 then r.CFrame = CFrame.new(r.Position.X, baseY+2.5, r.Position.Z)*r.CFrame.Rotation end
		if t >= 0.17 then
			t = 0; local ang = math.rad(math.random(0,359)); local spd = math.max(95, speed*1.65)
			local yv = (math.random()<0.45 and r.Position.Y<baseY+26) and math.random(28,46) or r.AssemblyLinearVelocity.Y
			r.AssemblyLinearVelocity = Vector3.new(math.cos(ang)*spd, yv, math.sin(ang)*spd)
		end
		if jt >= 0.42 then jt=0; if h.FloorMaterial~=Enum.Material.Air then h.Jump=true end end
	end)
end)

-- MM2
local function getRole(plr)
	if not plr then return "I" end
	local c, bp = plr.Character, plr:FindFirstChild("Backpack")
	local function has(x,n) return x and x:FindFirstChild(n,true)~=nil end
	if has(bp,"Knife") or has(bp,"KnifeVisuals") or has(c,"Knife") or has(c,"KnifeVisuals") then return "M" end
	if has(bp,"Gun") or has(bp,"GunVisuals") or has(c,"Gun") or has(c,"GunVisuals") then return "S" end
	local st = plr:FindFirstChild("Status"); local rl = st and st:FindFirstChild("Role")
	if rl then if rl.Value=="Murderer" then return "M" elseif rl.Value=="Sheriff" or rl.Value=="Hero" then return "S" end end
	return "I"
end

local espEn, espConn, shootEn, shootConn, killEn, coinEn, voteEn = false, nil, false, nil, false, false, false
local lastShot = 0

local function clearEsp() for _, p in ipairs(Players:GetPlayers()) do if p.Character then local b=p.Character:FindFirstChild("PurpleRoleBox"); if b then b:Destroy() end end end end
addBtn(P2, "RESP", function(e)
	espEn = e; if espConn then espConn:Disconnect(); espConn = nil end
	if not e then clearEsp(); return end
	espConn = RS.Heartbeat:Connect(function()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LP and p.Character then
				local r = rootOf(p.Character)
				if r then
					local b = p.Character:FindFirstChild("PurpleRoleBox") or Instance.new("BoxHandleAdornment", p.Character)
					b.Name, b.AlwaysOnTop, b.ZIndex, b.Transparency, b.Size, b.Adornee = "PurpleRoleBox", true, 10, 0.6, Vector3.new(4,5,1), r
					local rl = getRole(p)
					b.Color3 = rl=="M" and Color3.fromRGB(255,50,50) or (rl=="S" and Color3.fromRGB(50,100,255) or Color3.fromRGB(50,255,100))
				end
			end
		end
	end)
end)

addBtn(P2, "SHOOT", function(e)
	shootEn = e; if shootConn then shootConn:Disconnect(); shootConn = nil end
	if not e then return end
	shootConn = RS.RenderStepped:Connect(function()
		local c, h, r, bp = LP.Character, humOf(LP.Character), rootOf(LP.Character), LP:FindFirstChild("Backpack")
		if not c or not h or not r or h.Health<=0 then return end
		local gun
		for _, x in ipairs({c,bp}) do if x then for _, it in ipairs(x:GetChildren()) do if it:IsA("Tool") and (it.Name=="Gun" or it:FindFirstChild("GunVisuals",true)) then gun=it; break end end end; if gun then break end end
		if not gun then return end
		for _, p in ipairs(Players:GetPlayers()) do
			if p~=LP and getRole(p)=="M" and p.Character then
				local th, trp, hd = humOf(p.Character), rootOf(p.Character), p.Character:FindFirstChild("Head")
				if th and th.Health>0 and trp then
					local aim = hd or trp; local cam = workspace.CurrentCamera
					local rp = RaycastParams.new(); rp.FilterType=Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances={c,p.Character}
					if not workspace:Raycast(cam.CFrame.Position, aim.Position-cam.CFrame.Position, rp) then
						if gun.Parent~=c then h:EquipTool(gun) end
						cam.CFrame = CFrame.lookAt(cam.CFrame.Position, aim.Position)
						r.CFrame = CFrame.lookAt(r.Position, Vector3.new(aim.Position.X, r.Position.Y, aim.Position.Z))
						if os.clock()-lastShot>=0.25 then lastShot=os.clock(); pcall(function() gun:Activate() end) end
					end
					break
				end
			end
		end
	end)
end)

addBtn(P2, "KILL", function(e)
	killEn = e; if not e then return end
	task.spawn(function()
		while killEn do
			local c, h, r, bp = LP.Character, humOf(LP.Character), rootOf(LP.Character), LP:FindFirstChild("Backpack")
			if c and h and r and h.Health>0 then
				local kn
				for _, x in ipairs({c,bp}) do if x then for _, it in ipairs(x:GetChildren()) do if it:IsA("Tool") and (it.Name=="Knife" or it:FindFirstChild("KnifeVisuals",true)) then kn=it; break end end end; if kn then break end end
				if kn and kn.Parent~=c then h:EquipTool(kn) end
				for _, p in ipairs(Players:GetPlayers()) do
					if not killEn then break end
					if p~=LP and p.Character then
						local th, trp = humOf(p.Character), rootOf(p.Character)
						if th and th.Health>0 and trp then
							r.AssemblyLinearVelocity=Vector3.zero; r.CFrame=trp.CFrame*CFrame.new(0,0,2)
							if kn and kn.Parent==c then pcall(function() kn:Activate() end) end
							task.wait(0.22)
						end
					end
				end
			end
			task.wait(0.2)
		end
	end)
end)

local function nearCoin(fp)
	local bp, bd = nil, math.huge
	for _, d in ipairs(workspace:GetDescendants()) do
		if string.find(string.lower(d.Name),"coin",1,true) then
			local p = posOf(d); if p then local dist=(p-fp).Magnitude; if dist<bd then bd,bp=dist,p end end
		end
	end
	return bp
end

addBtn(P2, "COIN", function(e)
	coinEn = e; if not e then return end
	task.spawn(function()
		while coinEn do
			local h, r = humOf(LP.Character), rootOf(LP.Character)
			if h and r and h.Health>0 then
				local cp = nearCoin(r.Position)
				if cp then r.AssemblyLinearVelocity=Vector3.zero; r.CFrame=CFrame.new(cp+Vector3.new(0,1.5,0)); task.wait(0.16) else task.wait(0.4) end
			else task.wait(0.3) end
		end
	end)
end)

local vBtn
vBtn = addAct(P2, "VSLOT", function() selectedVoteSlot = (selectedVoteSlot % 3) + 1; vBtn.Text = tr("VSLOT").." : "..selectedVoteSlot end)
vBtn.Text = tr("VSLOT").." : 1"
table.insert(refreshList, function() vBtn.Text = tr("VSLOT").." : "..selectedVoteSlot end)

addBtn(P2, "VOTE", function(e)
	voteEn = e; if not e then return end
	task.spawn(function()
		while voteEn do
			local cand = {}
			for _, d in ipairs(workspace:GetDescendants()) do
				local nl = string.lower(d.Name)
				if (string.find(nl,"vote",1,true) or string.find(nl,"map",1,true) or string.find(nl,"option",1,true)) and (d:IsA("BasePart") or d:IsA("Model")) then
					local p = posOf(d); if p then table.insert(cand, p) end
				end
			end
			local tp = cand[selectedVoteSlot] or cand[1]
			if tp then
				tpPos(tp); task.wait(0.45); if not voteEn then break end
				local h = humOf(LP.Character); if h then h.Health=0; h:ChangeState(Enum.HumanoidStateType.Dead) end
				pcall(function() LP.Character:BreakJoints() end)
				local w = 0; repeat task.wait(0.2); w=w+0.2 until not voteEn or (rootOf(LP.Character) and humOf(LP.Character) and humOf(LP.Character).Health>0) or w>=6
			else task.wait(0.5) end
		end
	end)
end)

addAct(P2, "TPMAP", function()
	local r = rootOf(LP.Character); local p = r and nearCoin(r.Position)
	if not p then
		for _, ch in ipairs(workspace:GetChildren()) do
			if not isPlrObj(ch) and ch~=LP.Character and string.lower(ch.Name)~="lobby" then
				p = posOf(ch); if p then break end
			end
		end
	end
	if p then tpPos(p) end
end)

-- RAINBOW FRIENDS
local MON_EXACT = {blue=1,green=1,orange=1,purple=1,red=1,yellow=1,cyan=1}
local RF_ITEMS = {"block","food","ticket","canister","gas","looky","collectible","pickup","toy","sugar","сахар","candy","sweet","treat","lightbulb","bulb","lamp","lantern"}
local rfM, rfI, rfMConn, rfIConn = {}, {}, nil, nil

local function clearList(t) for i=#t,1,-1 do local x=t[i]; if x.hl then x.hl:Destroy() end; if x.bb then x.bb:Destroy() end; t[i]=nil end end
local function makeTag(obj, txt, col, useHl)
	if not obj or not obj.Parent or isPlrObj(obj) then return nil end
	local anc = obj:IsA("BasePart") and obj or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart",true))) or obj:FindFirstChildWhichIsA("BasePart",true)
	if not anc then return nil end
	local hl = useHl and Instance.new("Highlight", obj)
	if hl then hl.Adornee, hl.DepthMode, hl.FillColor, hl.OutlineColor, hl.FillTransparency = obj, Enum.HighlightDepthMode.AlwaysOnTop, col, Color3.new(1,1,1), 0.45 end
	local bb = Instance.new("BillboardGui", anc); bb.Adornee, bb.AlwaysOnTop, bb.MaxDistance, bb.Size, bb.StudsOffset = anc, true, 350, UDim2.fromOffset(135,24), Vector3.new(0,2,0)
	local lb = Instance.new("TextLabel", bb); lb.Size, lb.BackgroundTransparency, lb.Text, lb.TextColor3, lb.TextStrokeTransparency, lb.Font, lb.TextSize = UDim2.fromScale(1,1), 1, txt, Color3.new(1,1,1), 0.15, Enum.Font.GothamBold, 10
	return {o=obj, a=anc, hl=hl, bb=bb, lb=lb, t=txt}
end
local function updDist(t, rp)
	for i=#t,1,-1 do local x=t[i]
		if not x.o or not x.o.Parent or not x.a or not x.a.Parent then if x.hl then x.hl:Destroy() end; if x.bb then x.bb:Destroy() end; table.remove(t,i)
		elseif rp then x.lb.Text = x.t.." ["..math.floor((x.a.Position-rp).Magnitude).."m]" end
	end
end

addBtn(P3, "RFM", function(e)
	if rfMConn then rfMConn:Disconnect(); rfMConn=nil end; clearList(rfM); if not e then return end
	local last = 0
	local function scan()
		for _, d in ipairs(workspace:GetDescendants()) do
			if #rfM>=12 then break end
			if d:IsA("Model") and not isPlrObj(d) then
				local cn = string.gsub(string.lower(d.Name), "[%d%s_%-]+$", "")
				if MON_EXACT[cn] and (d:FindFirstChildOfClass("Humanoid") or d:FindFirstChild("Head")) then
					local dup=false; for _,x in ipairs(rfM) do if x.o==d then dup=true; break end end
					if not dup then local x=makeTag(d,"MONSTER: "..string.upper(d.Name),Color3.fromRGB(255,35,70),true); if x then table.insert(rfM,x) end end
				end
			end
		end
	end
	scan()
	rfMConn = RS.Heartbeat:Connect(function()
		local r = rootOf(LP.Character); updDist(rfM, r and r.Position)
		if os.clock()-last>=2.5 then last=os.clock(); scan() end
	end)
end)

addBtn(P3, "RFI", function(e)
	if rfIConn then rfIConn:Disconnect(); rfIConn=nil end; clearList(rfI); if not e then return end
	local last = 0
	local function scan()
		for _, d in ipairs(workspace:GetDescendants()) do
			if #rfI>=22 then break end
			if (d:IsA("Model") or d:IsA("BasePart") or d:IsA("MeshPart")) and not isPlrObj(d) and not d:FindFirstChildOfClass("Humanoid") then
				local nl = string.lower(d.Name)
				local ok = false; for _, w in ipairs(RF_ITEMS) do if string.find(nl,w,1,true) then ok=true; break end end
				if ok and posOf(d) then
					local dup=false; for _,x in ipairs(rfI) do if x.o==d then dup=true; break end end
					if not dup then local x=makeTag(d,"ITEM: "..string.upper(d.Name),Color3.fromRGB(255,180,35),#rfI<12); if x then table.insert(rfI,x) end end
				end
			end
		end
	end
	scan()
	rfIConn = RS.Heartbeat:Connect(function()
		local r = rootOf(LP.Character); updDist(rfI, r and r.Position)
		if os.clock()-last>=2.5 then last=os.clock(); scan() end
	end)
end)

-- BROOKHAVEN
bClip = addBtn(P4, "CLIP", setClip)

local akEn, akConn, akAnchor = false, nil, nil
addBtn(P4, "AK", function(e)
	akEn = e
	if akConn then akConn:Disconnect(); akConn = nil end
	local r = rootOf(LP.Character)
	if not e or not r then akAnchor = nil; return end
	akAnchor = r.Position
	akConn = RS.Heartbeat:Connect(function()
		local h, rr = humOf(LP.Character), rootOf(LP.Character)
		if not akEn or not h or not rr or not akAnchor then return end
		if h.Sit then
			h.Sit = false
			local weld = rr:FindFirstChildWhichIsA("Weld", true)
			if weld then weld:Destroy() end
		end
		if (rr.Position - akAnchor).Magnitude > 28 then
			rr.AssemblyLinearVelocity = Vector3.zero
			rr.AssemblyAngularVelocity = Vector3.zero
			rr.CFrame = CFrame.new(akAnchor + Vector3.new(0, 1.5, 0))
		else
			akAnchor = rr.Position
		end
	end)
end)

addSlider(P4, "BSPD", ballSpeed, 25, 320, function(v) ballSpeed = v end)
local ballEn, balls = false, {}
local function clrBalls() for i=#balls,1,-1 do if balls[i] and balls[i].Parent then balls[i]:Destroy() end; balls[i]=nil end end

local function launchBall(originPos, dirVec, spdVal)
	local unitDir = (dirVec.Magnitude > 0.001) and dirVec.Unit or Vector3.new(0, 0, -1)
	local spawnPos = originPos + unitDir * 4.5 + Vector3.new(0, 1.5, 0)
	local pt = Instance.new("Part")
	pt.Name = "PurpleBall"
	pt.Shape = Enum.PartType.Ball
	pt.Color = curTheme.Acc
	pt.Material = Enum.Material.Neon
	pt.Size = Vector3.new(2.4, 2.4, 2.4)
	pt.CFrame = CFrame.lookAt(spawnPos, spawnPos + unitDir)
	pt.AssemblyLinearVelocity = unitDir * spdVal
	pt.Parent = workspace
	table.insert(balls, pt)
	if #balls > 25 then
		local oldB = table.remove(balls, 1)
		if oldB and oldB.Parent then oldB:Destroy() end
	end
end

addBtn(P4, "BALLS", function(e)
	ballEn = e; if not e then clrBalls(); return end
	task.spawn(function()
		while ballEn do
			local c, h, r, bp = LP.Character, humOf(LP.Character), rootOf(LP.Character), LP:FindFirstChild("Backpack")
			if c and h and r and h.Health > 0 then
				local cam = workspace.CurrentCamera
				local aimDir = (cam and cam.CFrame.LookVector) or r.CFrame.LookVector
				local tool
				for _, x in ipairs({c, bp}) do
					if x then
						for _, it in ipairs(x:GetChildren()) do
							if it:IsA("Tool") and (string.find(string.lower(it.Name), "basket", 1, true) or string.find(string.lower(it.Name), "ball", 1, true)) then
								tool = it; break
							end
						end
					end
					if tool then break end
				end
				if tool then
					if tool.Parent ~= c then pcall(function() h:EquipTool(tool) end) end
					pcall(function() tool:Activate() end)
					for _, d in ipairs(workspace:GetDescendants()) do
						if d:IsA("BasePart") and (d.Position - r.Position).Magnitude < 20 then
							local n = string.lower(d.Name)
							if string.find(n, "ball", 1, true) or string.find(n, "basket", 1, true) then
								local sp = r.Position + aimDir.Unit * 4 + Vector3.new(0, 1.5, 0)
								d.CFrame = CFrame.lookAt(sp, sp + aimDir)
								d.AssemblyLinearVelocity = aimDir.Unit * ball
