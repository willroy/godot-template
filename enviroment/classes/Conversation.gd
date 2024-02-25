extends Interface

class_name Converstation

var dialouge = null
var dialougeBox = null

func startDialouge(filename):
	if Input.is_key_pressed(KEY_E) and !get_interacted():
		hide_label()
		convo_init()
		set_tree(filename)
		dialouge.debugoutputcurrent()
		draw_items()
		
		return true
	return false
	
func convo_init():
	interacted = true
	player.stopPlayer(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func convo_finish():
	display_label()
	dialougeBox.hide()
	interacted = false
	player.stopPlayer(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func set_tree(filename):
	dialouge = Dialouge.new()
	dialouge.load_file(filename)
	
func draw_items():
	var itemSize = 1
	var itemWidth = (1*1.0) / (dialouge.current_dialouge().size() * 1.0)
	var count = 0
	dialougeBox.show()
	
	for n in dialougeBox.get_children():
		dialougeBox.remove_child(n)
		n.queue_free()
	
	for t in dialouge.current_dialouge():
		var dialougeBoxLabel = RichTextLabel.new()
		dialougeBoxLabel.size = Vector2(1000,1000)
		dialougeBoxLabel.scale = Vector2(itemSize,itemSize)
		
		var fontData = load("res://fonts/roboto-medium.ttf")
		var font = FontFile.new()
		font.font_data = fontData
		
		var screen_size = obj.get_tree().get_root().size
		var set_width = ProjectSettings.get("display/window/size/viewport_width")
		var set_height = ProjectSettings.get("display/window/size/viewport_height")

		var container_size = dialougeBox.size.x * screen_size / Vector2(set_width, set_height)
		var text_size = font.get_string_size(t["text"])[0] * screen_size / Vector2(set_width, set_height)
		var relativeTextWidth = float(1/float((container_size[0])/(text_size[0]*itemSize)))
		
		dialougeBoxLabel.anchor_left = float(itemWidth * count)+float(itemWidth/2)-float(relativeTextWidth/2)
		dialougeBoxLabel.anchor_top = 0.42
		dialougeBoxLabel.text = t["text"]
		dialougeBoxLabel.add_theme_font_override("normal_font",font)
		
		dialougeBoxLabel.connect("gui_input", Callable(self, "dialouge_clicked").bind(t["id"]))
		dialougeBox.add_child(dialougeBoxLabel)
		count += 1
	
func dialouge_clicked(event, id):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if dialouge.next_dialouge(id[0]) == false:
				convo_finish()
			else:
				draw_items()
