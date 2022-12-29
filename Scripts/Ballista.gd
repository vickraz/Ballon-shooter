extends Node2D


var target_pos := Vector2.ZERO

onready var rotationalPoint = $RotationalPoint
onready var arrowSpawn = $RotationalPoint/ArrowSpawn

var projectile_scene = preload("res://Scenes/Projectile.tscn")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var projectile = projectile_scene.instance()
		projectile.global_position = arrowSpawn.global_position
		
		var vel := calc_velocity()
		var angle = vel.angle()
		rotationalPoint.rotation = angle
		
		projectile.set_velocity(vel)
		get_parent().add_child(projectile)
		target_pos = Vector2.ZERO


func calc_velocity() -> Vector2:
	if target_pos == Vector2.ZERO:
		target_pos = get_global_mouse_position()
	
	var displacement = target_pos - arrowSpawn.global_position
	var velocity = displacement.normalized() * 1000
	return velocity
		
		
