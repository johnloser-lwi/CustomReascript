-- Go to each region and perform a cut. SWS required!

for i = 1, reaper.CountProjectMarkers(0) do
    reaper.GoToRegion(0, i, false)
    reaper.Main_OnCommand(reaper.NamedCommandLookup('_S&M_SPLIT11'), 1) -- Perform a cut
end
