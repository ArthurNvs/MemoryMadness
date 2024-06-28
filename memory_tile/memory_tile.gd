extends TextureButton

class_name MemoryTile


@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage


var _item_name: String
var _can_select_me: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	SignalManager.on_selection_enabled.connect(on_selection_enabled)


func reveal(r: bool) -> void:
	frame_image.visible = r
	item_image.visible = r


func get_item_name() -> String:
	return _item_name


func setup(image_info: Dictionary, frame_img: CompressedTexture2D) -> void:
	frame_image.texture = frame_img
	item_image.texture = image_info.item_texture
	_item_name = image_info.item_name
	reveal(false)


func on_selection_disabled() -> void:
	_can_select_me = false


func on_selection_enabled() -> void:
	_can_select_me = true


func _on_pressed():
	if _can_select_me == true:
		SignalManager.on_tile_selected.emit(self)
