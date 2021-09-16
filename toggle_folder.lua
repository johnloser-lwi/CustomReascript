for i = 0, reaper.CountSelectedTracks(0) - 1 do
    local track = reaper.GetSelectedTrack(0, i)
    if reaper.GetMediaTrackInfo_Value(track , "I_FOLDERDEPTH") == 1 then
        local folder_collapsed = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERCOMPACT") == 2

        if folder_collapsed then
            reaper.SetMediaTrackInfo_Value(track , "I_FOLDERCOMPACT", 0)
        else 
            reaper.SetMediaTrackInfo_Value(track , "I_FOLDERCOMPACT", 2)
        end
    end
end



