extends Control

@export_file var mainScene

func _on_exit_button_pressed():
	get_tree().quit();
	pass # Replace with function body.

func _on_credits_button_pressed():
	get_tree().change_scene_to_file(mainScene);
	pass # Replace with function body.

func _on_start_game_button_pressed():
	pass # Replace with function body.
