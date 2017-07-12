extends RigidBody


onready var ins_particle = preload("res://res/scene/particle.tscn")
onready var scene_main = get_node("/lbl_score")

var power = 1
var vctDir = Vector3(0, 0, 1)


func _integrate_forces(state):

	for i in range(state.get_contact_count()):
		var cc = state.get_contact_collider_object(i)
		var dp = state.get_contact_local_normal(i)

		if (cc):
			if cc extends preload("res://res/scene/shot.gd"):
				var o_particle = ins_particle.instance()
				var vctPos = self.get_translation()
				o_particle.set_translation(vctPos)
				self.get_parent().add_child(o_particle)

				cc.disabled = false
				self.power -= 1

				system.score += 10

				if self.power < 1:
					self.queue_free()
					system.score += 100


func _process(delta):
	var vctPos = self.get_translation()

	vctPos += vctDir

	self.set_translation(vctPos)

	if vctPos.z > 30:
		self.queue_free()


func _ready():
	set_process(true)



# [EOF]
