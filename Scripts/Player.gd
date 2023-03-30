extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var is_dead = false
signal decrease_living

@onready var _animated_sprite = $AnimatedSprite2D

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
			
			if Input.is_action_pressed("ui_right"):
				_animated_sprite.flip_h = false
			elif Input.is_action_pressed("ui_left"):
				_animated_sprite.flip_h = true
			_animated_sprite.play("player_move")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			_animated_sprite.stop()

		move_and_slide()
		
func _on_Spike_CollisionShape2D_body_entered(body):
	pass
		# code to play death animation or sound, remove player from game, etc.

func die():
	# Function for handling characters dying. The dead Player or Clone should not be able to accept inputs, but remain in the level
	is_dead = true
	pass


func _on_area_2d_area_entered(area):
	if area.get_collision_layer_value(5):
		emit_signal("decrease_living")
		queue_free()
