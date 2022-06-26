local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "SCRIPT") 
vRP = Proxy.getInterface("vRP")  

HT = nil

local text

TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)

RegisterServerEvent('joehud:getServerInfo')
AddEventHandler('joehud:getServerInfo', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local info = {
        job = vRP.getUserGroupByType({user_id, 'job'}),
        money = vRP.getMoney({user_id}),
        bankMoney = vRP.getBankMoney({user_id}),
    }
    TriggerClientEvent('joehud:setInfo', source, info)
end)

RegisterCommand("hud", function(source)
    local _source = source
    if (_source > 0) then
        TriggerClientEvent("joehud:hudmenu", source)
    else
        print("This command was executed by the server console, RCON client, or a resource.")
    end
end, false)

-- DEV IN SOME ENCRYPTION (TO FLEX ON PEOPLE WHO DON'T HAVE ACCESS)
-- Person 1: How do you have the black circle in your hud
-- Person 2: I am just too good (or insert other cool comment)
RegisterCommand("devmode", function(source)
    local _source = source
    local user_id = vRP.getUserId({_source})
    if vRP.hasPermission({user_id, "hud.devmode"}) then
        if (_source > 0) then
            TriggerClientEvent("joehud:devmode", source)
        else
            print("This command was executed by the server console, RCON client, or a resource.")
        end
    end
end, false)


HT.RegisterServerCallback('getHunger', function(source, cb)
    local source = source
    local user_id = vRP.getUserId({source})
    cb(vRP.getHunger({user_id}))
end)

HT.RegisterServerCallback('getThirst', function(source, result)
    local source = source
    local user_id = vRP.getUserId({source})
    result(vRP.getThirst({user_id}))
end)