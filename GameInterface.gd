extends Node2D

onready var witch = $Witch


var game

func _ready():

	game = GameCore.new()
	add_child(game)

func _process(_delta):
	if game.witch_loc:
		witch.position = game.witch_loc.room * 16
	if game.curr_room_changed:
		$Background.clear()
		WorldMap.map.rooms[game.curr_room].load_bg($Background)
		for sk in slices.keys():
			var slice = slices[sk]
			for mul in slice.len:
				var borderPt = slice.offset + (slice.dir * mul)
				print(mul, borderPt)
				var anchorPt = WorldMap.map.location_of(WorldMap.map.coord_from_room(game.curr_room, borderPt))
				if WorldMap.map.rooms.has(anchorPt.map) and WorldMap.map.rooms[anchorPt.map].tiles.has(anchorPt.room):
					$Background.set_cellv(borderPt, WorldMap.map.rooms[anchorPt.map].tiles[anchorPt.room])


var slices = {
	"topLeftToRight": {"offset": Vector2(-1,-1), "len": 11, "dir": intRight },
	"rightTopToBottom": {"offset": Vector2(10,-1), "len": 11, "dir": intDown },
	"bottomRightToLeft": {"offset": Vector2(10,10), "len": 11, "dir": intLeft },
	"leftBottomToTop": {"offset": Vector2(-1,10), "len": 11, "dir": intUp },
}

# Movement
const intLeft = Vector2(-1,0)
func _on_BtnLeft_pressed():
	game.do("witch-move", intLeft)

const intRight = Vector2(1, 0)
func _on_BtnRight_pressed():
	game.do("witch-move", intRight)

const intDown = Vector2(0, 1)
func _on_BtnDown_pressed():
	game.do("witch-move", intDown)

const intUp = Vector2(0, -1)
func _on_BtnUp_pressed():
	game.do("witch-move", intUp)
