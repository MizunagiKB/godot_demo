extends RigidBody


var disabled = true

#func _integrate_forces(state):

#	state.set_linear_velocity(Vector3(0, 0, -20))


func _process(delta):
	var vctPos = self.get_translation()

	vctPos.z -= 1

	self.set_translation(vctPos)

	if vctPos.z < -100:
		self.queue_free()

	if self.disabled == false:
		self.queue_free()


func _ready():
	set_process(true)

	self.disabled = true


# [EOF]
