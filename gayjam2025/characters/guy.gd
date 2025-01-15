extends RigidBody2D

class_name guy

var cam: Camera2D
@onready var area = $'./Area2D' as Area2D
@onready var col = $'./Area2D/CollisionShape2D' as CollisionShape2D
@onready var anim = $AnimatedSprite2D as AnimatedSprite2D

@export var walkSpeed: float = 100.0

@export var isDraggable: bool = true
@export var dragSpeed: float = 1.0;

@export var isWalkingToTarget: bool = true

var targetPoint: Vector2

var beingMoved: bool
var mouseOffset: Vector2

var groupId: int;
var manager: guyManager;

var isInLift: bool

var lastAnim: String;

func _ready() -> void:
	cam = $'/root/Game/Camera2D' as Camera2D
	anim.animation = "idle_happy"
	anim.frame = randi_range(0, anim.sprite_frames.get_frame_count(anim.animation))
	anim.play();
	if (not cam):
		printerr("draggable.gd: Didn't find camera!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	anim.z_index = position.y;
	# Guys in lift are done processing
	if (isInLift):
		return
	
	if (not cam):
		printerr("draggable._process: No camera!")
		
	if (beingMoved):
		var mousePos = cam.get_local_mouse_position()
		var offsetPos = mousePos + mouseOffset
		position = lerp(position, offsetPos, dragSpeed * delta)
		
	if (!isDraggable):
		beingMoved = false
		
	if (!beingMoved && isWalkingToTarget):
		move_and_collide(position.move_toward(targetPoint, walkSpeed*delta) - position);

func _unhandled_input(event: InputEvent):
	if(event is InputEventMouseButton):
		if(event.is_released() && beingMoved):
			stopDragging()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (not cam):
		printerr("draggable: No valid camera!")
		return;
	
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			if (event.is_pressed() && isDraggable && !beingMoved):
				var mousePos = cam.get_local_mouse_position()
				mouseOffset = position - mousePos
				startDragging()
				manager.startMovingGroup(groupId);
			else:
				stopDragging()

func startDragging() -> void:
	beingMoved = true;
	if(anim.animation != "dangling"):
		lastAnim = anim.animation;
	anim.animation = "dangling";

func stopDragging() -> void:
	beingMoved = false;
	anim.animation = lastAnim;


func onEnterLift() -> void:
	isInLift = true
	queue_free() # remove self from tree


func _on_mood_timer_timeout():
	if(beingMoved):
		return;

	if(anim.animation == "idle_happy"):
		anim.animation = "idle_neutral"
		anim.frame = randi_range(0, anim.sprite_frames.get_frame_count(anim.animation))
		anim.play();
	elif (anim.animation == "idle_neutral"):
		anim.animation = "idle_angry"
		anim.frame = randi_range(0, anim.sprite_frames.get_frame_count(anim.animation))
		anim.play();
	elif (anim.animation == "idle_angry"):
		anim.animation = "angry_waving"
		anim.frame = randi_range(0, anim.sprite_frames.get_frame_count(anim.animation))
		anim.play();
	pass # Replace with function body.
