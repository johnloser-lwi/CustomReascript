local numSelectedTracks = reaper.CountSelectedTracks(0)

-- Get solo mode for each track and store them for later

-- Define the command IDs for solo modes
local SOLO_MODE = {
    SOLO = 7, -- Toggle Solo
    EXCLUSIVE_SOLO = 40341 -- Toggle Exclusive Solo
}

-- Function to get the state of a command
local function getCommandState(commandID)
    return reaper.GetToggleCommandStateEx(0, commandID)
end

-- Table to store track solo modes
local trackSoloModes = {}

-- Iterate through each track
for i = 0, numSelectedTracks - 1 do
    -- Get the track at index i
    local track = reaper.GetSelectedTrack(0, i)
    
    -- Check if the track is valid
    if track ~= nil then
        -- Get solo state of the track
        local soloState = reaper.GetMediaTrackInfo_Value(track, "I_SOLO")
        -- Determine solo mode
        local soloMode = ""
        if soloState == 2 then
            
            soloMode = "Solo"
        else
            soloMode = "None"
        end
        
        -- Store solo mode for the track
        trackSoloModes[i + 1] = soloMode -- Track indexes are 1-based
    end
end

reaper.Main_OnCommand(40340, 1)

-- Display track solo modes (for testing)
for i, mode in ipairs(trackSoloModes) do
    local track = reaper.GetSelectedTrack(0, i - 1)
    
    local val = 0
    if mode == "None" then
        val = 2
    end
    
    -- Check if the track is valid
    if track ~= nil then
        reaper.SetMediaTrackInfo_Value(track, "I_SOLO", val)
    end
end