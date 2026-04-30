extends Node2D

var radius = 40.0
var wait_time = 2.0
var thisnum = 0

signal missed
signal clicked(i)

func _ready():
	thisnum = randi_range(0,5)
	$Timer.wait_time = wait_time
	$Timer.one_shot = true
	$Timer.start()

func _draw():
	if thisnum == 0:
		draw_circle(Vector2.ZERO, radius, Color(1,0,0))
	if thisnum == 1:
		draw_circle(Vector2.ZERO, radius, Color(0,1,0))
	if thisnum == 2:
		draw_circle(Vector2.ZERO, radius, Color(0.28,0,0.128))
	if thisnum == 3:
		draw_circle(Vector2.ZERO, radius, Color(0.5,0,0.9))
	if thisnum == 4:
		draw_circle(Vector2.ZERO, radius, Color(0.2,0.8,0.8))
	if thisnum == 5:
		draw_circle(Vector2.ZERO, radius, Color(0.5,0.1,0))
		


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var distance = global_position.distance_to(event.global_position)
			if distance <= radius:
				clicked.emit(thisnum)
				queue_free()

func _on_timer_timeout():
	missed.emit()
	queue_free()
