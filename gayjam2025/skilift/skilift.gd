extends Node2D
class_name skilift

@export var minTime: float
@export var maxTime: float

@export var minSize: int
@export var maxSize: int

@onready var seatManager = $Path2D/PathFollow2D/Sprite2D/SeatManager as SeatManager

@onready var audioSrc = $AudioStreamPlayer as AudioStreamPlayer
@export_file var placeSoundPath: String
@export_file var arriveSoundPath: String
@export_file var leaveSoundPath: String

@onready var seat_counter = $"../Clock_Counter/Control/SeatCounter"

@onready var closed_cover = $"../Clock_Counter/ClosedCover"
@onready var open_cover = $"../Clock_Counter/OpenCover"


var placeSound: AudioStream
var arriveSound: AudioStream
var leaveSound: AudioStream

var currentSize: int;
var fillAmount: int;

var waiting: bool
var timeRemaining: float

func _ready():
	closed_cover.show()
	open_cover.hide()
	
	getNewSkilift();
	placeSound = load(placeSoundPath) as AudioStream
	arriveSound = load(arriveSoundPath) as AudioStream
	leaveSound = load(leaveSoundPath) as AudioStream

func getNewSkilift():
	currentSize = randi_range(minSize, maxSize);
	seat_counter.text = str(currentSize)
	openCover()
	
	fillAmount = 0;

	seatManager.MakeSeats(currentSize);
	playSound(arriveSound)
	pass;

func startWaiting():
	timeRemaining = randf_range(minTime, maxTime);
	waiting = true;

# Add group of guys to lift
func addGroup(group: Array) -> void:
	if not group or group.size() < 1:
		printerr("Invalid group passed in addGroup")
		return

	# Ensuring the group fits within the remaining capacity I hope :D
	if fillAmount + group.size() > currentSize:
		printerr("Group cannot fit in the ski lift! Remaining space:", currentSize - fillAmount)
		return

	# Adding each guy in the group to the lift
	for i in range(group.size()):
		if group[i] == null or group[i] is not guy:
			continue

		var member = group[i] as guy
		seatManager.setSeat(fillAmount + i, member.backTexture)
		member.onEnterLift()
	
	playSound(placeSound)
	fill(group.size())
	pass
	
func playSound(sound: AudioStream) -> void:
	if (not sound):
		printerr("Invalid sound")
		return
		
	audioSrc.stream = sound
	audioSrc.play()


func fill(amount: int) -> void:
	if fillAmount + amount > currentSize:
		return

	fillAmount += amount
	var spaceLeft = currentSize - fillAmount

	if spaceLeft == 0:
		# Do stuff when the lift is filled
		print("Lift filled")

func _process(delta):
	if(waiting):
		timeRemaining -= delta;
		
		if(timeRemaining < 0):
			waiting = false;
			playSound(leaveSound)
			closeCover()
	pass

func openCover():
	await wait(.5)
	closed_cover.hide()
	open_cover.show()
	await wait(.5)
	open_cover.hide()

func closeCover():
	await wait(.5)
	open_cover.show()
	await wait(.5)
	open_cover.hide()
	closed_cover.show()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
