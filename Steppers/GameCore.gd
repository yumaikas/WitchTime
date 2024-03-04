class_name GameCore extends Node

signal event(data)

var domains = {
    "witch": { "enemies": [], "gadgets": [], },
    "gemini": { "enemies": [], "gadgets": [], },
    "viridian": { "enemies": [], "gadgets": [], },
    "ordok": { "enemies": [], "gadgets": [], },
    "atlas": { "enemies": [], "gadgets": [], },
}

var witch = {
    "pos": Vector2(0,0)
}

var _forth = """
:proto [ print :not-implemented print ]  def

:enemies-in-domain [ .domains domain get :enemies get ] def
:gadgets-in-domain [ .domains domain get :gadgets get ] def

:tick-domain [ +scope =domain
    enemies-in-domain [ &tick() ] each
    gadgets-in-domain [ &tick() ] each
    -scope
] def

:witch-pos [ .witch :pos get ] def

:witch-move [ +scope =dir
    self &can_witch_move( dir ) 
        [ self &move_witch( dir ) ~done ] 
        [ self &nomove_witch() ] 
    if-else
    :witch tick-domain
    -scope 
] def

:turn [ self ~event exec ] def

[ turn true ] while

"""

var vm

func do(name, data):
    # Want name to be TOS, data after
    emit_signal("event", data, name)

func _ready():
    var map = Map.new()
    map.setupBaseMap()
    vm = GDForth.new(_forth, self)

func can_witch_move(_dir): 
    return true

func move_witch(dir):
    witch.pos += dir
    return GDForth.nowait_of("done", null)

class Map extends Reference:
    var rooms = {}
    var currentRoom

    func _init():
        pass

    func can_move(to):
        return true


    func setupBaseMap():
        var startRoom = MapRoom.new(Vector2(4,8))
        var firstPuzzleRoom = MapRoom.new(Vector2(4,7))
        currentRoom = startRoom

class Door extends Reference:
    var endA: Location
    var endB: Location

    func init(one, A):
        endA = one
        endB = A
    
    func get_other_end(end):
        if end == endA:
            return endB
        elif end == endB:
            return endA
        else:
            return null

    
class Location extends Reference:
    var coord
    var room

    func _init(x,y, room):
        coord = Vector2(x,y)
        self.room = room



