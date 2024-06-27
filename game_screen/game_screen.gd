extends Control


@export var memory_tile_scene: PackedScene


@onready var sound = $Sound
@onready var tile_container = $HBoxContainer/MarginContainer/TileContainer


func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_level_selected(level_num: int) -> void:
	var level_data = GameManager.get_level_data(level_num)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_data.num_cols
	
	for image_info in level_data.image_list:
		add_memory_tile(image_info, frame_image)


func add_memory_tile(image_info: Dictionary, frame_image: CompressedTexture2D) -> void:
	var new_tile = memory_tile_scene.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(image_info, frame_image)


func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_game_exit_pressed.emit()
