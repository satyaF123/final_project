extends Node2D

const DisappearButton = preload("res://dissapearingbutton.tscn")

func _ready():
	spawn_button()

func spawn_button():
	var b = DisappearButton.instantiate()
	var screen = get_viewport_rect().size
	b.position = Vector2(
		randf_range(50, screen.x - 50),
		randf_range(50, screen.y - 50)
	)
	add_child(b)
