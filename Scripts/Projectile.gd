extends KinematicBody2D
class_name projectile

const LIFETIME = 5
var time := 0.0
var velocity := Vector2.ZERO
var moving := false

const MEAN_VELOCITY = 700
const GRAVITY = 720


func _physics_process(delta: float) -> void:
	if moving:
		time += delta
		if time >= LIFETIME:
			queue_free()
		
		velocity = move_and_slide(velocity)
		
		velocity.y += GRAVITY * delta
		global_rotation = velocity.angle()


func set_velocity(vel: Vector2) -> void:
	moving = true
	vel = vel.limit_length(1200)
	velocity = vel

