extends CharacterBody2D
class_name Enemy

@export var speed = 20
@export var gameScene: Node2D
@export var limit = 0.5

@onready var endPoint = $EndPoint

@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer

@onready var enterFight = $EnterFight
@onready var detection = $Detection

var startPosition
var endPosition
var isFollowing = false

var playerArea: Area2D
var fight = preload("res://scenes/fight/fight.tscn")

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	self.enterFight.connect("area_entered", self._on_enter_fight_area_entered)
	self.detection.connect("area_entered", self._on_detection_area_entered)
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
		return
	
	var direction = "Down"
	var normalized_velocity = velocity.normalized()

	if normalized_velocity.x > 0.3: 
		direction = "Left"
	elif normalized_velocity.x < -0.3: 
		direction = "Right"
	elif normalized_velocity.y < -0.7: 
		direction = "Up"

	animations.play("walk" + direction)

func swap():
	var temp = endPosition
	endPosition = startPosition
	startPosition = temp

func _physics_process(_delta):
	if isFollowing:
		endPosition = playerArea.global_position
	velocity = endPosition - position
	if velocity.length() < limit:
		if !isFollowing:
			swap()
		return
	velocity = velocity.normalized() * speed
	updateAnimation()
	move_and_slide()


func _on_detection_area_entered(area):
	if area.name == "PlayerHitBox" && !isFollowing:
		speed *= 2
		playerArea = area
		isFollowing = true


func _on_enter_fight_area_entered(area):
	if area.name == "PlayerHitBox":
		# TODO: add smooth transition
		enterFight.set_deferred("monitoring", false)
		enterFight.set_deferred("monitorable", false)
		var packedScene = PackedScene.new()
		packedScene.pack(get_tree().current_scene)
		ResourceSaver.save(packedScene, "res://world.tscn")
		await get_tree().call_deferred("change_scene_to_packed", fight)
		
