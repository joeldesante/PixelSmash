local DataStoreService = game:GetService("DataStoreService");

-- TODO Read this for clarification on how to best do this. https://devforum.roblox.com/t/is-there-a-way-to-read-all-of-the-values-from-a-datastore/216784/7

local DataStoreId = {}
DataStoreId.TransactionLogs = {
  DataStoreService:GetOrderedDataStore("TransactionIds"),
  DataStoreService:GetDataStore("TransactionLogs")
}