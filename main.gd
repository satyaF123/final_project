extends Node2D

const DissapearButton = preload("res://dissapearingbutton.tscn")

var game_running = false

func _ready():
	$UI/Gameover.visible = false
	$UI/restart.visible = false
	$UI/start.visible = true

func spawn_button():
	if not game_running:
		return
	var b = DissapearButton.instantiate()
	var screen = get_viewport_rect().size
	b.position = Vector2(
		randf_range(50, screen.x - 50),
		randf_range(50, screen.y - 50)
	)
	b.missed.connect(on_button_missed)
	add_child(b)

func on_button_missed():
	game_running = false
	$UI/Gameover.visible = true
	$UI/restart.visible = true

func start_game():
	game_running = true
	$UI/Gameover.visible = false
	$UI/restart.visible = false
	$UI/start.visible = false
	spawn_button()

func _on_start_pressed() -> void:
	start_game()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
