extends Node2D

@export var size: Vector2 = Vector2(100,100)
@export var frequency: float = 0.003
#@export var seed: float = randi()
@export var noise_type: FastNoiseLite.NoiseType = FastNoiseLite.TYPE_PERLIN
@export var tile_chance: float = 0.05
@export var tile_darkgrass_location: Vector2 = Vector2(0,0)
@export var tile_ground_location: Vector2 = Vector2(1,0)
@export var tile_water_location: Vector2 = Vector2(2,0)
@export var tile_deepwater_location: Vector2 = Vector2(3,0)
#@onready var tm: TileMapLayer = %TM
@onready var tiles: TileMapLayer = %Tiles

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
			var cell_pos := Vector2(x,y)-size/2
			if buffer < -0.17:
				tiles.set_cell(cell_pos, 0, tile_deepwater_location)
			elif buffer < 0.0:
				tiles.set_cell(cell_pos, 0, tile_water_location)
			elif buffer < 0.21:
				tiles.set_cell(cell_pos, 0, tile_ground_location)
			else:
				tiles.set_cell(cell_pos, 0, tile_darkgrass_location)
func _on_key_press():
	if Input.is_action_pressed("ui_accept"):
		_reload()

func _reload():
	get_tree().reload_current_scene()
