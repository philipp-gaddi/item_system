extends Node2D


onready var item = get_node("item_base")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	item.set_T_outside_K(value)
	$Control/Panel/outside_K_value.text = str(value)


func _on_item_base_temperature_changed(T_K):
	$Control/Panel/item_K.text = str(T_K)
