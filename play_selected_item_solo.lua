
if reaper.CountSelectedMediaItems(0) > 0 then
    reaper.SoloAllTracks(0)

    for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
        local item = reaper.GetSelectedMediaItem(0, i)
        local track = reaper.GetMediaItem_Track(item)
        local  _,track_name = reaper.GetTrackName(track)

        if i == 0 then
            -- set cursor to the beginning of first selected item
            reaper.Main_OnCommand(41173, 1)
        end

        
        reaper.SetMediaTrackInfo_Value(track, 'I_SOLO', 1)
        
    end


    reaper.OnPlayButton()

    function onCallBack()
        if reaper.GetPlayState() == 0 then
            reaper.SoloAllTracks(0)
        else
            reaper.defer(function() onCallBack() end)
        end
    end

    onCallBack(call)
else
    reaper.ShowMessageBox("Please select at least one item!", "Warning", 0)
end
