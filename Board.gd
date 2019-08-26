extends Node2D

var _timer = null
const CELL_SIZE = 16;
const X_CENTER = 80;

onready var boardNode = get_node("/root/Main/Board").get_node("TileMap");
onready var pieceNode = get_node("/root/Main/Board/IPiece")
var movement = Vector2()

func _ready():
	_timer = Timer.new();
	add_child(_timer);

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	pieceNode.show()
	pieceNode.position.x = X_CENTER;
	pieceNode.position.y = CELL_SIZE;

func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_RIGHT:
            pieceNode.position.x = pieceNode.position.x + CELL_SIZE;
        elif event.scancode == KEY_LEFT:
             pieceNode.position.x = pieceNode.position.x - CELL_SIZE;

func _on_Timer_timeout():
	var lastLineYPos = boardNode.map_to_world(Vector2(0, 21))[1];
	if (pieceNode.position.y < lastLineYPos - CELL_SIZE):
		pieceNode.position.y = pieceNode.position.y + CELL_SIZE;

func _process(delta):
	pass
