--[[
    This handler is responsible for what occurs when the various player action
    buttons fire.

    I.e PrimaryAction (LeftMouse), Secondary Action (Right Mouse), ect...
]]

local UserInputService = game:GetService("UserInputService")

-- Events
local SecondaryActionBeganRemoteFunction = game.ReplicatedStorage.Event.SecondaryActionBegan
local PrimaryActionEndedRemoteFunction = game.ReplicatedStorage.Event.PrimaryActionEnded
local SecondaryActionEndedRemoteFunction = game.ReplicatedStorage.Event.SecondaryActionEnded

local OnPrimaryAction = script.OnPrimaryAction

local function inputBegan(input, isProcess)
    if isProcess then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Primary Action
        -- NOTE: The remote function `PrimaryActionBeganRemoteEvent:InvokeServer()` has been moved to script Character/onPrimaryAction
        OnPrimaryAction:Fire()
    end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        -- Primary Action
        local response = SecondaryActionBeganRemoteFunction:InvokeServer(input)
    end

end

local function inputEnded(input, isProcess)
    if isProcess then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Primary Action
        --local response = PrimaryActionEndedRemoteFunction:InvokeServer()
    end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        -- Secondary Action
        --local response = SecondaryActionEndedRemoteFunction:InvokeServer()
    end

end

UserInputService.InputBegan:Connect(inputBegan)
UserInputService.InputEnded:Connect(inputEnded)