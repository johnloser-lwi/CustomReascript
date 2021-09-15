track = reaper.GetSelectedTrack(0, 0)
index = reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER')
reaper.InsertTrackAtIndex(index - 1, true)
folder = reaper.GetTrack(0, index - 1)

reaper.GetSetMediaTrackInfo_String(folder, 'P_NAME', 'New Group', true)

for i = 0, reaper.CountSelectedTracks(0) - 1 do
    sel_track = reaper.GetSelectedTrack(0, i)
    reaper.SetMediaTrackInfo_Value(folder, 'I_FOLDERDEPTH', reaper.GetMediaTrackInfo_Value(folder, 'I_FOLDERDEPTH') + 1)

    if i == reaper.CountSelectedTracks(0) - 1 then
        reaper.SetMediaTrackInfo_Value(sel_track, 'I_FOLDERDEPTH', reaper.GetMediaTrackInfo_Value(sel_track, 'I_FOLDERDEPTH') - 1)
    end
end