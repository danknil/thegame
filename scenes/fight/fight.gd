extends Node2D
class_name FightScene

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	var newScene = load("res://world.tscn")
	get_tree().change_scene_to_packed(newScene)
