class_name Interface

var obj = null
var shaderMat = null
var interacted = false

func display_shader():
	var material = obj.get_active_material(0)
	obj.set_surface_material(0, material)
	var shader = load("Enviroment/Shaders/outline.gdshader")
	shaderMat = ShaderMaterial.new()
	shaderMat.shader = shader
	shaderMat.set_shader_param("border_width", 0.1)
	material.set_next_pass(shaderMat)
	
func hide_shader():
	var material = obj.get_active_material(0)
	material.set_next_pass(null)
	shaderMat = null
	
func display_label(text):
	obj.get_node("HoverText").show()
	obj.get_node("HoverText/Viewport/Label").text = text

func hide_label():
	obj.get_node("HoverText").hide()

func get_interacted():
	return interacted
	
func get_obj():
	return obj
