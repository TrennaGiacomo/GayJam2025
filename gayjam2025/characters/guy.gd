extends Sprite2D

class_name guy

var cam: Camera2D
@onready var area = $'./Area2D' as Area2D
@onready var col = $'./Area2D/CollisionShape2D' as CollisionShape2D

@export var walkSpeed: float = 100.0

@export var isDraggable: bool = true
@export var isWalkingToTarget: bool = true

var targetPoint: Vector2

var beingMoved: bool
var mouseOffset: Vector2

func _ready() -> void:
	cam = $'/root/Game/Camera2D' as Camera2D
	if (not cam):
		printerr("draggable.gd: Didn't find camera!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (not cam):
		printerr("draggable._process: No camera!")
		
	if (beingMoved):
		var mousePos = cam.get_local_mouse_position()
		var offsetPos = mousePos + mouseOffset
		position = offsetPos
		
	if (!isDraggable):
		beingMoved = false
		
	if (!beingMoved && isWalkingToTarget):
		position = position.move_toward(targetPoint, walkSpeed*delta);


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (not cam):
		printerr("draggable: No valid camera!")
		return;
	
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			if (event.is_pressed() && isDraggable && !beingMoved):
				var mousePos = cam.get_local_mouse_position()
				mouseOffset = position - mousePos
				beingMoved = true
			else:
				beingMoved = false
