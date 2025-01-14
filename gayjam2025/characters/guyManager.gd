extends Node2D

@export_file var guyPath: String

@onready var guyScene: PackedScene = load(guyPath) as PackedScene
@onready var spawnPoint: Node2D = $SpawnPoint
@onready var walkTarget: Node2D = $WalkTarget

var groups = {};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnGroup(3);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnGroup(size: int) -> int:
	var groupId = groups.size();

	for i in size:
		spawn_guy(groupId);

	return groupId;

func spawn_guy(groupId: int) -> void:
	if (not spawnPoint):
		printerr("GuyManager: SpawnPoint not found")
		return
		
	var guyInstance = guyScene.instantiate() as guy
	guyInstance.position = spawnPoint.position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
	guyInstance.targetPoint = walkTarget.position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
	guyInstance.groupId = groupId;

	add_child(guyInstance)
