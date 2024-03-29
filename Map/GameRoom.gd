class_name MapRoom extends Reference

var mapLoc
var tiles = {}
var flags = {}
var solids = {}
var items = {}
var doors = {}

func _init(mapLoc):
    self.mapLoc = mapLoc

func can_move(to):
    return solids.has(to)
func pickups(at):
    return items[at]
func door(at):
    return doors[at]

func load_cell(tileMap, pos):
    tileMap.set(pos)

func load_bg(tileMap: TileMap):
    for k in tiles.keys():
        tileMap.set_cellv(k, tiles[k])