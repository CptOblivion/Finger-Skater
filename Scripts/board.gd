class_name Board
extends RigidBody3D


static var _instance: Board
var _speed: float
var _turn: float


func _init() -> void:
	_verify_singleton(false)
	_instance = self


#func _physics_process(delta: float) -> void:
	#apply_central_force(-transform.basis.z * _speed * delta) # TODO: double-check usage of delta here
	#pass


static func set_speed(speed: float) -> void:
	_verify_singleton(true)
	_instance._speed = speed
	_instance.apply_central_force(-_instance.transform.basis.z * speed)
	pass


static func set_turn(turn: float) -> void:
	_verify_singleton(true)
	_instance._turn = turn


static func _verify_singleton(verifyExists: bool):
	if verifyExists:
		assert(_instance != null, "board should exist but doesn't")
		return
	assert (_instance == null, "board should not exist, but does")
