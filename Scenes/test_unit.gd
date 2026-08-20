extends Area2D

#signals
signal unit_selected(unit_id: String)

var head_armor = 10
var center_torso_armor = 30
var left_torso_armor = 20
var right_torso_armor = 20
var left_arm_armor = 20
var right_arm_armor = 20
var left_leg_armor = 10
var right_leg_armor = 10

@export var unit_id: String = ""

func _on_unit_not_clicked() -> void:
	set_selected(false)

func set_selected(switch_on: bool) -> void:
	$Line2D.visible = switch_on

#Selection with mouse code
#On left clicking on unit card highlights unit card and emits signal
#to SelectionManager node which then adds it to a units_selected array
#This tracks the units that are selected so code can be triggered like UI
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_selected(true)
			#print(unit_id)
			unit_selected.emit(unit_id)
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			set_selected(false)

#pathfinding code
func _on_selected_hex(selected_hex) -> void:
	if $Line2D.visible == true:
		plan_move(selected_hex)
		print("Target Hex Position:", selected_hex, unit_id)

#turn code?
var planned_move = null

func plan_move(target_hex: Vector2i) -> void:
	#if TurnManager.current_phase == TurnManager.Phase.Planning:
	#planned_move = $"../../Map".map_to_local(target_hex) #sets planned move
	planned_move = (target_hex)
	print(planned_move)
