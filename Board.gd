extends Node2D

var _timer = null
const CELL_SIZE = 16;
const X_CENTER = 80;

onready var board_node = get_node("/root/Main/Board").get_node("TileMap");
onready var piece_node = get_node("/root/Main/Board/IPiece")
var movement = Vector2()
var current_rotation = 0

func _ready():
	_timer = Timer.new();
	add_child(_timer);

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	piece_node.show()
	piece_node.position.x = X_CENTER
	piece_node.position.y = CELL_SIZE

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_RIGHT:
			piece_node.position.x = piece_node.position.x + CELL_SIZE
		elif event.scancode == KEY_LEFT:
			piece_node.position.x = piece_node.position.x - CELL_SIZE
		elif event.scancode == KEY_UP:
			var rotations = piece_node.get_children()
			if (current_rotation < rotations.size() - 1):
				current_rotation = current_rotation + 1
			else:
				current_rotation = 0
			for i in range(0, rotations.size()):
				if (i == current_rotation):
					rotations[i].show()
				else:
					rotations[i].hide()

func _on_Timer_timeout():
	var last_line_y_pos = board_node.map_to_world(Vector2(0, 21))[1];
	if (piece_node.position.y < last_line_y_pos - CELL_SIZE):
		piece_node.position.y = piece_node.position.y + CELL_SIZE;

func _process(delta):
	pass
