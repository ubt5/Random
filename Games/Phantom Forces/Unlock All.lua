--// Make sure to be using the `DebugRunParallelLuaOnMainThread` FFlag

local require = rawget(getrenv().shared, "require");

local PlayerData  = require("PlayerDataUtils");
local SkinCase    = require("SkinCaseUtils");
local PageLoadout = require("PageLoadoutMenuDisplayWeaponSelection");

local UpdateList = getupvalue(PageLoadout._init, 33);

do
    PlayerData.ownsWeapon = function()
        return true;
    end;

    PlayerData.ownsAttachment = function()
        return true;
    end;

    SkinCase.ownsWeaponSkin = function()
        return true;
    end;
end;

pcall(UpdateList);