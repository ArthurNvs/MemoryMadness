extends TextureButton

class_name MemoryTile

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var _item_name: String
var _can_select_me: bool = true


func _ready():
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	SignalManager.on_selection_enabled.connect(on_selection_enabled)


func reveal(rvl: bool) -> void:
	frame_image.visible = rvl
	item_image.visible = rvl


func get_item_name() -> String:
	return _item_name


func setup(image_info: Dictionary, frame_img: CompressedTexture2D) -> void:
	frame_image.texture = frame_img
	item_image.texture = image_info.item_texture
	_item_name = image_info.item_name
	reveal(false)


func disable_on_success() -> void:
	z_index = 1
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation", deg_to_rad(720), 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2(0, 0), 0)


func on_selection_disabled() -> void:
	_can_select_me = false


func on_selection_enabled() -> void:
	_can_select_me = true


func _on_pressed():
	if _can_select_me == true:
		SignalManager.on_tile_selected.emit(self)
