-- [[ số1kẹocon Hub - Ultimate Aimbot & Fixed Key Edition ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "số1kẹocon Hub",
   LoadingTitle = "Đang khởi động số1kẹocon...",
   LoadingSubtitle = "Bản đã fix Key & Thêm Aimbot",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = true, -- Hệ thống Key đã được sửa lỗi hoàn chỉnh
   KeySettings = {
      Title = "Xác Nhận Key",
      Subtitle = "Nhập Key để sử dụng Menu",
      Note = "Key chính xác của bạn là: ngọt",
      FileName = "So1KeoConKeyFixed",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"ngọt"}
   }
})

-- Biến trạng thái cốt lõi
local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local SpeedVal = 16
local JumpVal = 50
local Noclip = false
local Fly = false
local GodMode = false
local AutoKill = false
local InfJump = false
local ESPEnabled = false
local HitboxExpander = false
local HitboxSize = 5
local IsShrink = false
local AutoWin = false
local AntiVoid = false
local FullBright = false
local CustomFOV = 70
local Invisibility = false
local AutoClicker = false
local AntiAFK = true
local SpinBot = false
local NoFog = false
local XrayEnabled = false
local InfiniteZoomEnabled = false
local AutoInteractEnabled = false
local CtrlTpEnabled = false
local InfStaminaEnabled = false

-- Biến tính năng Aimbot MỚI THÊM
local AimbotEnabled = false
local AimbotPart = "Head" -- Mặc định ngắm vào đầu (Head)


-- ================= TAB 1: CHÍNH & DI CHUYỂN =================
local MainTab = Window:CreateTab("Chính & Di Chuyển", 4483362458)

MainTab:CreateSection("Tốc độ & Nhảy cơ bản")

MainTab:CreateSlider({
   Name = "Tốc độ (Speed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      SpeedVal = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

MainTab:CreateSlider({
   Name = "Độ cao Nhảy (Jump)",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      JumpVal = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

game:GetService("RunService").RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = SpeedVal
        LocalPlayer.Character.Humanoid.JumpPower = JumpVal
    end
end)

MainTab:CreateSection("Hệ thống di chuyển đặc biệt")

MainTab:CreateToggle({
   Name = "Xuyên Tường (Noclip)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      Noclip = Value
   end,
})

game:GetService("RunService").Stepped:Connect(function()
    if Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

MainTab:CreateToggle({
   Name = "Bay (Fly)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      Fly = Value
      local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
      if Fly and HRP then
         local BV = Instance.new("BodyVelocity", HRP)
         BV.Name = "FlyVelocity"
         BV.Velocity = Vector3.new(0,0,0)
         BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         
         local BG = Instance.new("BodyGyro", HRP)
         BG.Name = "FlyGyro"
         BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         BG.CFrame = HRP.CFrame
         
         task.spawn(function()
            while Fly do
               task.wait()
               local cam = workspace.CurrentCamera
               BG.CFrame = cam.CFrame
               local move = Vector3.new()
               local uis = game:GetService("UserInputService")
               if uis:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
               if uis:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
               if uis:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
               if uis:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
               BV.Velocity = move * 50
            end
            if HRP:FindFirstChild("FlyVelocity") then HRP.FlyVelocity:Destroy() end
            if HRP:FindFirstChild("FlyGyro") then HRP.FlyGyro:Destroy() end
         end)
      else
         if HRP then
            if HRP:FindFirstChild("FlyVelocity") then HRP.FlyVelocity:Destroy() end
            if HRP:FindFirstChild("FlyGyro") then HRP.FlyGyro:Destroy() end
         end
      end
   end,
})

MainTab:CreateToggle({
   Name = "Nhảy Vô Tận (Inf Jump)",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
      InfJump = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

MainTab:CreateToggle({
   Name = "Thu Nhỏ Nhân Vật (Mini)",
   CurrentValue = false,
   Flag = "ShrinkToggle",
   Callback = function(Value)
      IsShrink = Value
      local char = LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
         pcall(function()
            local desc = char.Humanoid:GetAppliedDescription()
            if IsShrink then
               desc.HeadScale = 0.4
               desc.HeightScale = 0.4
               desc.WidthScale = 0.4
               desc.DepthScale = 0.4
            else
               desc.HeadScale = 1
               desc.HeightScale = 1
               desc.WidthScale = 1
               desc.DepthScale = 1
            end
            char.Humanoid:ApplyDescription(desc)
         end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Chống Rơi Vực (Anti-Void)",
   CurrentValue = false,
   Flag = "AntiVoidToggle",
   Callback = function(Value)
      AntiVoid = Value
      task.spawn(function()
         while AntiVoid do
            task.wait(0.2)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               if char.HumanoidRootPart.Position.Y < -50 then
                  char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
                  char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
               end
            end
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Ctrl + Click Dịch Chuyển (Ctrl+TP)",
   CurrentValue = false,
   Flag = "CtrlTpToggle",
   Callback = function(Value)
      CtrlTpEnabled = Value
      if CtrlTpEnabled then
         local connection
         connection = Mouse.Button1Down:Connect(function()
            if not CtrlTpEnabled then 
               connection:Disconnect()
               return 
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightControl) then
               if Mouse.Target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                  LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
               end
            end
         end)
      end
   end,
})


-- ================= TAB 2: COMBAT & AIMBOT =================
local CombatTab = Window:CreateTab("Combat & Aimbot", 4483362458)

CombatTab:CreateSection("Hệ Thống Aimbot (Tự Động Ngắm)")

CombatTab:CreateToggle({
   Name = "Bật Aimbot (Tự động khóa mục tiêu)",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      AimbotEnabled = Value
   end,
})

CombatTab:CreateDropdown({
   Name = "Chọn vị trí khóa Aimbot",
   Options = {"Head", "HumanoidRootPart"},
   CurrentOption = "Head",
   Flag = "AimbotPartDropdown",
   Callback = function(Option)
      AimbotPart = Option
   end,
})

-- Hàm chạy Aimbot liên tục
game:GetService("RunService").RenderStepped:Connect(function()
   if AimbotEnabled then
      pcall(function()
         local closestPlayer = nil
         local shortestDistance = math.huge
         
         for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
               local targetPart = player.Character:FindFirstChild(AimbotPart)
               if targetPart then
                  local screenPoint, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                  if onScreen then
                     local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                     local targetPos = Vector2.new(screenPoint.X, screenPoint.Y)
                     local distance = (mousePos - targetPos).Magnitude
                     
                     if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = targetPart
                     end
                  end
               end
            end
         end
         
         if closestPlayer then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Position)
         end
      end)
   end
end)

CombatTab:CreateSection("Bản lĩnh chiến đấu")

CombatTab:CreateToggle({
   Name = "Bất Tử (GodMode Fix)",
   CurrentValue = false,
   Flag = "GodModeToggle",
   Callback = function(Value)
      GodMode = Value
      task.spawn(function()
         while GodMode do
            task.wait(0.1)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
               char.Humanoid.Health = char.Humanoid.MaxHealth
               if char.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                  char.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
               end
            end
         end
      end)
   end,
})

CombatTab:CreateToggle({
   Name = "Tự Động Diệt (Auto Kill)",
   CurrentValue = false,
   Flag = "AutoKillToggle",
   Callback = function(Value)
      AutoKill = Value
      task.spawn(function()
         while AutoKill do
            task.wait(0.2)
            for _, target in pairs(game.Players:GetPlayers()) do
               if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
                  local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                  if tool then tool:Activate() end
                  if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("HumanoidRootPart") then
                     LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                  end
               end
            end
         end
      end)
   end,
})

CombatTab:CreateToggle({
   Name = "Nhìn Xuyên Tường (ESP)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      ESPEnabled = Value
      task.spawn(function()
         while ESPEnabled do
            task.wait(1)
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                  if not p.Character.Head:FindFirstChild("ESP_Highlight") then
                     local hl = Instance.new("Highlight", p.Character.Head)
                     hl.Name = "ESP_Highlight"
                     hl.Adornee = p.Character
                     hl.FillColor = Color3.fromRGB(255, 0, 0)
                     hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                  end
               end
            end
         end
      end)
      if not ESPEnabled then
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
               local hl = p.Character.Head:FindFirstChild("ESP_Highlight")
               if hl then hl:Destroy() end
            end
         end
      end
   end,
})

CombatTab:CreateToggle({
   Name = "Phóng to Hitbox",
   CurrentValue = false,
   Flag = "HitboxToggle",
   Callback = function(Value)
      HitboxExpander = Value
      task.spawn(function()
         while HitboxExpander do
            task.wait(0.5)
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  p.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                  p.Character.HumanoidRootPart.Transparency = 0.7
                  p.Character.HumanoidRootPart.CanCollide = false
               end
            end
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Cỡ Hitbox",
   Range = {2, 20},
   Increment = 1,
   CurrentValue = 5,
   Flag = "HitboxSlider",
   Callback = function(Value)
      HitboxSize = Value
   end,
})

CombatTab:CreateSection("Auto Win (Tự Động Thắng)")

CombatTab:CreateToggle({
   Name = "Tự Động Chiến Thắng (Auto Win)",
   CurrentValue = false,
   Flag = "AutoWinToggle",
   Callback = function(Value)
      AutoWin = Value
      task.spawn(function()
         while AutoWin do
            task.wait(0.5)
            pcall(function()
               for _, obj in pairs(workspace:GetDescendants()) do
                  if obj:IsA("BasePart") and (obj.Name:lower():find("win") or obj.Name:lower():find("finish") or obj.Name:lower():find("end") or obj.Name:lower():find("goal")) then
                     if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                     end
                  end
               end
            end)
         end
      end)
   end,
})


-- ================= TAB 3: TIỆN ÍCH & TÍNH NĂNG MỚI =================
local UtilityTab = Window:CreateTab("Tiện Ích Mới", 4483362458)

UtilityTab:CreateSection("Môi trường & Đồ họa")

UtilityTab:CreateToggle({
   Name = "Sáng Toàn Bản Đồ (Fullbright)",
   CurrentValue = false,
   Flag = "FullBrightToggle",
   Callback = function(Value)
      FullBright = Value
      task.spawn(function()
         while FullBright do
            task.wait(1)
            pcall(function()
               game:GetService("Lighting").Brightness = 2
               game:GetService("Lighting").ClockTime = 14
               game:GetService("Lighting").FogEnd = 100000
               game:GetService("Lighting").GlobalShadows = false
            end)
         end
      end)
   end,
})

UtilityTab:CreateSlider({
   Name = "Góc Nhìn (FOV Changer)",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Flag = "FOVSetting",
   Callback = function(Value)
      CustomFOV = Value
      pcall(function()
         workspace.CurrentCamera.FieldOfView = CustomFOV
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Xóa Sương Mù (No Fog)",
   CurrentValue = false,
   Flag = "NoFogToggle",
   Callback = function(Value)
      NoFog = Value
      task.spawn(function()
         while NoFog do
            task.wait(1)
            pcall(function()
               game:GetService("Lighting").FogEnd = 999999
            end)
         end
      end)
   end,
})

UtilityTab:CreateSection("Tính năng nâng cao đặc biệt")

UtilityTab:CreateToggle({
   Name = "Thể Lực / Năng Lượng Vô Tận (Inf Stamina)",
   CurrentValue = false,
   Flag = "InfStaminaToggle",
   Callback = function(Value)
      InfStaminaEnabled = Value
      task.spawn(function()
         while InfStaminaEnabled do
            task.wait(0.2)
            pcall(function()
               local char = LocalPlayer.Character
               if char then
                  for _, v in pairs(char:GetDescendants()) do
                     if v:IsA("NumberValue") and (v.Name:lower():find("stamina") or v.Name:lower():find("energy")) then
                        v.Value = 99999
                     end
                  end
               end
            end)
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Lại Gần Là Hát Văn (Auto Interact)",
   CurrentValue = false,
   Flag = "AutoInteractToggle",
   Callback = function(Value)
      AutoInteractEnabled = Value
      task.spawn(function()
         while AutoInteractEnabled do
            task.wait(0.2)
            pcall(function()
               for _, v in pairs(workspace:GetDescendants()) do
                  if v:IsA("ProximityPrompt") then
                     v.HoldDuration = 0
                     fireproximityprompt(v)
                  end
               end
            end)
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "X-Ray (Xuyên tường vật thể)",
   CurrentValue = false,
   Flag = "XrayToggle",
   Callback = function(Value)
      XrayEnabled = Value
      pcall(function()
         for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
               part.Transparency = XrayEnabled and 0.5 or 0
            end
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Zoom Vô Cực (Infinite Zoom)",
   CurrentValue = false,
   Flag = "InfZoomToggle",
   Callback = function(Value)
      InfiniteZoomEnabled = Value
      pcall(function()
         if InfiniteZoomEnabled then
            LocalPlayer.CameraMaxZoomDistance = 999999
         else
            LocalPlayer.CameraMaxZoomDistance = 400
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Tàng Hình (Invisibility)",
   CurrentValue = false,
   Flag = "InvisToggle",
   Callback = function(Value)
      Invisibility = Value
      pcall(function()
         local char = LocalPlayer.Character
         if char then
            for _, v in pairs(char:GetDescendants()) do
               if v:IsA("BasePart") or v:IsA("Decal") then
                  v.Transparency = Invisibility and 1 or 0
               end
            end
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Tự Động Nhấp Chuột (Auto Clicker)",
   CurrentValue = false,
   Flag = "AutoClickToggle",
   Callback = function(Value)
      AutoClicker = Value
      task.spawn(function()
         while AutoClicker do
            task.wait(0.05)
            pcall(function()
               mouse1click()
            end)
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Chống AFK (Anti-AFK)",
   CurrentValue = true,
   Flag = "AntiAFKToggle",
   Callback = function(Value)
      AntiAFK = Value
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
         if AntiAFK then
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         end
      end)
   end,
})

UtilityTab:CreateToggle({
   Name = "Quay Vòng Tròn (Spinbot)",
   CurrentValue = false,
   Flag = "SpinbotToggle",
   Callback = function(Value)
      SpinBot = Value
      task.spawn(function()
         while SpinBot do
            task.wait()
            pcall(function()
               local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRo
