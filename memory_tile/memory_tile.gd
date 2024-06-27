extends TextureButton


@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage


var _item_name: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_item_name() -> String:
	return _item_name


func setup(image_info: Dictionary, frame_img: CompressedTexture2D) -> void:
	frame_image.texture = frame_img
	item_image.texture = image_info.item_texture
	_item_name = image_info.item_name
