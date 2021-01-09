extends Node2D

var sixty_frame = 60
var frame = 0
var x = 0
var val2 = 350
var val3 = 250
var sw = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("cook"):
		if sw:
			print('set val2')
			$item_temperature.temperature_outside = val2
			sw = false
		else:
			print('set val3')
			$item_temperature.temperature_outside = val3
			sw = true
	
	var frame_modulo_class = frame % sixty_frame
	if frame_modulo_class == 0:
		print($item_temperature.temperature)
		update()
	frame += 1


func _draw():
	
	draw_circle(Vector2(x, -$item_temperature.temperature), 2.0, Color.red)
	x+=1
