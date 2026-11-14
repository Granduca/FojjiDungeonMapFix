-- OpenMap bundles Blizzard's classic dungeon tiles for localized WoW Forever clients.
-- Fojji's chart layouts already use the same tile order and positions. Only the
-- texture references are changed here; Fojji and OpenMap themselves are untouched.
local locale = GetLocale()
if locale == "enUS" or locale == "enGB" then return end

local addon = FojjiCoreNS
local charts = addon and addon.IsForever and addon.DJ and addon.DJ.Charts
if not charts then return end

local prefix = "Interface\\AddOns\\OpenMap\\Media\\Textures\\Forever\\MapTile\\"
local offsets = { 0, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2, 3 }

-- Chart ID -> first Blizzard tile ID, as used by Fojji 4.0.48. The exact
-- match prevents replacing art if a future Fojji update changes a map.
local bases = {
    [213] = 449736, [219] = 449820, [220] = 452514,
    [221] = 447578, [222] = 447590, [223] = 447602,
    [225] = 455959,
    [227] = 449628, [228] = 449640, [229] = 449652,
    [230] = 448430, [231] = 448442,
    [235] = 449508, [236] = 449520, [237] = 449532,
    [238] = 449544, [239] = 449556, [240] = 449568,
    [242] = 447638, [243] = 447650,
    [250] = 447662, [251] = 447674, [252] = 447686,
    [253] = 447698, [254] = 447710, [255] = 447722,
    [280] = 449676, [281] = 449688,
    [291] = 449591, [292] = 449603,
    [300] = 448094, [301] = 448106,
    [302] = 449760, [303] = 449772, [304] = 449784,
    [305] = 449796,
    [310] = 448226, [311] = 448238, [312] = 448250,
    [313] = 448262, [314] = 448274, [315] = 448286,
    [316] = 448298, [317] = 448322, [318] = 448334,
}

local patched = 0
for chartID, base in pairs(bases) do
    local chart = charts[chartID]
    if chart and not chart.image and chart.seq == base then
        local list = {}
        for i, offset in ipairs(offsets) do
            list[i] = prefix .. (base + offset) .. ".blp"
        end
        chart.list = list
        patched = patched + 1
    end
end

-- Gnomeregan's first floor has one tile out of numerical sequence.
local gnomeregan = { 449580, 449584, 449585, 449586, 449587, 449588,
    449589, 449590, 449627, 449581, 449582, 449583 }
local chart = charts[226]
if chart and not chart.image and not chart.seq and type(chart.tiles) == "table" and #chart.tiles == #gnomeregan then
    local same = true
    for i, fileID in ipairs(gnomeregan) do
        if chart.tiles[i] ~= fileID then same = false; break end
    end
    if same then
        local list = {}
        for i, fileID in ipairs(gnomeregan) do
            list[i] = prefix .. fileID .. ".blp"
        end
        chart.list = list
        patched = patched + 1
    end
end

SLASH_FOJJIDUNGEONMAPFIX1 = "/fjmapfix"
SlashCmdList.FOJJIDUNGEONMAPFIX = function()
    print("Fojji Dungeon Map Fix: " .. patched .. "/46 maps linked to OpenMap textures (" .. locale .. ").")
end
