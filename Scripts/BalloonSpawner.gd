extends Node



const balloon_scene = preload("res://Scenes/Balloon.tscn")

const HEIGHT = 600
const WIDTH = 1080

var spawntime := 2.0
var time := 0.0

onready var ballista = get_parent().get_node("Ballista")

func _ready() -> void:
	randomize()
	yield(get_tree().create_timer(0.2), "timeout")
	spawn_balloon()
	

#func _process(delta: float) -> void:
#	time += delta
#	if time >= spawntime:
#		time = 0.0
#		spawn_balloon()

func spawn_balloon() -> void:
	if ballista:
		yield(get_tree().create_timer(2.0), "timeout")
		var balloon = balloon_scene.instance()
		
		var x = rand_range(700, WIDTH - 300)
		var y = rand_range(100, HEIGHT - 100)
		
		print(x)
		print(y)
		print()
		
		balloon.connect("popped", self, "spawn_balloon")
		balloon.global_position = Vector2(x, y)
		ballista.target_pos = Vector2(x, y)
		
		add_child(balloon)
