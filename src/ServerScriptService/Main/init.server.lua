local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameStateManager = require(script.GameStateManager);
local PlayerManager = require(script.PlayerManager);
local Timer = require(script.Timer);
local Building = require(script.BuildingBuilder);

local DataStores = require(ReplicatedStorage.GameData.DataStores);

local SETTINGS = {
  ["GAME_TIME"] = 240,
  ["INTERMISSION_TIME"] = 20,
}

local Players = game:GetService("Players");

-- When a new player joins
Players.PlayerAdded:Connect(function(player)
  PlayerManager.AddPlayer(player);

  print(unpack(DataStores.getPlayerData(player)));

  player.CharacterAdded:Connect(function(character)
    character.Humanoid.JumpPower = 1000
  end)

end);

-- When a player leaves
Players.PlayerRemoving:Connect(function(player)
  PlayerManager.RemovePlayer(player);
end);


-- Game State Clock --
-- Init Timers
local gameTimer = Timer.CreateTimer('gameTimer', SETTINGS.GAME_TIME, false);
local intermissionTimer = Timer.CreateTimer('intermissionTimer', SETTINGS.INTERMISSION_TIME, false);

-- Meta Data values
local META_gameState = game.ReplicatedStorage:WaitForChild("Metadata").gamestate;
local META_gameTime = game.ReplicatedStorage:WaitForChild("Metadata").gametime;

local function tickState()
  if GameStateManager:GetState() == GameStateManager.GameState.GAME and not GameStateManager.IsPaused() then
  
    if not Timer.IsRunning('gameTimer') then
      Timer.SetTime('gameTimer', SETTINGS.GAME_TIME)
      Timer.SetRunning('gameTimer', true);
      Timer.SetRunning('intermissionTimer', false);
      Timer.Count('gameTimer');
      META_gameState.Value = "Game";
    end

    if Timer.GetTime('gameTimer') > 0 then
      -- Update
      -- ...
      -- ...
      -- ...
      META_gameTime.Value = Timer.GetTime("gameTimer");

    else
      -- Change to Intermission
      GameStateManager.SetState(GameStateManager.GameState.INTERMISSION);
      Timer.SetTime('gameTimer', SETTINGS.GAME_TIME)
    end

  elseif GameStateManager.GetState() == GameStateManager.GameState.INTERMISSION then
    
    if not Timer.IsRunning('intermissionTimer') then
      Timer.SetTime('intermissionTimer', SETTINGS.INTERMISSION_TIME)
      Timer.SetRunning('intermissionTimer', true);
      Timer.SetRunning('gameTimer', false);
      Timer.Count('intermissionTimer');
      META_gameState.Value = "Intermission";
    end

    if Timer.GetTime('intermissionTimer') > 0 then
      -- Update
      -- ...
      -- ...
      -- ...
      META_gameTime.Value = Timer.GetTime("intermissionTimer");

    else
      -- Change to Intermission
      GameStateManager.SetState(GameStateManager.GameState.GAME);
      Timer.SetTime('intermissionTimer', SETTINGS.INTERMISSION_TIME)
    end

  else
    -- Something is wrong, reset to INTERMISSION
    Timer.SetTime('gameTimer', SETTINGS.GAME_TIME)
    Timer.SetTime('intermissionTimer', SETTINGS.INTERMISSION_TIME)
    GameStateManager.SetState(GameStateManager.GameState.INTERMISSION);
  end
end

RunService.Stepped:Connect(tickState);


