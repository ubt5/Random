local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ScriptContext   = game:GetService("ScriptContext");
local Workspace       = game:GetService("Workspace");

local Framework = require(ReplicatedFirst:FindFirstChild("Framework"));
Framework:WaitForLoaded();

local Libraries = Framework.Libraries;
local Entities  = Libraries.Entities;
local Network   = Libraries.Network;

local Elements  = Workspace.Map.Elements;

task.spawn(function()
	local Success, Error = pcall(function()
		for _, Connection in getconnections(ScriptContext.Error) do
			Connection:Disconnect();
		end;
	end);

	if not Success then
		warn(Error);
	end;
end);

for _, Element in pairs(Elements:GetChildren()) do
	local Detail = Element:FindFirstChild("Detail", true);
	if not Detail then
		continue;
	end;

	for _, Instance in pairs(Detail:GetChildren()) do
		local Entity = Entities:Search(Instance);

		if Entity and Entity.Type == "Loot Group" then
			Network:Send("Client Interacted", Entity.Id);
		end;
	end;
end;