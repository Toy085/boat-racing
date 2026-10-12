@icon("res://addons/at-icons/control/window.svg")
extends Control

@onready var lap_label: RichTextLabel = $LapLabel

var max_lap: int

func _ready() -> void:
	var gm = get_tree().get_first_node_in_group("GameManager")
	if gm:
		max_lap = gm.lap
		gm.lap_passed.connect(update_lap_label)
		update_lap_label(gm.lap)

func update_lap_label(lap: int):
	if not max_lap - lap == max_lap:
		lap_label.text = "[b]%d[/b]/%d" % [max_lap - lap +1, max_lap]
	else:
		lap_label.text = "[b]%d[/b]/%d" % [max_lap, max_lap]
