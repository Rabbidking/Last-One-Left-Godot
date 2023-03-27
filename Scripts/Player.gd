extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var is_dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_dead:
		# Player/clone movement code
		
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
func _on_Spike_CollisionShape2D_body_entered(body):
	if not is_dead and body.name == "Player" or body.name == "Clone":  # check if player or clone collides with Spike
		die()
		# code to play death animation or sound, remove player from game, etc.

func die():
	# Function for handling characters dying. The dead Player or Clone should not be able to accept inputs, but remain in the level
	is_dead = true
	pass
