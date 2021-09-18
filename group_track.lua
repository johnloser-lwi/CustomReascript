-- Group tracks like in every other DAW, you know what I mean! SWS required!

local track = reaper.GetSelectedTrack(0, 0)
local index = reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER')
reaper.InsertTrackAtIndex(index - 1, true)
local folder = reaper.GetTrack(0, index - 1)



reaper.SetTrackSelected(folder, true)

reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_SELCHILDREN2'), 1)

reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_MAKEFOLDER'), 1)

reaper.GetSetMediaTrackInfo_String(folder, 'P_NAME', 'New Group', true)
reaper.SetOnlyTrackSelected(folder)

reaper.Main_OnCommand(40696, 1)