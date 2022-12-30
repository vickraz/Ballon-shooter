extends Node2D
class_name balloon

signal popped

onready var anim = $AnimatedSprite
var velocity = Vector2.ZERO

var type = "IDLE"

func _ready() -> void:
	if type == "IDLE":
		anim.animation = "red"
	else:
		anim.animation = "yellow"
		
	anim.frame = 0
	anim.playing = false

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

func _on_AnimatedSprite_animation_finished() -> void:
	emit_signal("popped")
	queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	anim.playing = true
