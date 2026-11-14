# Fojji Dungeon Map Fix

Companion addon for WoW Forever. It makes Fojji's classic dungeon maps use the
Blizzard map textures already bundled with OpenMap, avoiding green tiles on
localized clients. It does not modify either addon or duplicate their images.

Install **FojjiCore**, **FojjiCore_DungeonJournal**, **OpenMap** (version 0.8.1 or
newer), and this folder as sibling folders in `Interface/AddOns`. Both dependencies
must be enabled. Restart the game after installation. Type `/fjmapfix` to see how
many Fojji maps were linked; the expected count is `46/46` on a non-English client.

This first version covers 46 classic map floors whose exact tile IDs exist in
OpenMap. It leaves Fojji's own image maps alone. It also leaves four Scholomance
floors, Ruins of Lordaeron, and Hall of Thanes alone because OpenMap does not
bundle the exact texture IDs Fojji uses for those six maps. If a future Fojji
update changes a chart's source IDs, this addon skips that chart.

The texture files are supplied by OpenMap and are Blizzard Entertainment art.
OpenMap's project and credits: https://github.com/openmap-world/openmap
