extends RigidBody3D

@export var speed: float = 20.0
@export var rotation_speed: float = 10.0

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.z * speed)
	if Input.is_action_pressed("ui_down"):
		apply_central_force(-basis.z * speed / 1.5)
	if Input.is_action_pressed("ui_left"):
		apply_torque(basis.y * rotation_speed)
	if Input.is_action_pressed("ui_right"):
		apply_torque(-basis.y * rotation_speed)
