extends Interface

class_name Converstation

var dialouge = null

func startDialouge(filename):
	if Input.is_key_pressed(KEY_E) and !get_interacted():
		convo_init()
		set_tree(filename)
		dialouge.debugoutputcurrent()
		draw_items()
		
		return true
	return false
	
func convo_init():
	var player = obj.get_node("../../Player")
	interacted = true
	player.freeze(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func convo_finish():
	var dialougeBox = obj.get_node("../../Dialouge/TextureRect")
	dialougeBox.hide()
	var player = obj.get_node("../../Player")
	interacted = false
	player.freeze(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func set_tree(filename):
	dialouge = Dialouge.new()
	dialouge.load_file(filename)
	
func draw_items():
	var itemSize = 3
	var itemWidth = (1*1.0) / (dialouge.current_dialouge().size() * 1.0)
	var count = 0
	var dialougeBox = obj.get_node("../../Dialouge/TextureRect")
	dialougeBox.show()
	
	for n in dialougeBox.get_children():
		dialougeBox.remove_child(n)
		n.queue_free()
	
	for t in dialouge.current_dialouge():
		var dialougeBoxLabel = RichTextLabel.new()
		dialougeBoxLabel.rect_size = Vector2(300,300)
		dialougeBoxLabel.rect_scale = Vector2(itemSize,itemSize)
		
		var font = dialougeBoxLabel.get_font("normal_font")
		var screen_size = obj.get_tree().get_root().size
		var set_width = ProjectSettings.get("display/window/size/width")
		var set_height = ProjectSettings.get("display/window/size/height")
		var container_size = dialougeBox.rect_size.x * screen_size / Vector2(set_width, set_height)
		var text_size = font.get_string_size(t["text"]) * screen_size / Vector2(set_width, set_height)
		var relativeTextWidth = float(1/float((container_size[0])/(text_size[0]*itemSize)))
		
		dialougeBoxLabel.anchor_left = float(itemWidth * count)+float(itemWidth/2)-float(relativeTextWidth/2)
		dialougeBoxLabel.anchor_top = 0.4
		dialougeBoxLabel.bbcode_text = t["text"]
		dialougeBoxLabel.connect("gui_input", self, "dialouge_clicked", [t["id"]])
		dialougeBox.add_child(dialougeBoxLabel)
		count += 1
	
func dialouge_clicked(event, id):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if dialouge.next_dialouge(id[0]) == false:
				convo_finish()
			else:
				draw_items()
