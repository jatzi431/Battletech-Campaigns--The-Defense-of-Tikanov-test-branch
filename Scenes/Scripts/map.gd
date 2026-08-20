extends TileMapLayer

signal selected_hex(mouse_pos_hex: Vector2i)

#Grid for now is 24x14. To make the grid properly, line up lines in visual editor with top and side of hexes
#Create pathfinding grid
@onready var astar:AStar2D
@onready var hex_size: Vector2i = Vector2i(24, 14)

func _ready() -> void:
	astarStart()

func astarStart()-> void:
	var size = self.get_used_rect() #Getting size of hex grid
	astar = AStar2D.new() #instantiate Astar grid
	astar.reserve_space(size.size.x * size.size.y)  #Reserves space for nodes
	var idx: int = 1 #Initializing ID variable
	for i in size.size.x:
		for j in size.size.y:
			astar.add_point(idx, map_to_local(Vector2i(i,j))) #map to world or map to local?
			idx = idx + 1 #Incrementing on ID variable for next loop
	for i in size.size.x:
		for j in size.size.y:
			var neighbors = self.get_surrounding_cells(Vector2i(i,j)) #creates an array
			#print(neighbors)
			for neighbor in neighbors:
				var neighbor_id: int = astar.get_closest_point(map_to_local(neighbor))
				#print(neighbor)
				#print(neighbor_id)
				#have to use map_to_local then the vector2i cell coordinates to get astar node ID
				if not astar.are_points_connected(astar.get_closest_point(map_to_local(Vector2i(i,j))), neighbor_id):
					astar.connect_points(astar.get_closest_point(map_to_local(Vector2i(i,j))), neighbor_id)
	#print(size)
	#var testvar = astar.are_points_connected(1,2)
	#print(testvar)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			#Finding global pixel mouse coordinates
			var click_pos: Vector2 = get_global_mouse_position()
			#Finding hex ID mouse is in
			var pointId: int = astar.get_closest_point(click_pos)
			#Use the above pointID to identify local pixel coordinates
			#of the center of the hex with that ID using built-in Astar
			#function get_point_position
			var mouse_pos_hex: Vector2i = astar.get_point_position(pointId)
			#Emiting hex coords to be used in unit code for pathfinding
			#In order to emit vectors have to use this format instead of
			#emit_signal()
			selected_hex.emit(mouse_pos_hex)
			print("Selected Hex Unique ID:", pointId)
			#print(click_pos)
			#print(mouse_pos_hex)
