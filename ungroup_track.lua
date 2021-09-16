local target_tracks = {}

-- Identify folder tracks and save to target_tracks
for i = 0, reaper.CountSelectedTracks(0) - 1 do
    local track = reaper.GetSelectedTrack(0, i)
    
    if reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH") == 1 then
        target_tracks[i + 1] = track
    end
end

-- Remove target tracks
for key, value in pairs(target_tracks) do
    reaper.SetMediaTrackInfo_Value(target_tracks[key] , "I_FOLDERDEPTH", 0)
        reaper.DeleteTrack(target_tracks[key])
end
