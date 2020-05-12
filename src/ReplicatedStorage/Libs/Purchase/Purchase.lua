local MarketplaceService = game:GetService("MarketplaceService");
local Purchase = {}

function Purchase.Gamepass(id)

end

function Purchase.Product(player, id, reciptCallback)

  local productPurchase = MarketplaceService:PromptProductPurchase(player, id)


end

local function processReciept()
  return Enum.ProductPurchaseDecision.PurchaseGranted
end

MarketplaceService.ProcessReceipt = processReciept

return Purchase