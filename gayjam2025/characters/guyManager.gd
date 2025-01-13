extends Node2D

@export_file var guyPath: String

@onready var guyScene: PackedScene = load(guyPath) as PackedScene
@onready var spawnPoint: Node2D = $SpawnPoint
@onready var walkTarget: Node2D = $WalkTarget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_guy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_guy() -> void:
	if (not spawnPoint):
		printerr("GuyManager: SpawnPoint not found")
		return
		
	var guyInstance = guyScene.instantiate() as guy
	guyInstance.position = spawnPoint.position
	guyInstance.targetPoint = walkTarget.position
	
	add_child(guyInstance)
