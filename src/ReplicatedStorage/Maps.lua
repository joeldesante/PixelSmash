--[[
	Stores the metadata of each map in the game 
]]
local Maps = {}

Maps.Test = {
	Id = 0,
	Name = "TestMap",
	Root = game.ServerStorage.Maps.TestMap
}

Maps.Village = {
	Id = 1,
	Name = "Town of Woodpine",
	Root = game.ServerStorage.Maps.Village
}

Maps.Pixeltopia = {
	Id = 2,
	Name = "Pixeltopia",
	Root = game.ServerStorage.Maps.Pixeltopia
}

Maps.Candyland = {
	Id = 3,
	Name = "Candy Land",
	Root = game.ServerStorage.Maps.Candyland
}

return Maps
