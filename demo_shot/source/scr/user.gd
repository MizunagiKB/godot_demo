extends MeshInstance

onready var camera = get_node("../Camera")

var ins_shot = preload("res://res/scene/shot.tscn")
var n_shot_speed = 8
var n_repeat = 0

func _process(delta):

	var vctDir = Vector3(0, 0, 0)
	var vctPos = self.get_translation()

	if Input.is_action_pressed("moveU") == true:
		vctDir.z -= 1
	if Input.is_action_pressed("moveD") == true:
		vctDir.z += 1
	if Input.is_action_pressed("moveL") == true:
		vctDir.x -= 1
	if Input.is_action_pressed("moveR") == true:
		vctDir.x += 1

	vctDir.normalized()

	var screen_pos = camera.unproject_position(vctPos + (vctDir * 0.5))

	if(screen_pos.x > 16 and screen_pos.x < (640 - 16)):
		if(screen_pos.y > 16 and screen_pos.y < (640 - 16)):
			vctPos += (vctDir * 0.5)

	if Input.is_action_pressed("shot") == true:
		if n_repeat == 0:
			var o_shot = ins_shot.instance()

			o_shot.set_translation(vctPos)
			self.get_parent().add_child(o_shot)

			n_repeat = n_shot_speed

		n_repeat >>= 1
	else:
		n_repeat = 0


	self.set_translation(vctPos)


func _ready():

	set_process(true)



# [EOF]
