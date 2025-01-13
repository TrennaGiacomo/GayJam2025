extends CanvasLayer
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score=10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	score+=score
	
	$Score.text= str(score)
	
