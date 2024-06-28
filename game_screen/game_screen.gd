extends Control

@export var memory_tile_scene: PackedScene

@onready var sound = $Sound
@onready var tile_container = $HBoxContainer/MarginContainer/TileContainer
@onready var scorer: Scorer = $Scorer
@onready var moves_label = $HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer/MovesLabel
@onready var pairs_label = $HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer2/PairsLabel


func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)


func _process(delta):
	moves_label.text = scorer.get_moves_made_str()
	pairs_label.text = scorer.get_pairs_made_str()

func on_level_selected(level_num: int) -> void:
	var level_data = GameManager.get_level_data(level_num)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_data.num_cols
	
	for image_info in level_data.image_list:
		add_memory_tile(image_info, frame_image)
	
	scorer.clear_new_game(level_data.target_pairs)


func add_memory_tile(image_info: Dictionary, frame_image: CompressedTexture2D) -> void:
	var new_tile = memory_tile_scene.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(image_info, frame_image)


func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_game_exit_pressed.emit()
