class_name BoardControl
extends Control


var _parent: BoardControl = null
var _use_mouse: bool = false
var _mouse_down: bool = false

# TODO: only render these on parent
@export var path_to_board: NodePath
@export var push_power: float = 10
@export var drag: float = 5

var on_board = false


#should we use _init instead?
func _ready() -> void:
	var p = get_parent()
	if p is BoardControl:
		_parent = p
		return
	
	if !DisplayServer.is_touchscreen_available():
		_use_mouse = true
	
	


func _handleEvent(event: InputEvent) -> void:
	# capture event and bubble up to root
	if _parent != null:
		_parent._handleEvent(event)
		return
	
	if event is InputEventScreenTouch:
		if _use_mouse:
			return
		Printer.print_debug(str("touch: ", event.index, " ", event.pressed), event.called_by)
	elif event is InputEventScreenDrag:
		if _use_mouse:
			return
		Printer.print_debug(str("drag: ", event.index, " ", Printer.get_direction(event.velocity)), event.called_by)
		pass
	elif event is InputEventMouseButton:
		if !_use_mouse || event.button_index != 1:
			return
		_mouse_down = event.pressed
		Printer.print_debug(str("click"), event.called_by)
	elif event is InputEventMouseMotion:
		if !_use_mouse:
			return
		Printer.print_debug(str("mouse move: ", Printer.get_direction(event.velocity)), event.called_by)
	else:
		Printer.print_debug(str("unhandled event type: ", event.get_class()), event.called_by)

func _handle_touch():
	pass



func _gui_input(event: InputEvent) -> void:
	event.called_by = self
	event.onBoard == _parent != null
	_handleEvent(event)
