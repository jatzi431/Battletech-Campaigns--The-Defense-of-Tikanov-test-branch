extends Label

@onready var day = 1
@onready var month = 1
@onready var year = 3028

func _ready() -> void:
	text = "%s/%s/%s" % [month, day, year]
	

func _on_turn_ended() -> void:
	day = day + 1
	if month == 1 or 3 or 5 or 7 or 8 or 10 or 12:
		if day == 32:
			day = 1
			month = month + 1
	elif month == 2:
		if day == 29:
			day = 1
			month = month + 1
	elif month == 4 or 6 or 9 or 11:
		if day == 31:
			day = 1
			month = month + 1
	text = "%s/%s/%s" % [month, day, year]
