extends Control

@export_file var mainScene

@onready var hissipoika_neutral = $HissipoikaNeutral
@onready var hissipoika_happy = $HissipoikaHappy
@onready var hissipoika_sad = $HissipoikaSad

func _ready():
	pass
	#for node in $Buttons.get_children():
		#if node is Button:
			#node.connect("mouse_entered", Callable(self, "_on_button_mouse_entered").bind([node]))
			#node.connect("mouse_exited", Callable(self, "_on_button_mouse_exited").bind([node]))

func _on_exit_button_pressed():
	get_tree().quit();
	pass # Replace with function body.

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file(mainScene);

#func _on_button_mouse_entered(button: Button):
	#match button.name:
		#"StartGameButton":
			#hissipoika_happy.show()
			#hissipoika_neutral.hide()
			#hissipoika_sad.hide()	
		#"CreditsButton":
			#hissipoika_happy.show()
			#hissipoika_neutral.hide()
			#hissipoika_sad.hide()	
		#"ExitButton":
			#hissipoika_happy.hide()
			#hissipoika_neutral.hide()
			#hissipoika_sad.show()	
	#
#func _on_button_mouse_exited(button: Button):
	#hissipoika_happy.hide()
	#hissipoika_neutral.show()
	#hissipoika_sad.hide()	
