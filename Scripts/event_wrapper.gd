class_name EventWrapper

var event: InputEvent
var called_by: Object
var on_board: bool
var is_mouse = false

func _init(p_event: InputEvent, p_called_by: Object, p_on_board: bool) -> void:
	event = p_event
	called_by = p_called_by
	on_board = p_on_board

func convert_mouse_to_touch():
	if event is InputEventMouseButton:
		var new_event = InputEventScreenTouch.new()
			
		new_event.index = 0
		new_event.position = event.position
		new_event.pressed = event.pressed
		
		event = new_event
	elif event is InputEventMouseMotion:
		var new_event = InputEventScreenDrag.new()
		
		new_event.index = 0
		new_event.velocity = event.velocity
		new_event.position = event.position
		
		event = new_event
	else:
		push_warning("attempted to convert non-mouse event ", event.get_class() , " to touch")
