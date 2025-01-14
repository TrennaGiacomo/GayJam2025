extends RigidBody2D

class_name guy

var cam: Camera2D
@onready var area = $'./Area2D' as Area2D
@onready var col = $'./Area2D/CollisionShape2D' as CollisionShape2D

@export var walkSpeed: float = 100.0


@export var isDraggable: bool = true
@export var dragSpeed: float = 1.0;

@export var isWalkingToTarget: bool = true

var targetPoint: Vector2

var beingMoved: bool
var mouseOffset: Vector2

var groupId: int;
var manager: guyManager;

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
		move_and_collide(lerp(position, offsetPos, dragSpeed * delta) - position)
		
	if (!isDraggable):
		beingMoved = false
		
	if (!beingMoved && isWalkingToTarget):
		move_and_collide(position.move_toward(targetPoint, walkSpeed*delta) - position);

func _unhandled_input(event: InputEvent):
	if(event is InputEventMouseButton):
		if(event.is_released() && beingMoved):
			beingMoved = false;

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
				manager.startMovingGroup(groupId);
			else:
				beingMoved = false
