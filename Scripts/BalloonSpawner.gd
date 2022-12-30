extends Node2D



const balloon_scene = preload("res://Scenes/Balloon.tscn")

const HEIGHT = 750
const WIDTH = 1280

var spawntime := 2.0
var time := 0.0

onready var ballista = get_parent().get_node("Ballista")

func _ready() -> void:
	randomize()
	yield(get_tree().create_timer(0.2), "timeout")
	spawn_balloon()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("add_moving_balloon"):
		var balloon = balloon_scene.instance()
		balloon.global_position = get_global_mouse_position()
		balloon.type = "MOVING"
		balloon.velocity = Vector2(rand_range(-100, 100), rand_range(-100, 100))
		add_child(balloon)
		


func spawn_balloon() -> void:
	if ballista:
		yield(get_tree().create_timer(2.0), "timeout")
		var balloon = balloon_scene.instance()
		
		var x = rand_range(700, WIDTH - 100)
		var y = rand_range(100, HEIGHT - 100)
		
		balloon.connect("popped", self, "spawn_balloon")
		balloon.global_position = Vector2(x, y)
		add_child(balloon)
