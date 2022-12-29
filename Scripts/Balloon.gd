extends Node2D
class_name balloon

signal popped

onready var anim = $AnimatedSprite

func _ready() -> void:
	anim.frame = 0
	anim.playing = false
	

func _on_AnimatedSprite_animation_finished() -> void:
	emit_signal("popped")
	queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	anim.playing = true
