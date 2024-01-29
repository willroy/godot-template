extends Interface

class_name Converstation

var dialouge = null

func startDialouge(filename):
	if Input.is_key_pressed(KEY_E) and !get_interacted():
		convo_init()
		set_tree(filename)
		dialouge.debugoutputcurrent()
		dialouge.next_dialouge("1")
		dialouge.debugoutputcurrent()
		dialouge.next_dialouge("2")
		dialouge.debugoutputcurrent()
		return true
	return false
	
func convo_init():
	var player = obj.get_node("../../Player")
	interacted = true
	player.freeze(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func convo_finish():
	var player = obj.get_node("../../Player")
	interacted = false
	player.freeze(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func set_tree(filename):
	dialouge = Dialouge.new()
	dialouge.load_file(filename)
