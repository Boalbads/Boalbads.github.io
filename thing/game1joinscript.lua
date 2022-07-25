local plrid = math.random(10,100000) -- You can change this to any userID you want.
local GuestID = math.random(100,9999)
local GuestID = math.random(100,9999)
local GuestID = math.random(100,9999)
local GuestID = math.random(100,9999)
local GuestID = math.random(100,9999)
local plrname = "Guest "..GuestID -- You can change this to anything you want. e.g. "Bob"

local Visit = game:service("Visit")
local Players = game:service("Players")
local NetworkClient = game:service("NetworkClient")

local function onConnectionRejected()
	game:SetMessage("This game is not available. Please try another")
end

local function onConnectionFailed(_, id, reason)
	game:SetMessage("Failed to connect to the Game. (ID=" .. id .. ", " .. reason .. ")")
end

local function onConnectionAccepted(peer, replicator)
	local worldReceiver = replicator:SendMarker()
	local received = false
	
	local function onWorldReceived()
		received = true
	end
	
	worldReceiver.Received:connect(onWorldReceived)
	game:SetMessageBrickCount()
	
	while not received do
		workspace:ZoomToExtents()
		wait(0.5)
	end
	
	local player = Players.LocalPlayer
	game:SetMessage("Requesting character")
	
	replicator:RequestCharacter()
	game:SetMessage("Waiting for character")
	
	while not player.Character do
		player.Changed:wait()
	end
	
	game:ClearMessage()
end

NetworkClient.ConnectionAccepted:connect(onConnectionAccepted)
NetworkClient.ConnectionRejected:connect(onConnectionRejected)
NetworkClient.ConnectionFailed:connect(onConnectionFailed)

local tojoinip = "192.168.1.44"
local tojoinport = 53640

game:SetMessage("Connecting to Server")

local player = Players.LocalPlayer

local success, errorMsg = pcall(function ()
	
	if not player then
		player = Players:createLocalPlayer(plrid)
		player.Name = plrname
	end
	
	NetworkClient:connect(tojoinip, tojoinport , plrid)
end)

if not success then
	game:SetMessage(errorMsg)
end

local function onChanged()
	local humanoid = waitForChild(player.Character, "Humanoid")
	humanoid.Died:connect(function ()
		wait(5)
		player:LoadCharacter()
	end)
end

player.Changed:connect(onChanged)
player:LoadCharacter()
