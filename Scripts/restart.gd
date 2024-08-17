extends Control


func _reset():
	print("resetting");
	get_tree().reload_current_scene();
