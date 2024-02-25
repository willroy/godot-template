extends Node2D

class_name Interface

var obj = null
var focus = null
var player = null
var shaderMat = null
var interacted = false
var hoverText = ""

func display_shader():
	var mat = obj.get_active_material(0)
	obj.set_surface_override_material(0, mat)
	var shader = load("enviroment/shaders/outline.gdshader")
	shaderMat = ShaderMaterial.new()
	shaderMat.shader = shader
	shaderMat.set_shader_parameter("border_width", 0.1)
	mat.set_next_pass(shaderMat)
	
func hide_shader():
	var mat = obj.get_active_material(0)
	mat.set_next_pass(null)
	shaderMat = null
	
func display_label():
	focus.show()
	focus.get_node("center/label").text = hoverText

func hide_label():
	focus.hide()

func get_interacted():
	return interacted
	
func get_obj():
	return obj
