extends Node2D

const DisappearButton = preload("res://dissapearingbutton.tscn")

var game_running = false
var circle_size = 40.0
var button_time = 2.0
var score = 0
var sounds = []


func _ready():
	sounds = [load("res://indo2.wav"),
		load("res://indo3.wav"),
		load("res://indo4.wav"),
		load("res://panio1.wav"),
		load("res://piano2.wav"),
		load("res://piano3.wav")]
	$UI/score.visible = false
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

func on_button_clicked(index):
	score = score + 1
	$UI/score.text = "score: " + str(score)
	$Soundplayer.stream = sounds[index]
	$Soundplayer.pitch_scale = randf_range(0.8, 1.2)
	$Soundplayer.play()
	spawn_button()

	await get_tree().create_timer(0.2).timeout

	$Soundplayer.volume_db = -10
	$Soundplayer.pitch_scale = randf_range(0.5, 2.5)
	$Soundplayer.play()

func on_button_missed():
	game_running = false
	$UI/Gameover.visible = true
	$UI/restart.visible = true

func start_game():
	game_running = true
	$UI/score.visible = true
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
	

	
	
