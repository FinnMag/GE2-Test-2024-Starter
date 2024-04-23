# NoiseWander.gd
extends Node3D

@export var noise_strength: float = 1.0
@export var move_speed: float = 5.0

var noise = FastNoiseLite.new()
var direction: Vector3 = Vector3.FORWARD

func _ready():
	noise.seed = randi()

func _process(delta):
	noise.seed += 1


	var noise_value = noise.get_noise_3d(global_transform.origin.x, global_transform.origin.y, global_transform.origin.z)
	var noise_vector = Vector3(noise_value, noise_value, noise_value).normalized() * noise_strength

	# Combine the current direction with the noise vector
	direction = direction.lerp(noise_vector, delta).normalized()

	global_transform.origin += direction * move_speed * delta
