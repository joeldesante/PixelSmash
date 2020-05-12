local DataStoreService = game:GetService("DataStoreService");
local DataStore = {}

--[[
  Provide the following object
  {
    { playerName, isPremium }
    { "productId", "productName", "currentPrice", "purchaseDate" }
  }
]]

-- TODO Read this for clarification on how to best do this. https://devforum.roblox.com/t/is-there-a-way-to-read-all-of-the-values-from-a-datastore/216784/7

function DataStore.GetReciptTemplate()
  return {
    ["Player"] = {
      ["PlayerName"] = nil,
      ["isPremium"] = nil
    },
    ["Product"] = {
      ["ProductId"] = nil,
      ["ProductName"] = nil,
      ["ProductPrice"] = nil,
      ["PurchaseDate"] = nil
    }
  }
end

function DataStore.CreateTransactionLog(data)

end

return DataStore;