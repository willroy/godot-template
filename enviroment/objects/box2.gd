extends MeshInstance3D

var looking_at = false
var interfaceObj = null

func _ready():
	interfaceObj = Collectable.new()
	interfaceObj.obj = self
	interfaceObj.focus = self.get_tree().get_root().get_node("main/interface/focus")
	interfaceObj.inventory = self.get_tree().get_root().get_node("main/interface/inventory/grid")
	interfaceObj.hide_label()

func run_look_at():
	interfaceObj.hoverText = "Pick up"
	interfaceObj.display_label()
	interfaceObj.display_shader()

func run_look_away():
	interfaceObj.hide_shader()
	interfaceObj.hide_label()

func _input(_ev):
	if looking_at && interfaceObj.interact():
		return
