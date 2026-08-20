extends Node2D
#Selection Manager node takes in signal from unit to show what's selected
#Also takes in signal from map to have selected hex

var units_selected = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_unit_selected(unit_id) -> void:
	units_selected.append(unit_id)
	#print(unit_id)

#func _on_selected_hex(selected_hex) -> void:
	#var target_hex = selected_hex
	#if units_selected != null:
		#pass #add target hex to this specific unit in selected array
	##print("Target Hex Position:", selected_hex)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
