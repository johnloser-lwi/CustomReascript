local numSelectedItems = reaper.CountSelectedMediaItems(0)

if numSelectedItems == 0 then
  return
end

local lastItem = nil

--find the last item which ends latest
for i = 0, numSelectedItems - 1 do
  local media = reaper.GetSelectedMediaItem(0, i)
  if media then
    if not lastItem then
      lastItem = media
    else
      local lastItemLength = reaper.GetMediaItemInfo_Value(lastItem, "D_LENGTH")
      local lastItemPosition = reaper.GetMediaItemInfo_Value(lastItem, "D_POSITION")
      local mediaLength = reaper.GetMediaItemInfo_Value(media, "D_LENGTH")
      local mediaPosition = reaper.GetMediaItemInfo_Value(media, "D_POSITION")
      if mediaLength + mediaPosition > lastItemLength + lastItemPosition then
        lastItem = media
      end
    end
  end
end

if not lastItem then
  return
end

local lastItemLength = reaper.GetMediaItemInfo_Value(lastItem, "D_LENGTH")
local lastItemToCursor = reaper.GetCursorPosition() - reaper.GetMediaItemInfo_Value(lastItem, "D_POSITION")

local offset = lastItemToCursor - lastItemLength

-- Iterate through each item
for i = 0, numSelectedItems - 1 do
  -- Get the item at index i
  local media = reaper.GetSelectedMediaItem(0, i)
  
  -- Check if the item is valid
  if media then
    -- Get the length of the item
    local media_position = reaper.GetMediaItemInfo_Value(media, "D_POSITION")

    local real_offset = media_position + offset

    if real_offset < 0 then
      real_offset = 0
    end
    
    -- Move the item to the left of the cursor
    reaper.SetMediaItemInfo_Value(media, "D_POSITION", real_offset)
  end
end