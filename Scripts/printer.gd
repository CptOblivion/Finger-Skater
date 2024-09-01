class_name Printer


const diag = asin(PI/8)
const directions = [
	["↖","↑","↗"],
	["←","🛑","→"],
	["↙","↓","↘"],
	]


static func get_direction(direction: Vector2) -> String:
	direction = direction.normalized()
	var row = directions[1]
	if (direction.y < -diag):
		row = directions[0]
	elif  (direction.y > diag):
		row = directions[2]
	
	if (direction.x < -diag):
		return row[0]
	elif (direction.x > diag):
		return row[2]
	return row[1]


static func print_debug(val: String, source: Object) -> void:
	print(source.name, " | ", val)
