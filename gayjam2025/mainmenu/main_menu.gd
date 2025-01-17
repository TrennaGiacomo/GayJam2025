extends Control

@export_file var mainScene

@onready var hissipoika_neutral = $HissipoikaNeutral
@onready var hissipoika_happy = $HissipoikaHappy
@onready var hissipoika_sad = $HissipoikaSad

@onready var start_game_button = $Buttons/StartGameButton
@onready var credits_button = $Buttons/CreditsButton
@onready var exit_button = $Buttons/ExitButton

func _ready():
	pass

func _on_exit_button_pressed():
	get_tree().quit();
	pass # Replace with function body.

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file(mainScene);

func _process(delta):
	if start_game_button.is_hovered() or credits_button.is_hovered():
		hissipoika_happy.show()
		hissipoika_neutral.hide()
		hissipoika_sad.hide()
		
	elif exit_button.is_hovered():
		hissipoika_happy.hide()
		hissipoika_neutral.hide()
		hissipoika_sad.show()
		
	else:
		hissipoika_happy.hide()
		hissipoika_neutral.show()
		hissipoika_sad.hide()
