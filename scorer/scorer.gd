extends Node

class_name Scorer

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer


var _selections: Array = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0


func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)


func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_pairs_made = 0
	_moves_made = 0
	_target_pairs = target_pairs


func get_moves_made() -> String:
	return str(_moves_made)


func get_pairs_made() -> String:
	return "%s / %s" % [_pairs_made, _target_pairs]


func selections_are_pair() -> bool:
	var is_same_id = _selections[0].get_instance_id() != _selections[1].get_instance_id()
	var is_same_name = _selections[0].get_item_name() == _selections[1].get_item_name()
	return is_same_id and is_same_name


func disable_tiles() -> void:
	for tile in _selections:
		tile.disable_on_success()
		_pairs_made += 1
		SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)


func update_selections() -> void:
	reveal_timer.start()
	if selections_are_pair() == true:
		disable_tiles()


func hide_selections() -> void:
	for s in _selections:
		s.reveal(false)


func handle_memory_tile(tile: MemoryTile) -> void:
	tile.reveal(true)
	_selections.append(tile)
	
	if _selections.size() != 2:
		return
		
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1
	
	update_selections()


func on_tile_selected(tile: MemoryTile) -> void:
	SoundManager.play_tile_click(sound)
	handle_memory_tile(tile)


func _on_reveal_timer_timeout():
	if selections_are_pair() == false:
		hide_selections()
	_selections.clear()
	SignalManager.on_selection_enabled.emit()


func on_game_exit_pressed() -> void:
	reveal_timer.stop()
