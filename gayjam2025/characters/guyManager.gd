extends Node2D
class_name guyManager;

@export_file var guyPaths: Array[String]
var guyScenes = [];

@onready var spawnPoint: Node2D = $SpawnPoint
@onready var walkTarget: Node2D = $WalkTarget
@onready var spawnTimer: Timer = $SpawnTimer

@export var minSpawnTime: float;
@export var maxSpawnTime: float;

var groups = {};

var idCounter: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnTimer.timeout.connect(onSpawnTimerTimout)

	for path in guyPaths:
		guyScenes.append(load(path) as PackedScene)
		
	onSpawnTimerTimout();

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

	var guyScene = guyScenes.pick_random();

	for i in size:
		group.append(spawn_guy(groupId, guyScene));

	groups[groupId] = group;

	idCounter += 1
	return groupId;

func spawn_guy(groupId: int, guyScene: PackedScene) -> guy:
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

func onSpawnTimerTimout():
	spawnGroup(randi_range(2, 5));

	spawnPoint.position = Vector2(randf_range(-400, -150), randf_range(-70, 250))
	walkTarget.position = Vector2(randf_range(-400, -150), randf_range(-70, 250))

	spawnTimer.wait_time = randf_range(minSpawnTime, maxSpawnTime);
	spawnTimer.start();
