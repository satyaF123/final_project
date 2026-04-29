extends Node2D

var radius = 40.0
var wait_time = 2.0

signal missed
signal clicked

func _ready():
	$Timer.wait_time = wait_time
	$Timer.one_shot = true
	$Timer.start()

func _draw():
	draw_circle(Vector2.ZERO, radius, Color(0.2, 0.6, 1.0))

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var distance = global_position.distance_to(event.global_position)
			if distance <= radius:
				clicked.emit()
				queue_free()

func _on_timer_timeout():
	missed.emit()
	queue_free()
