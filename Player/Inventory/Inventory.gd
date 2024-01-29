extends Node

var items = []

func add_item(name, iconPath, count):
	var newItem = ItemStack.new()
	newItem.name = name
	newItem.iconPath = iconPath
	newItem.count = count
	items.append(newItem)
	update_display()
	
func update_display():
	for item in items:
		var node = Node2D.new()
		var label = RichTextLabel.new()
		label.text = "%d x %s" % [item.count, item.name]
		label.margin_right = 40.0
		label.margin_bottom = 40.0
		label.scroll_active = false
		label.rect_size = Vector2(400,400)
		node.scale = Vector2(2,2)
		node.position = Vector2(20,20)
		node.add_child(label)
		self.add_child(node)
		
		item.node = node
		item.label = label
