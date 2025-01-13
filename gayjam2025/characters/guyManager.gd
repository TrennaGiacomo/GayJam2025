extends Node2D

@export_file var guyPath: String

@onready var guyScene = load(guyPath)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_guy()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_guy() -> void:
	add_child(guyScene.instantiate())
