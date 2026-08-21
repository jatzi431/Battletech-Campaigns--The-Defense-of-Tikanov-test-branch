extends Node2D
#Controls turn phases and sets some actions for each phase.
#Main actions in planning phase are declaring moves and attacks
#Executing phase is about conducting moves and attacks
#Tie switching phases into UI button

@onready var PlayerUnitContainer: Node2D = $World/PlayerUnitContainer
enum Phase {Planning, Executing }

signal phase_changed(new_phase)
signal turn_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.turn_ended.connect($"../CanvasLayer/Date_Label"._on_turn_ended)

func set_phase(new_phase: Phase) -> void:
	var current_phase = new_phase
	emit_signal("phase_changed", current_phase)
	print(current_phase)
	if current_phase == Phase.Executing:
		print("Executing Phase")
		run_execution_phase()

#func end_planning_phase() -> void:
	#if current_phase == Phase.Planning:
		#set_phase(Phase.Executing)

func run_execution_phase() -> void:
	print("Running turn")
	#var units = get_tree().get_nodes_in_group("PlayerUnitContainer")
	var units = $"../World/PlayerUnitContainer".get_children()
	print(units)
	var moving_units = []
	
	#Units that have valid actions added to moving_units array
	#Unit in Units is how you select something from an array
	for unit in units:
		if unit.planned_move != null:
			moving_units.append(unit)
			print(moving_units)
	if moving_units.is_empty():
		print("No Units are moving turn is over")
		set_phase(Phase.Planning)
		return
	for unit in moving_units:
		print("Old position:", unit.position, "Unit:", unit.unit_id)
		unit.position = unit.planned_move
		print("New position", unit.position)
		#await unit.execute_planned_action() # Uses tweens for smooth glide
	# Clear and loop back to planning
	#for unit in units:
		#unit.planned_action = null
	set_phase(Phase.Planning)


func _on_turn_button_pressed() -> void:
	print("Ending Turn")
	set_phase(Phase.Executing)
	emit_signal("turn_ended")
