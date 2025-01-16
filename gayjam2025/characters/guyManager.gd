extends Node2D
class_name guyManager;

@export_file var guyPaths: Array[String]
var guyScenes = [];

@onready var spawnPoint: Node2D = $SpawnPoint
@onready var walkTarget: Node2D = $WalkTarget
@onready var spawnTimer: Timer = $SpawnTimer

@onready var audioSrc: AudioStreamPlayer = $AudioStreamPlayer
@export_file var pickUpSoundPath: String
@export_file var dropSoundPath: String
var pickUpSound: AudioStream
var dropSound: AudioStream

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
	
	pickUpSound = load(pickUpSoundPath) as AudioStream
	dropSound = load(dropSoundPath) as AudioStream

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
	guyInstance.position = spawnPoint.position + Vector2(randf_range(-30, 30), randf_range(-30, 30))
	guyInstance.targetPoint = walkTarget.position + Vector2(randf_range(-30, 30), randf_range(-30, 30))
	guyInstance.groupId = groupId;
	guyInstance.manager = self;

	add_child(guyInstance)
	return guyInstance;

func startMovingGroup(groupId: int) -> void:
	for guyInstance in groups[groupId]:
		(guyInstance as guy).startDragging();
		
	playSound(pickUpSound)
		
func stopMovingGroup(groupId: int) -> void:
	for guyInstance in groups[groupId]:
		(guyInstance as guy).stopDragging()
	
	playSound(dropSound)
	
func playSound(sound: AudioStream) -> void:
	if (not sound):
		printerr("guyManager.playSound: InvalidSound")
		return
		
	audioSrc.stream = sound;
	audioSrc.play()

func onSpawnTimerTimout():
	spawnGroup(randi_range(2, 5));

	spawnPoint.position = Vector2(randf_range(-424, 0), randf_range(273, 200))
	walkTarget.position = Vector2(randf_range(-400, -150), randf_range(-70, 250))

	spawnTimer.wait_time = randf_range(minSpawnTime, maxSpawnTime);
	spawnTimer.start();
