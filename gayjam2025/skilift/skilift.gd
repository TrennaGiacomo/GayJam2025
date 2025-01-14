extends Node2D
class_name skilift;

@export var minTime: float;
@export var maxTime: float;

@export var minSize: int;
@export var maxSize: int;

@onready var seatManager = $Path2D/PathFollow2D/Sprite2D/SeatManager as SeatManager

var currentSize: int;
var fillAmount: int;

var waiting: bool;

var timeRemaining: float;

func getNewSkilift():
	currentSize = randi_range(minSize, maxSize);
	timeRemaining = randf_range(minTime, maxTime);

	waiting = true;
	fillAmount = 0;
	pass;

# Add group of guys to lift
func addGroup(group: Array) -> void:
	if (not group || group.size() < 1):
		printerr("Invalid group passed in addGroup")
		return
		
	for i in group:
		if (i is not guy):
			continue
		
		var member = i as guy
		member.onEnterLift()
		seatManager.removeSeat()
		
	fill(group.size())
	pass

func fill(amount: int):
	if(fillAmount + amount > currentSize):
		return;
	
	fillAmount += amount;
	var spaceLeft = currentSize - fillAmount
	
	if(spaceLeft == 0):
		# Do stuff when the lift is filled
		print("Lift filled")
		pass;

	pass;

func _process(delta):
	if(waiting):
		timeRemaining -= delta;
		
		if(timeRemaining < 0):
			waiting = false;
			#Do stuff when time runs out
	pass
