class_name GameMap extends Reference

signal move_room(from, to)

var rooms = {}
var currentRoom

var settings
func _init():
	pass

func coord_from_room(roomInMap, posInRoom):
	var rs = settings.room_size
	return Vector2(roomInMap.x * rs.x, roomInMap.y * rs.y) + posInRoom

func location_of(mapCoord):
	var rs = settings.room_size
	var room_coord = Vector2(int(mapCoord.x) / int(rs.x), int(mapCoord.y) / int(rs.y))
	var in_room_coord = Vector2(int(mapCoord.x) % int(rs.x), int(mapCoord.y) % int(rs.y))

	return {"map": room_coord, "room": in_room_coord}

func load_map(bgTiles: TileMap, solids: TileMap, settings: GameMap.Settings):
	self.settings = settings
	var loading_rooms = {}

	for cell in bgTiles.get_used_cells():
		var coords = location_of(cell)
		var id = bgTiles.get_cellv(cell)

		if not loading_rooms.has(coords.map):
			loading_rooms[coords.map] = MapRoom.new(coords.map)
		loading_rooms[coords.map].tiles[coords.room] = id

	var tileset: TileSet = solids.tile_set
	for cell in solids.get_used_cells():
		var coords = location_of(cell)
		var id = solids.get_cellv(cell)

		if not loading_rooms.has(coords.map):
			loading_rooms[coords.map] = MapRoom.new(coords.map)
		loading_rooms[coords.map].solids[coords.room] = tileset.tile_get_name(id)
	rooms = loading_rooms

func can_move(to):
	var coords = location_of(to)
	return not rooms[coords.map].solids.has(coords.room)

func setupBaseMap():
	var startRoom = MapRoom.new(Vector2(4,8))
	var firstPuzzleRoom = MapRoom.new(Vector2(4,7))
	currentRoom = startRoom

class Settings extends Reference:

	var room_size

	func _init():
		pass
	
	static func from_json(json: String):
		pass
