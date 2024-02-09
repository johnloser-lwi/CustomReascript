local numSelectedTracks = reaper.CountSelectedTracks(0)

-- Get Mute mode for each track and store them for later

-- Define the command IDs for Mute modes
local Mute_MODE = {
    Mute = 6, -- Toggle Mute
}

-- Function to get the state of a command
local function getCommandState(commandID)
    return reaper.GetToggleCommandStateEx(0, commandID)
end

-- Table to store track Mute modes
local trackMuteModes = {}

-- Iterate through each track
for i = 0, numSelectedTracks - 1 do
    -- Get the track at index i
    local track = reaper.GetSelectedTrack(0, i)
    
    -- Check if the track is valid
    if track ~= nil then
        -- Get Mute state of the track
        local MuteState = reaper.GetMediaTrackInfo_Value(track, "B_MUTE")
        
        -- Store Mute mode for the track
        trackMuteModes[i + 1] = MuteState -- Track indexes are 1-based
    end
end

reaper.Main_OnCommand(40339, 1)

-- Display track Mute modes (for testing)
for i, mode in ipairs(trackMuteModes) do
    local track = reaper.GetSelectedTrack(0, i - 1)
    
    local val = 0
    if mode == 0 then
        val = 1
    end
    
    -- Check if the track is valid
    if track ~= nil then
        reaper.SetMediaTrackInfo_Value(track, "B_MUTE", val)
    end
end