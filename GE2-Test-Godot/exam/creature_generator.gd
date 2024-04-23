extends Node3D

var head_scene = preload("res://head.tscn")
var body_scene = preload("res://body.tscn")
@export var segment_length: int = 10
@export var frequency: float = 2.0
@export var start_angle: float = 0.0
@export var base_size: float = 1.0
@export var multiplier: float = 2.0
@export var is_paused: bool = true

var segments = []
var current_time: float = 0.0

func _ready():
	create_snake()
	set_process(!is_paused)

func create_snake():
	var head = head_scene.instantiate()
	add_child(head)
	segments.append(head)
	
	var previous_segment = head
	for i in range(1, segment_length):
		var segment = body_scene.instantiate()
		add_child(segment)
		segment.global_transform.origin = previous_segment.global_transform.origin + Vector3(base_size * 2, 0, 0)
		previous_segment = segment
		segments.append(segment)

func _process(delta):
	if is_paused:
		return
	
	current_time += delta
	for i in range(segments.size()):
		var segment = segments[i]
		var phase = start_angle + current_time * frequency + i * (PI * 2.0 / segment_length)
		var wave_height = (sin(phase) * 0.5 + 0.5) * multiplier + base_size
		segment.scale.y = wave_height
