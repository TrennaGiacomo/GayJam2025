extends Node2D

class_name SeatManager

@export_file var seatpath
@onready var seatScene=load(seatpath) as PackedScene
@onready var sprite: Sprite2D = $"../.";

var spacing = -50 # Spacing between sprites
var layout_mode = "horizontal"  # Options: "horizontal" or "vertical"

var seats: Array = []

@export var seatOptions: Array[Texture2D]
@export var seatSpacings: Array[float];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func removeSeat() -> void:
	if(seats.size() <= 0):
		return;
	var lastIndex = seats.size() - 1
	var last = seats[lastIndex]
	remove_child(last)
	seats.remove_at(lastIndex)
	arrange_sprites()

func setSeat(seatIndex: int, seatText: Texture2D) -> void:
	if(seatIndex >= seats.size()):
		return;
	var seatIns = seats[seatIndex];
	seatIns.texture = seatText;
	seatIns.scale = Vector2(.5,.5);
	arrange_sprites()

func MakeSeats(seatCount:int):
	sprite.texture = seatOptions[seatCount - 2];

	for oldSeat in seats:
		remove_child(oldSeat);
	seats.clear();

	while seatCount >0:
		var seatInstace = seatScene.instantiate() as seat
		add_child(seatInstace)
		seatInstace.name="seat"
		seatCount-=1
		seats.append(seatInstace)
		
	arrange_sprites()
	
func arrange_sprites():
	var total_width = 0
	var total_height = 0
	var sprite_count = 0

	var seatSpacing = spacing - seatSpacings[get_children().size() - 2]

	# Calculate total width/height of all sprites
	for child in get_children():
		if child is Sprite2D:
			sprite_count += 1
			total_width += child.texture.get_width() * child.scale.x + seatSpacing
			total_height += child.texture.get_height() * child.scale.x + seatSpacing



	# Remove extra spacing after the last sprite
	if sprite_count > 0:
		total_width -= seatSpacing
		total_height -= seatSpacing

	# Calculate starting offset for centering
	

	var offset = Vector2.ZERO
	if layout_mode == "horizontal":
		offset.x = total_width / sprite_count + 75
		offset.y += 50
	elif layout_mode == "vertical":
		offset.y = total_height / sprite_count

	# Position the sprites
	for child in get_children():
		if child is Sprite2D:
			child.position = sprite.position - sprite.texture.get_width() * sprite.scale / 2 + offset 
			if layout_mode == "horizontal":
				offset.x += child.texture.get_width() * child.scale.x + seatSpacing
			elif layout_mode == "vertical":
				offset.y += child.texture.get_height() * child.scale.x + seatSpacing
