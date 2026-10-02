@icon("res://addons/at-icons/node/joypad.svg")
extends Node3D

@export var checkpoints: Array[Area3D] 
@export var finish: Area3D

@onready var finish_screen: Control = $"UI/Finish screen"

var about_to_finish: bool = false

func _ready() -> void:
	checkpoints[0].body_entered.connect(_on_area_3d_body_entered)
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if about_to_finish:
			print("You finished!")
			finish.hide()
			finish_screen.show()
			get_tree().paused = true
			return
		
		checkpoints[0].hide()
		checkpoints.remove_at(0)
		
		if checkpoints.size() > 0:
			checkpoints[0].body_entered.connect(_on_area_3d_body_entered)
		else:
			finish.body_entered.connect(_on_area_3d_body_entered)
			about_to_finish = true
			
