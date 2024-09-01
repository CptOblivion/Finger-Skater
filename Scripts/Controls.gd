class_name BoardControl
extends Control


# TODO: only render these on parent
@export var push_power: float = 1.00
@export var drag: float = 5

var _parent: BoardControl = null
var _use_mouse: bool = false
var _mouse_down: bool = false
var _last_touch = [Vector2.ZERO, Vector2.ZERO]
var on_board = false


#should we use _init instead?
func _ready() -> void:
	var p = get_parent()
	if p is BoardControl:
		_parent = p
		return
	
	if !DisplayServer.is_touchscreen_available():
		_use_mouse = true


func _handleEvent(wrapper: EventWrapper) -> void:
	# capture event and bubble up to root
	if _parent != null:
		_parent._handleEvent(wrapper)
		return
	
	if wrapper.event is InputEventScreenTouch or wrapper.event is InputEventScreenDrag:
		wrapper.is_mouse = false
	elif wrapper.event is InputEventMouseButton:
		if !_use_mouse or wrapper.event.button_index != 1:
			return
		wrapper.is_mouse = true
		_mouse_down = wrapper.event.pressed
		wrapper.convert_mouse_to_touch()
	elif wrapper.event is InputEventMouseMotion:
		if !_mouse_down:
			return
		wrapper.is_mouse = true
		wrapper.convert_mouse_to_touch()
	_handle_touch(wrapper)


func _handle_touch(wrapper: EventWrapper):
	if _use_mouse != wrapper.is_mouse:
		return
	if wrapper.event is InputEventMouseButton:
		_mouse_down = wrapper.event.pressed
	
	if wrapper.event is InputEventScreenTouch:
		if wrapper.event.pressed:
			Printer.print_debug("click", wrapper.called_by)
			_last_touch[wrapper.event.index] = wrapper.event.position
		else:
			Board.set_speed(0)
	if wrapper.event is InputEventScreenDrag:
		if !wrapper.on_board:
			var thrust = wrapper.event.velocity.y * push_power
			Board.set_speed(thrust)
		_last_touch[wrapper.event.index] = wrapper.event.position


func _gui_input(event: InputEvent) -> void:
	_handleEvent(EventWrapper.new(event, self, _parent != null))
