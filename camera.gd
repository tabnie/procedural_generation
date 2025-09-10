extends Camera2D

@onready var pg: Node2D = $".."

func _ready() -> void:
	zoom = Vector2(31.2/pg.size.x, 31.2/pg.size.y)
