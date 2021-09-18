
for i = 1, reaper.CountProjectMarkers(0) do
    reaper.GoToMarker(0, i, false)
    reaper.Main_OnCommand(40012, 1)
end
