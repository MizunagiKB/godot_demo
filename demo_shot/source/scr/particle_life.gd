extends Particles

var time = 0

func _process(delta):

	time += 1
	pass

	if time > 60:
		queue_free()


func _ready():
	set_process(true)
	self.set("emitting", true)
	time = 0


# [EOF]
