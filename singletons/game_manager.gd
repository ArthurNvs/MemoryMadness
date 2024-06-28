extends Node


const GROUP_TILE: String = "tile"


const LEVELS: Dictionary = {
	1: { "rows": 2, "cols": 2 },
	2: { "rows": 3, "cols": 4 },
	3: { "rows": 4, "cols": 4 },
	4: { "rows": 4, "cols": 6 },
	5: { "rows": 5, "cols": 6 },
	6: { "rows": 6, "cols": 6 }
}


# Loads game information to display/monitor the level
func get_level_data(level_num: int) -> Dictionary:
	var level_data = GameManager.LEVELS[level_num]
	var total_tiles = level_data.rows * level_data.cols
	var target_pairs: int = total_tiles / 2
	var selected_level_images = []
	
	ImageManager.shuffle_images()
	
	for i in range(target_pairs):
		# Appends image pair (but in order)
		selected_level_images.append(ImageManager.get_image(i))
		selected_level_images.append(ImageManager.get_image(i))
	
	# Shuffles the order of the images appended
	selected_level_images.shuffle()
	
	return {
		"target_pairs": target_pairs,
		"num_cols": level_data.cols,
		"image_list": selected_level_images
	}


func clear_nodes_of_group(g_name: String) -> void:
	for node in get_tree().get_nodes_in_group(g_name):
		node.queue_free()
