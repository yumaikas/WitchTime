extends Node2D

onready var witch = $Witch


var game

func _ready():

	game = GameCore.new()
	add_child(game)

func _process(_delta):
	witch.position = game.witch.pos * 16

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