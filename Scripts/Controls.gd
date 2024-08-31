class_name BoardControl
extends Control

var parent: BoardControl = null
# TODO: only render these on parent
@export var use_mouse: bool = false
@export var push_power: float = 10
@export var drag: float = 5

var on_board = false



const diag = asin(PI/8)
const directions = [
	["↖️","⬆️","↗️"],
	["⬅️","🛑","➡️"],
	["↙️","⬇️","↘️"]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(self.name, " ready")
	var p = get_parent()
	if (p is BoardControl):
		parent = p
	pass # Replace with function body.

func _gui_input(event: InputEvent) -> void:
	handleEvent(event, self)

func _get_direction(direction: Vector2) -> String:
	direction = direction.normalized()
	var row = directions[1]
	if (direction.y < -diag): row = directions[0]
	elif  (direction.y > diag): row = directions[2]
	
	if (direction.x < -diag): return row[0]
	elif (direction.x > diag): return row[2]
	return row[1]
	
func _print_debug(val: String, calledBy: BoardControl) -> void:
	print(calledBy.name, " | ", val)

func handleEvent(event: InputEvent, calledBy: BoardControl) -> void:
	# capture event and bubble up to root
	if (parent != null):
		parent.handleEvent(event, calledBy)
		return
	
	if event is InputEventScreenTouch:
		if (use_mouse):
			return
		# track which finger was touched (event index)
		# TODO: figure out how to handle lift events that happened after finger left board (collider doesn't recieve touch ended event)
		# TODO: consider just tracking all touches on bottom half of screen uniformly, no raycast into scene and board-specific touch handler
		#print(self.name, "touch: ", event)
		_print_debug(str("touch: ", event.index, " ", event.pressed), calledBy)
	elif event is InputEventScreenDrag:
		if (use_mouse):
			return
		_print_debug(str("drag: ", event.index, " ", _get_direction(event.velocity)), calledBy)
		# drags on board are steering:
			# with one touch
				# get vector from center of screen to touch
				# get angle of vector
				# with deadzone turn camera such that board aligns with that vector
					# if touch started on back of board (mongo), invert rotation
			# with two touches
				# get vector between fingers
				# with deadzone, move camera to place back of board at back finger
				# with deadzone, turn camera (around back finger location) to match vector
			# using turn vector, apply turn to board
				# include some lerp when changing number of touches
			# above some distance threshold, go into skid?
			# feed swipe position and velocities into swipe detector
				# if velocity passes some threshold, begin detecting swipe
				# if velocity and direction are maintained and match a valid swipe, go into trick (ollie, kickflip, etc)
		pass
	elif event is InputEventMouseButton:
		if (!use_mouse):
			return
		_print_debug(str("click: ", event.pressed), calledBy)
	elif event is InputEventMouseMotion:
		if (!use_mouse):
			return
		_print_debug(str("mouse move: ", _get_direction(event.velocity)), calledBy)
	else:
		_print_debug(str("unhandled event type: ", event.get_class()), calledBy)
	
