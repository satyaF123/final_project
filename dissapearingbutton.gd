extends Node2D

var radius = 40.0

func _ready():
	$Timer.wait_time = 15
	$Timer.one_shot = true
	$Timer.start()

func _draw():
	draw_circle(Vector2.ZERO, radius, Color(0.2, 0.6, 1.0))

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var distance = global_position.distance_to(event.global_position)
			if distance <= radius:
				queue_free()

func _on_timer_timeout():
	queue_free()
