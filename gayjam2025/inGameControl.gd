extends Control

@export_file var mainMenu

func _on_exit_button_pressed():
	get_tree().change_scene_to_file(mainMenu);
