extends Node2D

@onready var lift = $/root/Game/skilift as skilift
@onready var manager = $/root/Game/GuyManager as guyManager
@onready var seat_manager = $/root/Game/skilift/Path2D/PathFollow2D/Sprite2D/SeatManager

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is not guy):
		return
 # Getting the guy's group
	var guyObject = body as guy
	var groupId = guyObject.groupId
	var group = manager.getGroupById(groupId)
	var groupSize = group.size()
	var spaceLeft = lift.currentSize - lift.fillAmount

	if groupSize > spaceLeft:
		print("Group is too large to fit on the ski lift!")
		return

	manager.removeGroup(group)
	lift.addGroup(group)
