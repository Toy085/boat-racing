extends RigidBody3D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		apply_impulse(basis.z * 5.0)
