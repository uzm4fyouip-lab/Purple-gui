local Plrs, UIS, RS, Ltg = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("Lighting")
local LP = Plrs.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local spd, spnSpd, bSpd, vSlot, hIdx, lang, tIdx = 16, 100, 95, 1, 1, "EN", 1
local winScale, iconPosIdx = 100, 1

local THEMES = {
	{N="PURPLE", Bg=Color3.fromRGB(29,13,46), Hdr=Color3.fromRGB(65,29,100), Btn=Color3.fromRGB(105,45,165), On=Color3.fromRGB(155,75,220), Acc=Color3.fromRGB(195,125,255), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(65,40,85)},
	{N="MIDNIGHT", Bg=Color3.fromRGB(12,18,36), Hdr=Color3.fromRGB(24,38,74), Btn=Color3.fromRGB(38,62,118), On=Color3.fromRGB(65,115,215), Acc=Color3.fromRGB(120,175,255), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(28,42,72)},
	{N="CRIMSON", Bg=Color3.fromRGB(38,12,18), Hdr=Color3.fromRGB(82,22,36), Btn=Color3.fromRGB(132,34,56), On=Color3.fromRGB(205,52,84), Acc=Color3.fromRGB(255,115,145), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(68,24,34)},
	{N="CYBER", Bg=Color3.fromRGB(10,28,30), Hdr=Color3.fromRGB(18,60,66), Btn=Color3.fromRGB(24,96,104), On=Color3.fromRGB(32,175,185), Acc=Color3.fromRGB(90,245,255), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(20,52,58)},
	{N="NEW YEAR", Bg=Color3.fromRGB(14,38,26), Hdr=Color3.fromRGB(135,24,36), Btn=Color3.fromRGB(26,92,58), On=Color3.fromRGB(215,42,56), Acc=Color3.fromRGB(255,210,75), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(22,64,42)},
	{N="BW", Bg=Color3.fromRGB(14,14,14), Hdr=Color3.fromRGB(34,34,34), Btn=Color3.fromRGB(58,58,58), On=Color3.fromRGB(185,185,185), Acc=Color3.fromRGB(255,255,255), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(40,40,40)},
	{N="WB", Bg=Color3.fromRGB(242,242,246), Hdr=Color3.fromRGB(215,215,222), Btn=Color3.fromRGB(185,185,195), On=Color3.fromRGB(38,38,44), Acc=Color3.fromRGB(12,12,14), Txt=Color3.fromRGB(15,15,18), Trk=Color3.fromRGB(195,195,205)},
	{N="OW", Bg=Color3.fromRGB(248,244,238), Hdr=Color3.fromRGB(235,115,25), Btn=Color3.fromRGB(245,145,45), On=Color3.fromRGB(210,80,10), Acc=Color3.fromRGB(255,120,20), Txt=Color3.fromRGB(25,20,16), Trk=Color3.fromRGB(225,205,185)},
	{N="BG", Bg=Color3.fromRGB(10,14,11), Hdr=Color3.fromRGB(18,34,22), Btn=Color3.fromRGB(26,56,34), On=Color3.fromRGB(45,195,85), Acc=Color3.fromRGB(110,255,140), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(18,38,24)},
	{N="AMETHYST", Bg=Color3.fromRGB(24,14,38), Hdr=Color3.fromRGB(58,32,92), Btn=Color3.fromRGB(92,52,142), On=Color3.fromRGB(168,92,235), Acc=Color3.fromRGB(225,165,255), Txt=Color3.new(1,1,1), Trk=Color3.fromRGB(48,28,74)}
}

local ICON_POS = {
	{N="RIGHT", Pos=UDim2.new(1,-68,0.5,-27)},
	{N="LEFT", Pos=UDim2.new(0,14,0.5,-27)},
	{N="TOP", Pos=UDim2.new(0.5,-27,0,14)},
	{N="BOTTOM", Pos=UDim2.new(0.5,-27,1,-68)}
}

local L = {
	EN={T1="UNIV",T2="MM2",T3="RF",T4="BHAVEN",T5="DOORS",T6="SET",SPD="SPEED",SPN="SPIN",ESP="ESP",RAIN="RAIN SHADER",MORNING="MORNING",AFTERNOON="AFTERNOON",MIDDAY="MIDDAY",EVENING="EVENING",NIGHT="NIGHT",MIDNIGHT="MIDNIGHT",MORNING_LITE="MORNING LITE",AFTERNOON_LITE="AFTERNOON LITE",MIDDAY_LITE="MIDDAY LITE",EVENING_LITE="EVENING LITE",NIGHT_LITE="NIGHT LITE",MIDNIGHT_LITE="MIDNIGHT LITE",TK="TELEKINESIS",TP10="TP +10",HIDE="HIDE +30",BHOP="BHOP",FLY="FLY",CLIP="NOCLIP",LAG="LAG",USPIN="ULTRA SPIN",CHAOS="CHAOS",RESP="ROLE ESP",SHOOT="AUTO SHOOT",KILL="KILL ALL",COIN="COIN FARM",VSLOT="VOTE SLOT",VOTE="VOTE+RESET",TPMAP="TP MAP",RFM="MONSTERS",RFI="ITEMS",AK="ANTI-KICK",BSPD="BALL SPD",BALLS="SPAM BALLS",PH="HOUSE",TPH="TP HOUSE",CIH="CAR IN HOUSE",HBALL="BALL BARRAGE",DALERT="ALERT R/A",DAHIDE="AUTO HIDE",DFKEY="FAST KEY",DALOOT="AUTO LOOT",DLIGHT="SOFT LIGHT",DMESP="MONSTER ESP",DCESP="COIN ESP",DKESP="KEY ESP",DBKESP="BOOK ESP",DWRD="WARDROBE ESP",DITM="ITEM ESP",DBRE="BREAKER ESP",DSRK="SEEK ESP",DDOR="DOOR ESP",DSAFE="SAFE SPEED",NONE="NONE",LANG="LANG",THEME="THEME",WSIZE="WIN SIZE",IPOS="ICON POS",CLOSE="CLOSE SCRIPT"},
	RU={T1="УНИВ",T2="MM2",T3="RF",T4="BHAVEN",T5="DOORS",T6="НАСТ",SPD="СКОРОСТЬ",SPN="КРУТКА",ESP="ЕСП",RAIN="ДОЖДЬ ШЕЙДЕР",MORNING="УТРО",AFTERNOON="ДЕНЬ",MIDDAY="ПОЛДЕНЬ",EVENING="ВЕЧЕР",NIGHT="НОЧЬ",MIDNIGHT="ПОЛНОЧЬ",MORNING_LITE="УТРО LITE",AFTERNOON_LITE="ДЕНЬ LITE",MIDDAY_LITE="ПОЛДЕНЬ LITE",EVENING_LITE="ВЕЧЕР LITE",NIGHT_LITE="НОЧЬ LITE",MIDNIGHT_LITE="ПОЛНОЧЬ LITE",TK="ТЕЛЕКИНЕЗ",TP10="ТП +10",HIDE="СКРЫТЬ +30",BHOP="БАННИ ХОП",FLY="ПОЛЁТ",CLIP="NOCLIP",LAG="ЛАГ",USPIN="УЛЬТРА КРУТ",CHAOS="ХАОС",RESP="РОЛИ ЕСП",SHOOT="АВТОВЫСТРЕЛ",KILL="УБИТЬ ВСЕХ",COIN="ФАРМ МОНЕТ",VSLOT="СЛОТ ГОЛОСА",VOTE="ГОЛОС+РЕСЕТ",TPMAP="ТП КАРТА",RFM="МОНСТРЫ",RFI="ВЕЩИ",AK="АНТИ-КИК",BSPD="СК. МЯЧЕЙ",BALLS="СПАМ МЯЧАМИ",PH="ДОМ",TPH="ТП В ДОМ",CIH="МАШИНА В ДОМ",HBALL="ЗАЛП МЯЧАМИ",DALERT="ТРЕВОГА R/A",DAHIDE="АВТО ПРЯТКИ",DFKEY="БЫСТРЫЙ КЛЮЧ",DALOOT="АВТО ЛУТ",DLIGHT="МЯГКИЙ СВЕТ",DMESP="МОНСТР ЕСП",DCESP="МОНЕТЫ ЕСП",DKESP="КЛЮЧИ ЕСП",DBKESP="КНИГИ ЕСП",DWRD="ШКАФЫ ЕСП",DITM="ВЕЩИ ЕСП",DBRE="ЩИТОК ЕСП",DSRK="СИК ЕСП",DDOR="ДВЕРЬ ЕСП",DSAFE="БЕЗОП. БЕГ",NONE="НЕТ",LANG="ЯЗЫК",THEME="ТЕМА",WSIZE="РАЗМЕР ОКНА",IPOS="ПОЗИЦИЯ ИКОНКИ",CLOSE="ЗАКРЫТЬ СКРИПТ"}
}
local function tr(k) return (L[lang] and L[lang][k]) or L.EN[k] or k end

for _, n in ipairs({"PurpleGUIV15","PurpleGUIV16","PurpleGUIV1_1"}) do local o = PG:FindFirstChild(n) if o then o:Destroy() end end

local GUI = Instance.new("ScreenGui"); GUI.Name="PurpleGUIV1_1"; GUI.ResetOnSpawn=false; GUI.Parent=PG
local Alert = Instance.new("TextLabel"); Alert.Size=UDim2.new(0.6,0,0,34); Alert.Position=UDim2.new(0.2,0,0.1,0); Alert.BackgroundColor3=Color3.fromRGB(45,10,18); Alert.TextColor3=Color3.fromRGB(255,95,95); Alert.Font=Enum.Font.GothamBlack; Alert.TextSize=14; Alert.Visible=false; Alert.ZIndex=30; Alert.Parent=GUI
Instance.new("UICorner",Alert).CornerRadius=UDim.new(0,8)

local BASE_W, BASE_H = 274, 276
local Main = Instance.new("Frame"); Main.Size=UDim2.fromOffset(BASE_W,BASE_H); Main.Position=UDim2.new(0.5,-137,0.34,0); Main.BorderSizePixel=0; Main.Active=true; Main.Parent=GUI
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,12)
local Out = Instance.new("UIStroke"); Out.Thickness=2; Out.Parent=Main

local Hdr = Instance.new("Frame"); Hdr.Size=UDim2.new(1,0,0,32); Hdr.BorderSizePixel=0; Hdr.Active=true; Hdr.Parent=Main
Instance.new("UICorner",Hdr).CornerRadius=UDim.new(0,12)

local Title = Instance.new("TextLabel"); Title.Size=UDim2.new(1,-34,1,0); Title.Position=UDim2.fromOffset(6,0); Title.BackgroundTransparency=1; Title.Text="PURPLE GUI V1.1"; Title.Font=Enum.Font.GothamBold; Title.TextSize=13; Title.Parent=Hdr
local HideBtn = Instance.new("TextButton"); HideBtn.Size=UDim2.fromOffset(26,24); HideBtn.Position=UDim2.new(1,-30,0,4); HideBtn.Text="—"; HideBtn.Font=Enum.Font.GothamBold; HideBtn.TextSize=16; HideBtn.Parent=Hdr
Instance.new("UICorner",HideBtn).CornerRadius=UDim.new(0,6)

local OpenBtn = Instance.new("ImageButton")
OpenBtn.Size = UDim2.fromOffset(54, 54)
OpenBtn.Position = ICON_POS[iconPosIdx].Pos
OpenBtn.BackgroundTransparency = 1
OpenBtn.BorderSizePixel = 0
OpenBtn.Image = "rbxassetid://5904584265"
OpenBtn.Visible = false
OpenBtn.ZIndex = 20
OpenBtn.Parent = GUI

HideBtn.MouseButton1Click:Connect(function() Main.Visible, OpenBtn.Visible = false, true end)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible, OpenBtn.Visible = true, false end)

local drag, dS, sP
Hdr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag,dS,sP=true,i.Position,Main.Position end end)
UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then local d=i.Position-dS; Main.Position=UDim2.new(sP.X.Scale,sP.X.Offset+d.X,sP.Y.Scale,sP.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)

local refList, btnRefs, fRefs, trkRefs, txtRefs = {}, {}, {}, {}, {}
local curT = THEMES[1]
local syncEsp

local function applyWinSize()
	local k = winScale / 100
	local w = math.floor(BASE_W * k + 0.5)
	local h = math.floor(BASE_H * k + 0.5)
	Main.Size = UDim2.fromOffset(w, h)
end

local TabBar = Instance.new("Frame"); TabBar.Position=UDim2.fromOffset(4,38); TabBar.Size=UDim2.new(1,-8,0,26); TabBar.BackgroundTransparency=1; TabBar.Parent=Main
local activeTab = "U"
local tabs = {}
local function makeTab(id, k, x, w)
	local b = Instance.new("TextButton"); b.Size=UDim2.new(w,-2,1,0); b.Position=UDim2.new(x,0,0,0); b.Font=Enum.Font.GothamBold; b.TextSize=7; b.Text=tr(k); b.Parent=TabBar
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
	table.insert(txtRefs,b); table.insert(refList,function() b.Text=tr(k) end)
	tabs[id]=b; return b
end
makeTab("U","T1",0,0.16); makeTab("M","T2",0.16,0.12); makeTab("R","T3",0.28,0.11); makeTab("B","T4",0.39,0.20); makeTab("D","T5",0.59,0.19); makeTab("S","T6",0.78,0.22)

local pages = {}
for id, k in pairs({U="T1",M="T2",R="T3",B="T4",D="T5",S="T6"}) do
	local p = Instance.new("ScrollingFrame"); p.Position=UDim2.fromOffset(7,70); p.Size=UDim2.new(1,-14,1,-76); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.ScrollBarThickness=4; p.AutomaticCanvasSize=Enum.AutomaticSize.Y; p.CanvasSize=UDim2.new(0,0,0,0); p.Visible=(id=="U"); p.Parent=Main
	local l = Instance.new("UIListLayout"); l.Padding=UDim.new(0,6); l.SortOrder=Enum.SortOrder.LayoutOrder; l.Parent=p
	pages[id]=p
end
local P1,P2,P3,P4,P5,P6 = pages.U,pages.M,pages.R,pages.B,pages.D,pages.S

local function paint()
	Main.BackgroundColor3 = curT.Bg
	Hdr.BackgroundColor3 = curT.Hdr; Out.Color = curT.Acc
	for _, f in ipairs(fRefs) do f.o.BackgroundColor3 = curT[f.k] end
	for _, trk in ipairs(trkRefs) do trk.BackgroundColor3 = curT.Trk end
	for _, tx in ipairs(txtRefs) do tx.TextColor3 = curT.Txt end
	for _, b in ipairs(btnRefs) do b.o.BackgroundColor3 = (b.fn and b.fn()) and curT.On or curT.Btn end
	for id, b in pairs(tabs) do b.BackgroundColor3 = (activeTab==id) and curT.On or curT.Btn end
	if syncEsp then syncEsp() end
end
for id, b in pairs(tabs) do b.MouseButton1Click:Connect(function() activeTab=id; for k,p in pairs(pages) do p.Visible=(k==id) end; paint() end) end

local function addBtn(p, k, cb)
	local b = Instance.new("TextButton"); b.Size=UDim2.new(1,-2,0,40); b.Font,b.TextSize,b.AutoButtonColor=Enum.Font.GothamBold,11,false; b.Parent=p
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
	local en=false; local function upd() b.Text=tr(k)..(en and " : ON" or " : OFF") end; local function setV(v) en=v; upd(); paint() end
	upd(); table.insert(txtRefs,b); table.insert(btnRefs,{o=b,fn=function() return en end}); table.insert(refList,upd)
	b.MouseButton1Click:Connect(function() setV(not en); cb(en) end); return {SetState=setV,Upd=upd}
end

local function addAct(p, k, cb)
	local b = Instance.new("TextButton"); b.Size=UDim2.new(1,-2,0,40); b.Text,b.Font,b.TextSize=tr(k),Enum.Font.GothamBold,11; b.Parent=p
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
	table.insert(txtRefs,b); table.insert(btnRefs,{o=b}); table.insert(refList,function() b.Text=tr(k) end)
	b.MouseButton1Click:Connect(function() b.BackgroundColor3=curT.On; cb(); task.delay(0.1,paint) end); return b
end

local function addSld(p, k, init, mn, mx, cb)
	local f = Instance.new("Frame"); f.Size,f.BorderSizePixel=UDim2.new(1,-2,0,54),0; f.Parent=p
	Instance.new("UICorner",f).CornerRadius=UDim.new(0,9); table.insert(fRefs,{o=f,k="Btn"})
	local lbl = Instance.new("TextLabel"); lbl.Position,lbl.Size,lbl.BackgroundTransparency=UDim2.fromOffset(8,3),UDim2.new(1,-16,0,18),1; lbl.Font,lbl.TextSize,lbl.TextXAlignment=Enum.Font.GothamBold,12,Enum.TextXAlignment.Left; lbl.Parent=f
	table.insert(txtRefs,lbl)
	local trk = Instance.new("Frame"); trk.Position,trk.Size,trk.BorderSizePixel=UDim2.new(0,8,0,32),UDim2.new(1,-16,0,7),0; trk.Parent=f
	Instance.new("UICorner",trk).CornerRadius=UDim.new(1,0); table.insert(trkRefs,trk)
	local fill = Instance.new("Frame"); fill.BorderSizePixel=0; fill.Parent=trk; Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0); table.insert(fRefs,{o=fill,k="Acc"})
	local knob = Instance.new("Frame"); knob.AnchorPoint,knob.Size,knob.BorderSizePixel=Vector2.new(0.5,0.5),UDim2.fromOffset(14,14),0; knob.Parent=trk; Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0); table.insert(fRefs,{o=knob,k="Txt"})
	local val,dr,ai=init,false,nil
	local function updL() lbl.Text=tr(k)..": "..val end; updL(); table.insert(refList,updL)
	local function setP(pct) pct=math.clamp(pct,0,1); val=math.floor(mn+pct*(mx-mn)+0.5); fill.Size,knob.Position=UDim2.new(pct,0,1,0),UDim2.new(pct,0,0.5,0); updL(); cb(val) end
	setP((init-mn)/(mx-mn))
	trk.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr,ai=true,i; if trk.AbsoluteSize.X>0 then setP((i.Position.X-trk.AbsolutePosition.X)/trk.AbsoluteSize.X) end end end)
	UIS.InputChanged:Connect(function(i) if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i==ai) and trk.AbsoluteSize.X>0 then setP((i.Position.X-trk.AbsolutePosition.X)/trk.AbsoluteSize.X) end end)
	UIS.InputEnded:Connect(function(i) if i==ai or i.UserInputType==Enum.UserInputType.MouseButton1 then dr,ai=false,nil end end)
end

local function root(c) return c and c:FindFirstChild("HumanoidRootPart") end
local function hum(c) return c and c:FindFirstChildOfClass("Humanoid") end
local function posOf(o)
	if not o or not o.Parent then return nil end
	if o:IsA("BasePart") then return o.Position end
	local p = o:FindFirstChildWhichIsA("BasePart",true); return p and p.Position
end
local function isPlr(o)
	local cur=o; while cur and cur~=workspace do if cur:IsA("Model") and Plrs:GetPlayerFromCharacter(cur) then return true end; cur=cur.Parent end; return false
end
local function tp(p) local r=root(LP.Character); if r and p then r.AssemblyLinearVelocity=Vector3.zero; r.CFrame=CFrame.new(p+Vector3.new(0,3,0)) end end

local bhopE,chaosE,clipE,hideE,flyE,spnE,invE,uEspE,safeE,lagE=false,false,false,false,false,false,false,false,false,false
local bhopC,chaosC,clipC,hideC,flyC,spnC,uEspC,safeC,lagC
local bBoost,hAnch,hOrig,oldCol={0,nil,nil,{}}
local function setSpd() local h=hum(LP.Character); if h and not chaosE then h.WalkSpeed = safeE and 21 or (bhopE and math.clamp(spd+bBoost,16,185) or spd) end end

-- UNIV ESP & SHADERS
syncEsp = function()
	for _, p in ipairs(Plrs:GetPlayers()) do
		if p~=LP and p.Character then
			local hl = p.Character:FindFirstChild("PurpleEsp")
			if not uEspE then if hl then hl:Destroy() end
			else
				if not hl then hl=Instance.new("Highlight"); hl.Name="PurpleEsp"; hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.FillTransparency=0.45; hl.Adornee=p.Character; hl.Parent=p.Character end
				hl.FillColor, hl.OutlineColor = curT.Acc, curT.On
			end
		end
	end
end
addBtn(P1,"ESP",function(e) uEspE=e; if uEspC then uEspC:Disconnect(); uEspC=nil end; syncEsp(); if e then uEspC=RS.Heartbeat:Connect(syncEsp) end end)

local shMode, shConn, rainP, origL, hiddenSky = nil, nil, {}, nil, {}
local shBtns = {}

local function clrRain()
	for i = #rainP, 1, -1 do
		if rainP[i] and rainP[i].Parent then rainP[i]:Destroy() end
		rainP[i] = nil
	end
end

local function makeSky(mid, top, sunSz, starCnt)
	for _, c in ipairs(Ltg:GetChildren()) do
		if c:IsA("Sky") or c:IsA("Atmosphere") then
			c.Parent = nil
			table.insert(hiddenSky, c)
		end
	end
	local sky = Instance.new("Sky")
	sky.Name = "PurSh_Sky"
	sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = "", "", "", "", "", ""
	sky.StarCount = starCnt or 0
	sky.SunAngularSize = sunSz or 18
	sky.MoonAngularSize = 14
	sky.CelestialBodiesShown = true
	sky.Parent = Ltg

	local atm = Instance.new("Atmosphere")
	atm.Name = "PurSh_Atm"
	atm.Density = 0.32
	atm.Offset = 0.25
	atm.Color = mid
	atm.Decay = top
	atm.Glare = 0.35
	atm.Haze = 1.6
	atm.Parent = Ltg
	return sky, atm
end

local function clrSh()
	if shConn then shConn:Disconnect(); shConn = nil end
	clrRain()
	for _, c in ipairs(Ltg:GetChildren()) do
		if string.sub(c.Name,1,6)=="PurSh_" then c:Destroy() end
	end
	for _, s in ipairs(hiddenSky) do
		if s then pcall(function() s.Parent = Ltg end) end
	end
	table.clear(hiddenSky)
	if origL then
		pcall(function() for k,v in pairs(origL) do
