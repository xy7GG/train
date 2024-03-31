-- 获取输入的字符串作为实际键值
local inputString = KEYS[2]
local actualKey = inputString
local colonIndex = string.find(actualKey, ":")
-- 如果存在冒号，则截取冒号后的部分作为实际键值
if colonIndex ~= nil then
    actualKey = string.sub(actualKey, colonIndex + 1)
end
-- 解析传入的 JSON 数组字符串
local jsonArrayStr = ARGV[1]
local jsonArray = cjson.decode(jsonArrayStr)
-- 遍历 JSON 数组中的每个对象
for index, jsonObj in ipairs(jsonArray) do
    local seatType = tonumber(jsonObj.seatType)
    local count = tonumber(jsonObj.count)
    local actualInnerHashKey = actualKey .. "_" .. seatType
    -- 获取哈希表中的值
    local ticketSeatAvailabilityTokenValue = tonumber(redis.call('hget', KEYS[1], tostring(actualInnerHashKey)))
    -- 如果票的可用性小于数量，则返回 1
    if ticketSeatAvailabilityTokenValue < count then
        return 1
    end
end
-- 解析传入的另一个 JSON 数组字符串
local alongJsonArrayStr = ARGV[2]
local alongJsonArray = cjson.decode(alongJsonArrayStr)
-- 遍历第一个 JSON 数组中的每个对象
for index, jsonObj in ipairs(jsonArray) do
    local seatType = tonumber(jsonObj.seatType)
    local count = tonumber(jsonObj.count)
    for indexTwo, alongJsonObj in ipairs(alongJsonArray) do
        local startStation = tostring(alongJsonObj.startStation)
        local endStation = tostring(alongJsonObj.endStation)
        local actualInnerHashKey = startStation .. "_" .. endStation .. "_" .. seatType
        -- 将哈希表中对应键的值减去数量
        redis.call('hincrby', KEYS[1], tostring(actualInnerHashKey), -count)
    end
end

return 0
