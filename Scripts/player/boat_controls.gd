@icon("res://addons/at-icons/node3d/boat.svg")
extends RigidBody3D

@export_group("Speed")
@export var speed: float = 20.0
@export var rotation_speed: float = 1.0

@export_group("Buoyancy")
@export var floatys: Array[Node3D]
@export var buoyancy: float = 10.0

@onready var camera_3d: Camera3D = $Camera3D

var camera_og_FOV: float
var rs: float = rotation_speed

func _ready() -> void:
	if camera_3d:
		camera_og_FOV = camera_3d.fov

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.z * speed)
	if Input.is_action_pressed("ui_down"):
		apply_central_force(-basis.z * speed / 1.5)
	if Input.is_action_pressed("ui_left"):
		apply_torque(Vector3.UP * rotation_speed)
	if Input.is_action_pressed("ui_right"):
		apply_torque(-Vector3.UP * rotation_speed)
	
	if Input.is_action_pressed("drift"):
		rotation_speed += 1 * delta
		rotation_speed = clampf(rotation_speed, rs, rs*2)
		camera_3d.fov += 10 * delta
		camera_3d.fov = clampf(camera_3d.fov, camera_og_FOV, 100)
	if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		rotation_speed = rs
		camera_3d.fov = lerpf(camera_3d.fov, camera_og_FOV, 5.0 * delta)
		
	for i in floatys:
		if i.global_position.y < 0:
			apply_force(Vector3.UP * buoyancy * -i.global_position.y, i.global_position - global_position)
