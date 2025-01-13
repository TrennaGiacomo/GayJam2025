extends Sprite2D

class_name draggable

@onready var cam = $'../Camera2D' as Camera2D
@onready var area = $'./Area2D' as Area2D
@onready var col = $'./Area2D/CollisionShape2D' as CollisionShape2D

var beingMoved: bool
var mouseOffset: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (beingMoved):
		var mousePos = cam.get_local_mouse_position()
		var offsetPos = mousePos + mouseOffset
		position = offsetPos


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			if (event.is_pressed()):
				var mousePos = cam.get_local_mouse_position()
				mouseOffset = position - mousePos
				beingMoved = true
			else:
				beingMoved = false
