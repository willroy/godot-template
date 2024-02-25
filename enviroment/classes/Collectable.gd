extends Interface

class_name Collectable

var inventory = null

func interact():
	if Input.is_action_pressed("interact") and !get_interacted():
		hide_label()
		inventory.add_item("exampleItem", "fakePath", 1)
		self.obj.hide()
		self.obj.get_node("staticBody/collision").disabled = true
		self.interacted = true
		return true
	if Input.is_action_just_pressed("interact"):
		self.interacted = false
		display_label()
	return false
