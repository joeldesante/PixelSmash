local DataStoreService = game:GetService("DataStoreService");

local DataStores = {};

--[[
  Returns the datastore for a given player
]]
function DataStores.getStore(player)
  return DataStoreService:GetDataStore("player_data", player.UserId);
end

--[[
  Returns the data from the users datastore
]]
function DataStores.getPlayerData(player)
  local DataStore = DataStores.getStore(player);

  -- Set the default values
  local data = {}
  data.money = 800;   -- 5R$ = 100
  data.rank = 1;

  print(1)

  -- Check if the datastore has any value for the given value requested
  local success, err = pcall(function()
    local money = DataStore:GetAsync("money");
    local rank = DataStore:GetAsync("rank");
    print(2)

    if money ~= nil then
      data.money = money;
      print(2.5)
    end
    print(3)

    if rank ~= nil then
      data.rank = rank;
      print(3.5)
    end
    print(4)
  end)

  if not success then
    warn(err);
  end

  print(5, unpack(data))
  return {1,2,3};
end

return DataStores;