@icon("res://addons/at-icons/node/joypad.svg")
class_name GameManager
extends Node3D

@export var checkpoints: Array[Area3D] 
@export var finish: Area3D
@export var lap: int = 0

@onready var finish_screen: Control = $"UI/Finish screen"

signal lap_passed(lapsleft: int)
signal race_finished

var about_to_finish: bool = false
var remaining_checkpoints: Array[Area3D]

func _ready() -> void:
	lap_passed.emit(lap)
	remaining_checkpoints = checkpoints.duplicate()
	remaining_checkpoints[0].body_entered.connect(_on_area_3d_body_entered)
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if about_to_finish:
			race_finished.emit()
			finish_screen.show()
			get_tree().paused = true
			return
		
		remaining_checkpoints[0].body_entered.disconnect(_on_area_3d_body_entered)
		if finish.body_entered.is_connected(_on_area_3d_body_entered):
			finish.body_entered.disconnect(_on_area_3d_body_entered)
		remaining_checkpoints.remove_at(0)
		
		if remaining_checkpoints.size() > 0:
			remaining_checkpoints[0].body_entered.connect(_on_area_3d_body_entered)
		elif remaining_checkpoints.is_empty():
			lap -= 1
			lap_passed.emit(lap)
			if lap >= 1:
				remaining_checkpoints = checkpoints.duplicate()
				remaining_checkpoints[0].body_entered.connect(_on_area_3d_body_entered)
			else:
				finish.body_entered.connect(_on_area_3d_body_entered)
				about_to_finish = true
