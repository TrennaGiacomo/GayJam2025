extends Node2D

@onready var lift = $/root/Game/skilift as skilift
@onready var manager = $/root/Game/GuyManager as guyManager

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is not guy):
		return
	
	var guyObject = body as guy
	var groupId = guyObject.groupId
	
	var group = manager.getGroupById(groupId)
	manager.removeGroup(group)
	lift.addGroup(group)
