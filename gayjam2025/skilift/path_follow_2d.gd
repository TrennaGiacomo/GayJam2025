extends PathFollow2D

@export var speed: float = 1.0
@onready var skilift = $"../.." as skilift
@onready var gate_anim = $AnimatedSprite2D

var stopped_already: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !skilift.waiting:
		progress_ratio += speed * delta
	
	if progress_ratio >  0.45 && !stopped_already:
		stopped_already = true
		skilift.startWaiting()
	
	if progress_ratio >= 1.0:
		stopped_already = false
		progress_ratio = 0.0 
		skilift.getNewSkilift()
