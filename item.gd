extends Node2D

var temp_K = 293.0
var temp_outside_K = 293.0 setget set_temp_outside
export var R_treshold = 380.0
export var R = 0.0 setget ,get_R
export var k_temp = 0.1
export var k_R = 0.1

#func _init(temp):
#	temp_K = temp
#	temp_outside_K = temp

func _ready():
	set_process(false)

func _process(delta):
	var temp_delta = temp_outside_K - temp_K
	var is_different = abs(temp_delta) > 5
	if is_different:
		
		temp_K += (temp_outside_K - temp_K) * k_temp * delta
	else:
		temp_K = temp_outside_K
	
	if temp_K > R_treshold:
		R += temp_K * k_R * delta
	
	if !is_different and temp_K <= R_treshold:
		temp_K = temp_outside_K
		set_process(false)

func set_temp_outside(temp):
	
	temp_outside_K = temp
	
	if temp_outside_K != temp_K:
		set_process(true)

func get_R():
	# collapse state to some integer
	return floor(R)


