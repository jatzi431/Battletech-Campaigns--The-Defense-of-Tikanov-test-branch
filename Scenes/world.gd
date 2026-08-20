extends Node2D

#Script is for controlling map, unit locations, fog of war, unit movement?

#signals for unit selection
#signal unit_clicked
signal unit_not_clicked

@onready var unit_spawn_pos = $PlayerUnitSpawnMarker
@onready var player_unit_container = $PlayerUnitContainer
@onready var map = $Map
@onready var selection_manager = $SelectionManager

#Loading scenes is better for units, bullets, things that are dynamic
var test_unit = load("res://Scenes/Test Unit.tscn")

#Selection manager array
var currently_selected_unit: int = -1
var selected_units:Array = []

func _ready() -> void:
	spawn_unit(Vector2i(5, 3), "1st Guards") #Grid is 24x13 for now
	spawn_unit(Vector2i(11, 7), "2nd Guards")



func spawn_unit(hex_coords: Vector2i, name: String) -> void:
	var new_unit = test_unit.instantiate() #instancing a new unit
	var world_position = map.map_to_local(hex_coords) #Getting coords from function name
	new_unit.position = world_position #setting position = to coords
	player_unit_container.add_child(new_unit) #Adding child to container node
	new_unit.unit_id = name #Setting name of new child from function
	print(world_position)
	#connecting signal from parent to instantiated child:
	#instantiate child, have signal in parent code, connect via code after
	#Syntax: self.signal.connect(child.method)
	#self.unit_clicked.connect(new_unit._on_unit_clicked)
	self.unit_not_clicked.connect(new_unit._on_unit_not_clicked)
	map.selected_hex.connect(new_unit._on_selected_hex)
	new_unit.unit_selected.connect(selection_manager._on_unit_selected)

#func check_if_something_at_position(target:Vector2):
	#var space_state = get_world_2d().direct_space_state
	#var query = PhysicsPointQueryParameters2D.new()
	#query.collide_with_areas = true
	#query.position = target
	#var result:Array = space_state.intersect_point(query, 32)
	##Result is an array of dictionaries, right?
	#if result:
		#return result

#function for deselection stuff
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			if event.pressed == true:
				unit_not_clicked.emit()
