extends Node2D
class_name guyManager;

@export_file var guyPath: String

@onready var guyScene: PackedScene = load(guyPath) as PackedScene
@onready var spawnPoint: Node2D = $SpawnPoint
@onready var walkTarget: Node2D = $WalkTarget

var groups = {};

var idCounter: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnGroup(3);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func removeGroup(group: Array) -> void:
	groups.erase(group)

func getGroupById(groupId: int) -> Array:
	return groups[groupId]

# Spawns group of size. Returns id of group
func spawnGroup(size: int) -> int:
	var groupId = idCounter
	var group = [];

	for i in size:
		group.append(spawn_guy(groupId));

	groups[groupId] = group;

	idCounter + 1
	return groupId;

func spawn_guy(groupId: int) -> guy:
	if (not spawnPoint):
		printerr("GuyManager: SpawnPoint not found")
		return
		
	var guyInstance = guyScene.instantiate() as guy
	guyInstance.position = spawnPoint.position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
	guyInstance.targetPoint = walkTarget.position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
	guyInstance.groupId = groupId;
	guyInstance.manager = self;

	add_child(guyInstance)
	return guyInstance;

func startMovingGroup(groupId: int) -> void:
	for guyInstance in groups[groupId]:
		(guyInstance as guy).beingMoved = true;
