extends RigidBody

# ------------------------------------------------------------------- const(s)
const ins_shot = preload("res://res/scene/shot.tscn")
const scene_particle_2 = preload("res://res/scene/particle_2.tscn")

onready var node_camera = get_node("../Camera")
onready var node_player = get_node("model")

export(int, FLAGS, "by 1Frame", "by 2Frames", "by 3Frames", "by 4Frames") var RAPID_SPEED = 0
export(float, 0.1, 1, 0.1) var MOVE_SPEED = 0.5

var n_rapid_counter = 0
var user_deg = 0


func _integrate_forces(state):

	for i in range(state.get_contact_count()):
		var cc = state.get_contact_collider_object(i)
		var dp = state.get_contact_local_normal(i)

		if (cc):
			if cc extends preload("res://scr/enemy.gd"):
				var o_particle = scene_particle_2.instance()
				var vctPos = node_player.get_translation()
				o_particle.set_translation(vctPos)
				node_player.add_child(o_particle)


func _process(delta):

	var vctDir = Vector3(0, 0, 0)
	var vctPos = self.get_translation()

	user_deg =  0

	if Input.is_action_pressed("moveU") == true:
		vctDir.z -= 1
	if Input.is_action_pressed("moveD") == true:
		vctDir.z += 1
	if Input.is_action_pressed("moveL") == true:
		vctDir.x -= 1
		user_deg =  30
	if Input.is_action_pressed("moveR") == true:
		vctDir.x += 1
		user_deg = -30

	vctDir.normalized()

	var screen_pos = node_camera.unproject_position(vctPos + (vctDir * MOVE_SPEED))

	if(screen_pos.x > 16 and screen_pos.x < (640 - 16)):
		if(screen_pos.y > 16 and screen_pos.y < (640 - 16)):
			vctPos += (vctDir * MOVE_SPEED)

	if Input.is_action_pressed("shot") == true:
		if n_rapid_counter == 0:
			var o_shot = ins_shot.instance()

			o_shot.set_translation(vctPos - Vector3(0, 0, 2))
			self.get_parent().add_child(o_shot)

			n_rapid_counter = RAPID_SPEED

		n_rapid_counter >>= 1
	else:
		n_rapid_counter = 0


	self.set_rotation_deg(Vector3(0, 0, 0))
	self.set_translation(vctPos)
	self.set_rotation_deg(Vector3(0, 0, user_deg))


func _ready():

	set_process(true)



# [EOF]
