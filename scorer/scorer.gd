extends Node


@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var _tiles: Array = []
var _selections: Array = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_pairs_made = 0
	_moves_made = 0
	_target_pairs = target_pairs
	_tiles = get_tree().get_nodes_in_group(GameManager.GROUP_TILE)


func check_pair_made() -> void:
	if _selections.size() != 2:
		return
		
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1

func on_tile_selected(tile: MemoryTile) -> void:
	SoundManager.play_tile_click(sound)
	tile.reveal(true)
	_selections.append(tile)
	pass
