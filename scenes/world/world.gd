extends Node2D
class_name GameWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		$CanvasLayer/ExitMenu.toggle()
		get_tree().paused = !get_tree().paused
