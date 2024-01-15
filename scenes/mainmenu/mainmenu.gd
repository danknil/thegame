extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_button_pressed():
	var worldFile = "res://scenes/world/world.tscn"
	if (ResourceLoader.exists("res://world.tscn")):
		worldFile = "res://world.tscn"
	get_tree().change_scene_to_file(worldFile)

func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
