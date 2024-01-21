extends MeshInstance

var looking_at = false
var interacted = false
var shaderMaterial = null

onready var box = get_node("../Box")

func _ready():
	$TextSpatial.hide()

#func _process(delta):
#	pass

func run_look_at():
	box.get_node("TextSpatial/Viewport/Label").text = "Speak To"
	$TextSpatial.show()
	
	var material = box.get_active_material(0)
	box.set_surface_material(0, material)
	var shader = load("Game/Shaders/outline.gdshader")
	shaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = shader
	shaderMaterial.set_shader_param("border_width", 0.1)
	material.set_next_pass(shaderMaterial)

func run_look_away():
	$TextSpatial.hide()
	
	var material = box.get_active_material(0)
	material.set_next_pass(null)
	shaderMaterial = null

func _input(_ev):
	if looking_at:
		var player = get_node("../../Player")
		if Input.is_key_pressed(KEY_E) and looking_at and !interacted:
			interacted = true
			player.freeze(true)
			print("interact")
		elif Input.is_key_pressed(KEY_Q) and looking_at and interacted:
			interacted = false
			player.freeze(false)
			print("uninteract")
