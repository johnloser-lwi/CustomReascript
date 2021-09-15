local track = reaper.GetSelectedTrack(0, 0)
local index = reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER')
reaper.InsertTrackAtIndex(index - 1, true)
local folder = reaper.GetTrack(0, index - 1)

reaper.GetSetMediaTrackInfo_String(folder, 'P_NAME', 'New Group', true)

reaper.SetTrackSelected(folder, true)

reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_SELCHILDREN2'), 1)

reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_MAKEFOLDER'), 1)