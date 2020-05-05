local PlayerManager = {}

-- Players in game
local __playersData = {}

-- Template player object
local __playerObject = {}
__playerObject.player = nil;
__playerObject.isWrecker = false;
__playerObject.currency = 0;
__playerObject.__index = __playerObject

function __playerObject:GetPlayer()
  return self.player;
end

function __playerObject:IsWrecker()
  return self.isWrecker;
end

function __playerObject:GetCurrency()
  return self.currency;
end

function __playerObject:SetPlayer(value)
  self.id = value;
end

function __playerObject:SetIsWrecker(bool)

  if type(bool) ~= 'boolean' then
    return;
  end

  self.isWrecker = bool;
end

function __playerObject:SetCurrency(value)

  if type(value) ~= 'number' then
    return;
  end

  self.currency = value;
end

-- Creates a new player object
function newPlayerObject()
  local o = {}
  setmetatable(o, __playerObject)
  return o;
end

-- Internal functions
function emitData()
  local bindableEvent = script.PlayerDataEvent;
  local remoteEvent = script.PlayerDataEmitter;
  remoteEvent:FireAllClients(__playersData);
  bindableEvent:Fire(__playersData)
end

function onPlayerDataRequest(player)
  return __playersData[player]  
end

-- Main functions
function PlayerManager.AddPlayer(player)
  local newPlayer = newPlayerObject();
  newPlayer:SetPlayer(player);
  __playersData[player] = newPlayer;
end

function PlayerManager.RemovePlayer(player)
  __playersData[player] = nil;
end

function PlayerManager.GetPlayer(player)
    return __playersData[player];
end

function PlayerManager.GetAllPlayers()
    return __playersData;
end

-- Setup events
game.ReplicatedStorage.Listeners:WaitForChild("PlayerDataListener").OnServerInvoke = onPlayerDataRequest;

-- Done
return PlayerManager;