extends CollisionObject3D

var push_power = 10
var drag = 5
var on_board = false


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	handleEvent(event)

func handleEvent(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		# track which finger was touched (event index)
		# TODO: figure out how to handle lift events that happened after finger left board (collider doesn't recieve touch ended event)
		# TODO: consider just tracking all touches on bottom half of screen uniformly, no raycast into scene and board-specific touch handler
		print("touch:", event)
	elif event is InputEventScreenDrag:
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
		#print("drag:", event)
	#elif event is InputEventMouseButton:
		#pass
	#elif event is InputEventMouseMotion:
		#pass
	else:
		print("unhandled event type:", event.get_class())
	
