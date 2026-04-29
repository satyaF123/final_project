extends Node2D

const DisappearButton = preload("res://dissapearingbutton.tscn")

var game_running = false
var circle_size = 40.0
var button_time = 2.0

func _ready():
	$UI/Gameover.visible = false
	$UI/restart.visible = false
	$UI/start.visible = true
	$UI/size.visible = true
	$UI/time.visible = true
	$UI/sizelabel.visible = true
	$UI/timelabel.visible = true

func spawn_button():
	if not game_running:
		return
	var b = DisappearButton.instantiate()
	var screen = get_viewport_rect().size
	b.position = Vector2(
		randf_range(50, screen.x - 50),
		randf_range(50, screen.y - 50)
	)
	b.radius = circle_size
	b.wait_time = button_time
	b.missed.connect(on_button_missed)
	b.clicked.connect(on_button_clicked)
	add_child(b)

func on_button_clicked():
	play_random_note()
	spawn_button()

func on_button_missed():
	game_running = false
	$UI/Gameover.visible = true
	$UI/restart.visible = true

func start_game():
	game_running = true
	$UI/Gameover.visible = false
	$UI/restart.visible = false
	$UI/start.visible = false
	$UI/size.visible = false
	$UI/time.visible = false
	$UI/sizelabel.visible = false
	$UI/timelabel.visible = false
	spawn_button()

func _on_start_pressed() -> void:
	start_game()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_size_value_changed(value: float) -> void:
	circle_size = value
	$UI/sizelabel.text = "Circle Size: " + str(int(value))


func _on_time_value_changed(value: float) -> void:
	button_time = value
	$UI/timelabel.text = "Time: " + str(snappedf(value, 0.1)) + "s"
	
func play_random_note():
	$AudioStreamPlayer2D.pitch_scale = randf_range(0,1.2)
	$AudioStreamPlayer2D.play()
	
	
