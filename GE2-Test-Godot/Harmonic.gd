extends Node3D

@export var amplitude: float = 5.0
@export var frequency: float = 1.0

var original_position: Vector3

func _ready():
	original_position = global_transform.origin

func _process(delta):
	var harmonic_offset = sin(delta * frequency) * amplitude
	var new_position = original_position
	new_position.y += harmonic_offset
	global_transform.origin = new_position
