
function main ()
    local item_count = reaper.CountSelectedMediaItems(0)

    if item_count > 0 then
        -- Clear Solo Tracks
        reaper.SoloAllTracks(0)

        local start_time = -1
        local end_time = -1

        for i = 0, item_count - 1 do
            local item = reaper.GetSelectedMediaItem(0, i)
            local track = reaper.GetMediaItem_Track(item)

            local item_start_time = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
            local item_end_time = item_start_time + reaper.GetMediaItemInfo_Value(item, "D_LENGTH")

            -- Set Track Solo
            reaper.SetMediaTrackInfo_Value(track, 'I_SOLO', 1)
            

            -- Set Start Time
            if i == 0 then
                start_time = item_start_time
            elseif item_start_time < start_time then
                start_time = item_start_time
            end
            

            -- Set End Time
            if item_end_time > end_time then
                end_time = item_end_time
            end
        end

        -- Move Edit Cursor and Play
        reaper.MoveEditCursor(start_time - reaper.GetCursorPosition(), false)
        reaper.OnPlayButton()


        -- Defer Loop Until Playback Stops
        function DeferLoop()
            if reaper.GetPlayState() == 0 or reaper.GetPlayPosition() > end_time then
                reaper.OnStopButton()
                reaper.SoloAllTracks(0)
                -- Reset Undo State
                reaper.Undo_DoUndo2(0)
                
            else
                reaper.defer(function() DeferLoop() end)
            end
        end
        DeferLoop()
        
    else
        reaper.ShowMessageBox("Please select at least one item!", "Warning", 0)
    end
end

main()