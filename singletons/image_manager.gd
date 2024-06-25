extends Node


# Dictionary array
var item_images: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	load_item_images() # Replace with function body.


func add_file_to_list(fn: String, path: String) -> void:
	var full_path = path + "/" + fn
	
	var image_info = {
		"item_name": fn.rstrip(".png"),
		"item_texture": load(full_path)
	}
	
	item_images.append(image_info)


func load_item_images() -> void:
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("ERROR:", path)
		return
		
	var file_names = dir.get_files()
	
	for fn in file_names:
		if ".import" not in fn:
			add_file_to_list(fn, path)
			
	print("loaded:", item_images.size())


func get_random_item_image() -> Dictionary:
	return item_images.pick_random()
	
