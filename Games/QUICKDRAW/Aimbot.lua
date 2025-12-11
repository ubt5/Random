local UserInputService = cloneref(game:GetService("UserInputService"))
local Players = cloneref(game:GetService("Players"))
local Workspace = cloneref(game:GetService("Workspace"))

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

GetNew = function()
    local ClosestDistance = math.huge
    local ClosestPart = nil
    local MousePos = UserInputService:GetMouseLocation()

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            local Root = Character and Character:FindFirstChild("HumanoidRootPart")

            if Root then
                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)

                if OnScreen then
                    local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude

                    if Dist < ClosestDistance then
                        ClosestDistance = Dist
                        ClosestPart = Character:FindFirstChild("Head")
                    end
                end
            end
        end
    end

    return ClosestPart
end

local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Args = table.pack(...)

    if typeof(Args[1]) == "table" and Args[1].type == "fire" then
        local Target = GetNew()

        if Target then
            task.delay(0.018, function()
                self:FireServer({
                    type = "hit",
                    position = Target.Position,
                    sendTime = tick(),
                    hitPosition = Target.Position + Vector3.new(-1, 0, 0),
                    hit = Target,
                    surface = Vector3.new(),
                    actualDistance = 1,
                    fixedDirection = Vector3.new(-10, 0, -8),
                    direction = Vector3.new()
                })
            end)
        end
    end

    if typeof(Args[1]) == "string" then
        if string.find(Args[1], "Restricted error") or string.find(Args[1], "CoreGui") then
            return
        end
    end

    return __namecall(self, ...)
end)