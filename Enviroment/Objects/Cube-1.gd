extends MeshInstance

var looking_at = false
var interfaceObj = null

func _ready():
	interfaceObj = Converstation.new()
	interfaceObj.obj = self
	interfaceObj.hide_label()

func run_look_at():
	interfaceObj.display_label("Speak To")
	interfaceObj.display_shader()

func run_look_away():
	interfaceObj.hide_shader()
	interfaceObj.hide_label()

func _input(_ev):
	if looking_at && !interfaceObj.interacted:
		interfaceObj.startDialouge("example")
