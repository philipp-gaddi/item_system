extends Node2D

# background info
# heat capacity
# convection, conduction and radiation are mechanism of heat transfer.
# conduction heat transfer between bodies, via diffusion and contact
# convection, heat transfer between solid and fluid (if the fluid isn't moving
# it's conduction). Two types forced (Fan) and free (buoyancy) convection. 
# the parameter h in convection depends on the fluid case (turbulent, free flowing, forced etc.)
# find constants, not worth calculating.
# radiation

# heat capacity Q = m * s * T_delta
# convection Q/t = h * A * (T_surface - T_fluid_far) # natural
# conduction Q/t = s * A * T_delta/x_delta
# radiation Q/t = boltzmann * emissive * A * T_abs

# simplification and implementation
# radiation, has a fixed radius
# conduction for non moving fluids
# convection only natural, external flow, and free flow
# all is one dimensional (equal in each direction)
# energy level/outside temp affects temp change, temp between things/object not
# radiation only affects object not in use
# heat always flows from warm to cold, no cooling through conduction
# only modeling of net flows, no idle flow random, equilibrium flows 


# example: if you cook on water in a plate. the plate gets heated via conduction
# the water in the plate gets heated via convection/conduction
# all parts radiate heat, which is not considered

signal temperature_changed


#### Parameters and constants of this material
# TODO make a list of materials, and set these constants in the ready function
export var specific_heat_capacity = 9.1813 # J/(kg*K)
export var thermal_conductivity = 0.025 # insultator W/(M *K)
export var heat_transfer_coefficient = .01 # W/(M2*K)
export var emissivity = 0.95
const boltzmann = 5.67e-8 # m2 * kg / s2 * K


export var mass_KG = 1.0
export var surface_area_M2 = 0.06
export var x_delta_M = 1.0 

# TODO what's a good treshold, when is 99, 95% reached?
const treshold = 1.0
var Q_J
var Q_provide_JoS = 0.0 setget set_Q_provide_JoS
var T_K = 293.15
var T_outside_K = 293.15

var heat_capacity
var radiation_factor

var R_convection_outside
var R_conduction
var R_total

func _ready():
	heat_capacity = mass_KG * specific_heat_capacity
	radiation_factor = boltzmann * emissivity * surface_area_M2
	R_convection_outside = 1.0 / (surface_area_M2 * heat_transfer_coefficient)
	R_conduction = x_delta_M / (surface_area_M2 * thermal_conductivity)
	R_total = R_conduction + R_convection_outside
	Q_J = T_K / heat_capacity
	set_process(false)


func _process(delta):
	var T_delta = T_outside_K - T_K
	var Q_delta = delta * T_delta / R_total
	
	Q_J += Q_delta
	T_K = Q_J * heat_capacity
	
	if abs(T_delta) < treshold:
		set_process(false)
	
	emit_signal("temperature_changed", T_K)



func set_Q_provide_JoS(_Q_provide_JoS):
	
	Q_provide_JoS = _Q_provide_JoS


func set_T_outside_K(_T_outside_K):
	T_outside_K = _T_outside_K
	
	if abs(_T_outside_K - T_K) < treshold:
		T_K = _T_outside_K
		
	else:
		set_process(true)

func get_radiation():
	
	return radiation_factor * pow(T_K, 4.0)






























func _on_heat_radiation_body_entered(body):
	# add radiation to it's Q input
	# register?
	pass # Replace with function body.


func _on_heat_radiation_body_exited(body):
	# remove the radiation from it's Q input
	pass # Replace with function body.
