extends Node2D

# really simplified model of heat transfer is used
# heat is dependent on the outside temperature, which you can set, 
# then based on the temperature delta, the temperature of the object changes.
# using conduction formulas

const compare_treshold = .1

var temperature = 293.0 setget , get_temperature
var temperature_outside = 293.0 setget set_temperature_outside

# Q = m * k * T_delta 
# conduction Q_over_t = c * A * T_delta / x_delta
export var specific_heat_capacity = 4.1813 # water
export var thermal_conductivity = 0.6 # water # 0.024 # air

# problem with this approach values have to make sense... hard to tune
# need to have some approximater
export var mass_kg = 1.0
export var surface_area_m2 = .06 # 0.1 * 0.1 * 6
export var x_delta_m = .005


func _ready():
	
	set_process(false)


func _process(delta):
	var temperature_diff = temperature_outside - temperature
	
	if abs(temperature_diff) < compare_treshold:
		
		temperature = temperature_outside
		set_process(false)
	else:
		
		temperature += delta * sign(temperature_diff) * (mass_kg * specific_heat_capacity * temperature_diff) / \
		(thermal_conductivity * surface_area_m2 * temperature_diff / x_delta_m)


func set_temperature_outside(_temperature_outside):
	if abs(temperature_outside - _temperature_outside) > compare_treshold:
		temperature_outside = _temperature_outside
		
		set_process(true)
	

func get_temperature():
	
	return temperature
