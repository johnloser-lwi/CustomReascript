local numSelectedItems = reaper.CountSelectedMediaItems(0)

if numSelectedItems == 0 then
  return
end

local firstItem = nil

--find the first item which starts earliest
for i = 0, numSelectedItems - 1 do
  local media = reaper.GetSelectedMediaItem(0, i)
  if media then
    if not firstItem then
      firstItem = media
    else
      local firstItemPosition = reaper.GetMediaItemInfo_Value(firstItem, "D_POSITION")
      local mediaPosition = reaper.GetMediaItemInfo_Value(media, "D_POSITION")
      if mediaPosition < firstItemPosition then
        firstItem = media
      end
    end
  end
end

local firstItemToCursor = reaper.GetCursorPosition() - reaper.GetMediaItemInfo_Value(firstItem, "D_POSITION")

local offset = firstItemToCursor

-- Iterate through each item
for i = 0, numSelectedItems - 1 do
  -- Get the item at index i
  local media = reaper.GetSelectedMediaItem(0, i)
  
  -- Check if the item is valid
  if media then
    -- Get the length of the item
    local media_position = reaper.GetMediaItemInfo_Value(media, "D_POSITION")

    local real_offset = media_position + offset
    
    -- Move the item to the left of the cursor
    reaper.SetMediaItemInfo_Value(media, "D_POSITION", real_offset)
  end
end