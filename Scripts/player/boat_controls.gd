extends RigidBody3D

@export var speed: float = 5.0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		apply_central_force(basis.z * speed)
	if Input.is_action_pressed("ui_right"):
		apply_torque(basis.x * speed)
