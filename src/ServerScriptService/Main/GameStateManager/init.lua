local GameStateManager = {}
local __gameData = {}
__gameData.gameState = 0;
__gameData.isPaused = false;

GameStateManager.GameState = {
  ["GAME"] = 0,
  ["INTERMISSION"] = 1
}

-- Internal Functions
function emitState(state)
  -- Fires off the events to let the rest of the game know about the update
  local bindableEvent = script.GameStateEvent;
  local remoteEvent = script.GameStateEmitter;
  remoteEvent:FireAllClients(state);
  bindableEvent:Fire(state)
end

function onGameStateRequest(player)
  return __gameData.gameState
end

-- Main GameState Functions
function GameStateManager.GetState()
    return __gameData.gameState;
end

function GameStateManager.SetState(gameStateValue)
    if type(gameStateValue) ~= "number" then
      error("The provide game state must be a numerical value.");
      return
    end

    __gameData.gameState = gameStateValue;
    emitState(gameStateValue);
end

function GameStateManager.IsPaused()
    return __gameData.isPaused;
end

function GameStateManager.SetPaused(paused)

  if type(paused) ~= 'boolean' then
    return
  end

  __gameData.isPaused = paused;
end

-- Setup any connects
game.ReplicatedStorage.Listeners:WaitForChild("GameStateListener").OnServerInvoke = onGameStateRequest;

-- Done
return GameStateManager;