extends Node2D


var target: balloon
var can_shoot := true
var targets := []

onready var rotationalPoint = $RotationalPoint
onready var arrowSpawn = $RotationalPoint/ArrowSpawn

var projectile_scene = preload("res://Scenes/Projectile.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fire") and can_shoot:
		targets = get_tree().get_nodes_in_group("Balloons")
		if len(targets) == 0:
			target = null
		else:
			target = targets[0]
		_shoot()
		
		
func _shoot() -> void:
	can_shoot = false
	
	var projectile = projectile_scene.instance()
	projectile.global_position = arrowSpawn.global_position
	projectile.global_rotation = rotationalPoint.global_rotation
	projectile.spawn_point = arrowSpawn
	get_parent().add_child(projectile)
	
	var vel
	if target:
		#vel = projectile.calc_velocity2(target.global_position, target.velocity, 0.3)
		vel = projectile.calc_velocity(target.global_position, target.velocity, 0.3)
	else:
		#vel = projectile.calc_velocity2(get_global_mouse_position(), Vector2.ZERO, 0.3)
		vel = projectile.calc_velocity(get_global_mouse_position(), Vector2.ZERO, 0.3)
		
	var desired_rotation = vel.angle()
	target = null
	var _tween = create_tween()
	_tween.tween_property(rotationalPoint, "rotation", desired_rotation, 0.3)
	yield(_tween, "finished")
	projectile.set_velocity(vel)
	can_shoot = true
