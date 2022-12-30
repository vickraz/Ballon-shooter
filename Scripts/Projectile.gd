extends KinematicBody2D
class_name projectile

const LIFETIME = 5
var time := 0.0
var velocity := Vector2.ZERO
var moving := false
var spawn_point = null #Sätts av ballista vid spawn

const GRAVITY = 720.0
const MEAN_REALATIVE_VELOCITY = 800.0

const V = 900.0


func _physics_process(delta: float) -> void:
	if moving:
		time += delta
		if time >= LIFETIME:
			queue_free()
		
		velocity = move_and_slide(velocity, Vector2.UP)
		
		velocity.y += GRAVITY * delta
		global_rotation = velocity.angle()
		if is_on_floor():
			queue_free()
	else:
		global_position = spawn_point.global_position
		global_rotation = spawn_point.global_rotation


func set_velocity(vel: Vector2) -> void:
	moving = true
	vel = vel.limit_length(1200)
	velocity = vel

func calc_velocity(initial_pos: Vector2, t_vel: Vector2, rot_time: float = 0.3) -> Vector2:
	var target_pos
	if t_vel == Vector2.ZERO:
		target_pos = initial_pos
	else:
		target_pos = initial_pos + t_vel * rot_time
	
	var target_velocity: Vector2
	var displacement = target_pos - global_position
	var t = displacement.length() / MEAN_REALATIVE_VELOCITY
	target_velocity.x = displacement.x / t
	target_velocity.y = displacement.y / t - GRAVITY * t / 2
	target_velocity += t_vel
	
	return target_velocity


func calc_velocity2(initial_pos: Vector2, t_vel: Vector2, rot_time: float = 0.3) -> Vector2:
	var target_velocity: Vector2
	var start_pos := initial_pos + t_vel * rot_time
	var d := start_pos - global_position
	var a = t_vel.x * t_vel.x + t_vel.y * t_vel.y - V*V
	var b = 2*t_vel.x*d.x + 2*t_vel.y*d.y
	var c = d.x * d.x + d.y * d.y
	
	var t1 = (-b - sqrt(b*b - 4 * a * c)) / (2 * a)
	var t2 = (-b + sqrt(b*b - 4 * a * c)) / (2 * a)
	
	var t = max(t1, t2)
	
	#Positionen för kollission
	var x = start_pos + t * t_vel
	
	var direction = (x - global_position).normalized()
	target_velocity = direction * V
	
	var anti_gravity_v = -GRAVITY * t / 2
	
	target_velocity.y += anti_gravity_v
	
	return target_velocity

