extends Node

var items = []

func add_item(itemName, iconPath, count):
	var newItem = ItemStack.new()
	newItem.itemName = itemName
	newItem.iconPath = iconPath
	newItem.count = count
	items.append(newItem)
	update_display()
	
func update_display():
	for item in items:
		var label = Label.new()
		label.text = "%d x %s" % [item.count, item.itemName]
		self.add_child(label)
		
		item.label = label

func _input(event):
	if Input.is_action_just_pressed("inventory"):
		if self.get_parent().visible:
			self.get_parent().hide()
		else:
			self.get_parent().show()
