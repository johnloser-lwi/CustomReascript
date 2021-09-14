
local item_count = reaper.CountSelectedMediaItems(0)

if item_count > 0 then
    reaper.SoloAllTracks(0)

    local end_time = -1

    for i = 0, item_count - 1 do
        local item = reaper.GetSelectedMediaItem(0, i)
        local track = reaper.GetMediaItem_Track(item)
        local  _,track_name = reaper.GetTrackName(track)

        if i == 0 then
            -- set cursor to the beginning of first selected item
            reaper.Main_OnCommand(41173, 1)
        end

        if i == item_count -1 then
            end_time = reaper.GetMediaItemInfo_Value(item, "D_POSITION") + reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
        end
        
        reaper.SetMediaTrackInfo_Value(track, 'I_SOLO', 1)
        
    end

    reaper.ShowConsoleMsg(tostring(end_time))

    reaper.OnPlayButton()

    function onCallBack()
        if reaper.GetPlayState() == 0 or reaper.GetPlayPosition() > end_time then
            reaper.SoloAllTracks(0)
            reaper.OnStopButton()
        else
            reaper.defer(function() onCallBack() end)
        end
    end

    onCallBack(call)
else
    reaper.ShowMessageBox("Please select at least one item!", "Warning", 0)
end
