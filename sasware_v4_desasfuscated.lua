-- why did i bother obfuscating this lol

    LPlayer = game.Players.LocalPlayer
    
        function notify(title,subtitle,timet)
        local CoreGui = game:GetService("CoreGui")
        local CorePackages = game:GetService("CorePackages")
        
        local UIBlox = getrenv().require(CorePackages.UIBlox)
        
        UIBlox.init()
        local StylePalette = getrenv().require(CorePackages.AppTempCommon.LuaApp.Style.StylePalette)
        local stylePalette = StylePalette.new()
        stylePalette:updateTheme("dark")
        stylePalette:updateFont("gotham")
        local Roact = getrenv().require(CorePackages.Roact)
        local Images = getrenv().require(CorePackages.Packages._Index.UIBlox.UIBlox.App.ImageSet.Images)
        
        local Gui = Roact.createElement("ScreenGui", {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Global
        }, {
        Gui = Roact.createElement(UIBlox.Core.Style.Provider, {
        style = stylePalette
        }, {
        Toast = Roact.createElement(UIBlox.App.Dialog.Toast, {
        toastContent = {
        toastTitle = title or "Title",
        toastSubtitle = subtitle or "Subtitle",
        iconImage = Images['icons/status/warning']
        }
        })
        })
        })
        
        Roact.mount(Gui, CoreGui, "InternalStuff")
        wait(timet or 3)
        game:GetService("CoreGui").InternalStuff:Destroy()
    end
    
    if not LPlayer.Character then
        notify("Error","Please spawn in to run the script.",5)
    end
    
    -- hbe jit
    
    local HBESize = Vector3.new(5,5,5)
    LPlayer = game.Players.LocalPlayer
    local inputService = game:GetService("UserInputService")
    local HBEON = false
    local DefHeadSize = game.Players.LocalPlayer.Character:WaitForChild("Head").Size
    local mt = getrawmetatable(game)
    local oIndex = mt.__index
    local oNIndex = mt.__newindex
    local Players, RService = game:GetService"Players", game:GetService"RunService";
    setreadonly(mt,false)
    local lastRender = os.clock()
    game:GetService("RunService").RenderStepped:Connect(function()
    if not ((os.clock()-lastRender)>=0.004)then return end
    lastRender = os.clock()
    for i, v in next, game.Players:GetPlayers()do
    if(v~=LPlayer and v.Character and v.Character:FindFirstChild("Head")and v.Character:FindFirstChild("HumanoidRootPart") and LPlayer.Character and LPlayer.Character:FindFirstChild("HumanoidRootPart"))then
        if(HBEON == true and v.Character:FindFirstChild("Head").Size~=HBESize)then
            v.Character.Head.Size=HBESize
            v.Character.Head.Transparency = 0.5
        elseif(HBEON == false and v.Character:FindFirstChild("Head").Size==HBESize)then
            v.Character.Head.Size=DefHeadSize
            v.Character.Head.Transparency = 0
        end
    end
    end
    end)
    mt.__index = newcclosure(function(tab,key)
        if(not checkcaller() and tab:IsA("Part") and key == "Size")then
            if(oIndex(tab,"Name") == "Head")then
                return DefHeadSize
            end
        end
    return oIndex(tab,key)    
    end)
    
    
    -- hbe jit
    
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
    ESP:Toggle(true)
    ESP.Players = false
    
    ESP:AddObjectListener(game:GetService("Workspace").StaticProps.Resources, {
        Type = "Model",
        Validator = function(obj)
            if string.find(obj.Name, "deposit") and not string.find(obj.Name, "Stone") then
            return true
            else return false
            end
        end,
        Color = function(obj)
                for i,v in pairs(obj.Ores:GetChildren()) do
                    return v.Color
                end end,
        IsEnabled = "OreESP"
    })
    
    ESP:AddObjectListener(game.Workspace.NPCs.Animals, {
        Type = "Folder",
        Validator = function(obj)
            if obj:FindFirstChild("Character") and obj.Character:FindFirstChild("Torso") then
                print(obj)
                return true
            else
                return false
            end
        end,
        PrimaryPart = function(obj)
            return obj.Character:FindFirstChild("HumanoidRootPart")
        end,
        Color = function(obj)
                return obj.Character.Torso.Color end,
        CustomName = function(obj)
            return obj.Character.Torso.BrickColor.Name .. " " ..  obj.Name
        end,
        IsEnabled = "AnimalESP"
    })
    
    ESP:AddObjectListener(game:GetService("Workspace").StaticProps.Resources, {
        Type = "Model",
        Validator = function(obj)
            if string.find(obj.Name, "deposit") and not string.find(obj.Name, "Stone") then
            return true
            else return false
            end
        end,
        Color = function(obj)
                for i,v in pairs(obj.Ores:GetChildren()) do
                    return v.Color
                end end,
        IsEnabled = "OreESP"
    })
    
    
    function TPPlayer(PID)
        game:GetService('TeleportService'):Teleport(PID)
    end
    
    tpcooldown = 0
    
    function TPChar(TargetCFrame)
        if tpcooldown > 0 then
            notify("Teleport","Please wait ".. tostring(tpcooldown) .. " seconds.",3)
            return
        end
        tpcooldown = 3
        pcall(function()
        LPlayer.Character:SetPrimaryPartCFrame(TargetCFrame)
        game:GetService("ReplicatedStorage").DefinEvents.InteractingRequestFall:InvokeServer(game:GetService("ReplicatedStorage").Interacting,0.5)
            end)
    task.spawn(function()
        repeat tpcooldown = tpcooldown - 1 wait(1) until tpcooldown <= 0
    end)
    end
    
    local success, response = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua")
    if not success then return notify("Error","Error loading libraries, please contact developer.",5) end
    
    if success then
    
    library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua"))()
    
    local main = library:Load{
        Name = "sasaware v2 - hostid 1",
        SizeX = 600,
        SizeY = 650,
        Theme = "Midnight",
        Extension = "json", -- config file extension
        Folder = "sasawarenorthwindconfig" -- config folder name
    }
    
    local tab = main:Tab("Character")
    
    
    local section = tab:Section{
        Name = "Teleports",
        Side = "Left"
    }
    local section2 = tab:Section{
        Name = "Movement",
        Side = "Right"
    }
    
    -- speedboost 
        tpwalking = true
        boostspeed = 0
        task.spawn(function()
            local chr = LPlayer.Character
            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
            while true do
                game:GetService("RunService").Heartbeat:Wait()
                if tpwalking and chr and hum and hum.Parent then
                    if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection * boostspeed)
                        end
                    end
                end
        end)
    -- end speedboost (should probably use a coroutine for this)
    
    local speedboostslider = section2:Slider{
        Text = "Speed Boost | [value]/0.3",
        Default = 0,
        Min = 0,
        Max = 0.3,
        Float = 0.05,
        Flag = "SpeedSlider",
        Callback = function(value)
            boostspeed = value
        end
    }
    
    local speedtogglle = section2:Toggle{
        Name = "Speed Toggle",
        Flag = "SpeedToggle",
        --Default = true,
        Callback  = function(bool)
            tpwalking = bool
        end
    }
    speedtogglle:Keybind{
        --Default = Enum.KeyCode.A
        Blacklist = {Enum.UserInputType.MouseButton1},
        Flag = "SpeedKeybind",
        Callback = function(key, fromsetting)
            if not fromsetting then
                SpeedToggle:Toggle(not tpwalking)
            end
        end
    }
    
    cb = nil
    cbs = 1600
    
    local UserInputService = game:GetService("UserInputService")
    
    task.spawn(function()
        while true do
        task.wait()
        pcall(function()
            for i,boat in pairs(game:GetService("Workspace").TargetFilter.Props.Boats:GetChildren()) do 
                if UserInputService:IsKeyDown(Enum.KeyCode.W) == true then
                    boat.Main.BodyThrust.Force = Vector3.new(cbs,0,0)
                end
            end
        end)
    end
    end)
    section2:Slider{
        Text = "Boat Speed | [value]/4000",
        Default = 1600,
        Min = 1600,
        Max = 4000,
        Float = 1,
        Flag = "BoatSpeedSlider",
        Callback = function(value)
               cbs = value
        end
    }
    
    section:Label("---------") -- spacing
    
    local tpDropdown = section:Dropdown{
        Name = "Locations",
        Default = "______",
        Content = {"St Paul","Den","James Bay","Henry's Hill","Criminal Warehouse","Abandoned Camp","St. Paul Cave","Whitehill","Twin Peaks","Cobalt Deposits","Lead Deposits","Iron Deposits","Prison Items","Rupert's Pass Cabin","Fishing Cabin","Fur Trader","Native Camp","Forrester's Grove"},
        Flag = "Theme Dropdown",
        Callback = function(option)
        if option then
            arg = option
        if arg == "St Paul" then
            TPChar(CFrame.new(3168, 111, 561))
        elseif arg == "Den" then
             TPChar(CFrame.new(2768, 56, 3354))
        elseif arg == "James Bay" then
             TPChar(CFrame.new(4163, 78, 2676))
        elseif arg == "Cobalt Deposits" then
             TPChar(CFrame.new(2353, 76, 2440))
        elseif arg == "Lead Deposits" then
             TPChar(CFrame.new(702, 34, 2101))
        elseif arg == "Iron Deposits" then
             TPChar(CFrame.new(3071, -49.5, 2232))
        elseif arg == "Prison Items" then
             TPChar(CFrame.new(1074, 91, 2900))
        elseif arg == "Rupert's Pass Cabin" then
            TPChar(CFrame.new(3515, 72, 1217))
        elseif arg == "Fur Trader" then
             TPChar(CFrame.new(660, 34, 1324))
        elseif arg == "Native Camp" then
             TPChar(CFrame.new(466, 88, 591))
        elseif arg == "Forrester's Grove" then
             TPChar(CFrame.new(1779, 74, 1080))
        elseif arg == "Fishing Shack" then
             TPChar(CFrame.new(1845, 45, 3122))
        elseif arg == "Henry's Hill" then
             TPChar(CFrame.new(3982, 387, 1151))
        elseif arg == "Twin Peaks" then
             TPChar(CFrame.new(2392, 531, 2050))
        elseif arg == "Abandoned Camp" then
             TPChar(CFrame.new(2390, 104, 805))
        elseif arg == "Whitehilll" then
             TPChar(CFrame.new(1756, 165, 1766))
        elseif arg == "St. Paul Cave" then
             TPChar(CFrame.new(4024, 82, 1162))
        elseif arg == "Criminal Warehouse" then
             TPChar(CFrame.new(4046, 117, 409))
        end
            end
        end
    }
    
    local tab2 = main:Tab("Visuals")
    local sectiontab2 = tab2:Section{
        Name = "ESP Toggles",
        Side = "Left"
    }
    
    sectiontab2:Toggle{
        Name = "Player ESP",
        Flag = "PlayerESPToggle",
        Default = false,
        Callback  = function(bool)
            ESP.Players = bool
        end
    }
    sectiontab2:Toggle{
        Name = "Animal ESP",
        Flag = "AnimalESPToggle",
        Default = false,
        Callback  = function(bool)
            ESP.AnimalESP = bool
        end
    }
    sectiontab2:Toggle{
        Name = "Ores ESP",
        Flag = "OresESPToggle",
        Default = false,
        Callback  = function(bool)
            ESP.OreESP = bool
        end
    }
    local tab3 = main:Tab("Combat")
    local sectiontab3 = tab3:Section{
        Name = "Blatant",
        Side = "Left"
    }
    local hbetogglegui = sectiontab3:Toggle{
        Name = "Hitbox Extender",
        Flag = "HBEToggle",
        Default = false,
        Callback  = function(bool)
            HBEON = bool
        end
    }
    
    hbetogglegui:Keybind{
        --Default = Enum.KeyCode.A
        Blacklist = {Enum.UserInputType.MouseButton1},
        Flag = "HBEToggle",
        Callback = function(key, fromsetting)
            if not fromsetting then
                hbetogglegui:Toggle(not HBEON)
            end
        end
    }
    sectiontab3:Slider{
        Text = "HBE Size | [value]/6.5",
        Default = 5,
        Min = 1,
        Max = 6.5,
        Float = 0.5,
        Flag = "HBESlider",
        Callback = function(value)
            HBESize = Vector3.new(value,value,value)
        end
    }
    
    local tab4 = main:Tab("Settings")
    local sectiontab4 = tab4:Section{
        Name = "Main",
        Side = "Left"
    }
    
    sectiontab4:Button{
        Name = "Save Config",
        Callback = function()
            library:SaveConfig("config", true)
        end}
    sectiontab4:Button{
        Name = "Load Config",
        Callback = function()
            library:LoadConfig("config", true)
        end}
    local tpDropdown = section:Dropdown{
        Name = "Islands",
        Default = "______",
        Content = {"Rupert's Island","Cantermagne Island","Beauval"},
        Flag = "Places Dropdown",
        Callback = function(option)
        if option then
            arg = option
        if arg == "Rupert's Island" then
            TPPlayer(5465507265)
        elseif arg == "Cantermagne Island" then
             TPPlayer(5620237741)
        elseif arg == "Beauval" then
            TPPlayer(5620237900)
        end
            end
        end
    }
        
    library:LoadConfig("config", true)
    --library:Close()
    --wait(10)
    --library:Unload()
    end
