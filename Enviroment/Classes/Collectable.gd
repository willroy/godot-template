extends Interface

class_name Collectable

func interact():
	if Input.is_action_pressed("interact") and !get_interacted():
		var playerInv = obj.get_node("../../Player/Inventory")
		playerInv.add_item("exampleItem", "fakePath", 1)
		self.obj.hide()
		self.obj.get_node("StaticBody/CollisionShape").disabled = true
		self.interacted = true
		return true
	if Input.is_action_just_pressed("interact"):
		self.interacted = false
	return false
