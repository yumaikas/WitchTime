extends Node2D

onready var bgTiles = $background
onready var solids = $solids

var map

func _ready():
	map = GameMap.new()
	var mapSettings = GameMap.Settings.new()
	mapSettings.room_size = Vector2(10,10)
	map.load_map(bgTiles, solids, mapSettings)
	bgTiles.hide()
	solids.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
