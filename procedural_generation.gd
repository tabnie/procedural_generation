extends Node2D

@export var size: Vector2 = Vector2(100,100)
@export var frequency: float = 0.003
#@export var seed: float = randi()
@export var noise_type: FastNoiseLite.NoiseType = FastNoiseLite.TYPE_PERLIN
@export var tile_chance: float = 0.05
@export var tile_ground_location: Vector2 = Vector2(1,1)
@export var tile_water_location: Vector2 = Vector2(3,2)
@onready var tm: TileMapLayer = %TM

var noise: FastNoiseLite

func _ready() -> void:
	_init_noise()
	_make_noise_map()

func _process(delta: float) -> void:
	_on_key_press()

func _init_noise():
	
	noise = FastNoiseLite.new()
	noise.frequency = frequency
	noise.seed = randi()
	noise.noise_type = noise_type

func _make_noise_map():
	for y in size.y:
		for x in size.x:
			var buffer := noise.get_noise_2d(x,y)
			#print(buffer)
			if buffer < tile_chance:
				tm.set_cell(Vector2(x,y),0,tile_ground_location)
			else:
				tm.set_cell(Vector2(x,y),0,tile_water_location)
				
func _on_key_press():
	if Input.is_action_pressed("ui_accept"):
		_reload()

func _reload():
	get_tree().reload_current_scene()
