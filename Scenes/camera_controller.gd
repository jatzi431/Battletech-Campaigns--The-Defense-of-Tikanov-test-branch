extends Camera2D

#called when the node enters the scene tree for the first time
func _ready() -> void:
	pass
	


func _process(_delta: float) -> void:
	zoom_in()
	zoom_out()
	set_drag_margin(SIDE_LEFT,1) #Cast integer as enum type by literally typing out enum
	set_drag_margin(SIDE_RIGHT,1)
	set_drag_margin(SIDE_BOTTOM,1)
	set_drag_margin(SIDE_TOP,1)
	#set_drag_horizontal_enabled(true) #Turns on horizontal and vertical dragging
	#set_drag_vertical_enabled(true) #Notably, turns off camera movement if drag_margin set to 1 unless side of screen is touched

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative * (zoom * 0.5)


func zoom_in():
	if Input.is_action_just_pressed("Zoom_in"):
		zoom = zoom * 1.1 #Changes zoom value in inspector that you can set manually

func zoom_out():
	if Input.is_action_just_pressed("Zoom_out"):
		zoom = zoom * 0.9
