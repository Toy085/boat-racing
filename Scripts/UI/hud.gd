extends Control

@onready var lap_label: RichTextLabel = $LapLabel

func _ready() -> void:
	update_lap_label()


func _process(_delta: float) -> void:
	pass

func update_lap_label():
	lap_label.text = "[b]1[/b]/3"
