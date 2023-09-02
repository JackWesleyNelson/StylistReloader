addon.name    = 'StylistReloader';
addon.author  = 'Apples_mmmmmmmm';
addon.version = '1.0';
addon.desc    = 'Calls /stylist reload when the player loads the addon, logs in, or changes zone.';
addon.link    = 'https://github.com/JackWesleyNelson/StylistReloader';

require('common');

local partyManager = AshitaCore:GetMemoryManager():GetParty();
local dirty = true;

ashita.events.register('load', 'load_callback1', function()
end);

ashita.events.register('packet_in', 'packet_in_cb', function(e)
    -- Packet: Zone Leave
    if (e.id == 0x000B) then
        dirty = true;
        return;
    end
end);

ashita.events.register('d3d_present', 'mobdb_main_render', function()
    if (dirty and (partyManager:GetMemberIsActive(0) ~= 0 or partyManager:GetMemberServerId(0) ~= 0)) then
        AshitaCore:GetChatManager():QueueCommand(1, '/sl reload');
        dirty = false;
    end
end);

