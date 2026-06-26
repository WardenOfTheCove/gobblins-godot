extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -1000.0
var playerHealth = 1500.0
var health = 150
var vulnerable = false

func _ready() -> void:
	global_position = Vector2(35.0, 40.0)
	$Sprite2D.self_modulate = Color(1,1,1)
	$Label.hide()
	$Label2.hide()
	await get_tree().create_timer(0.5).timeout
	vulnerable = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if(health <= 0):
		get_tree().paused = true
		$Label.show()
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()






func _on_timer_timeout() -> void:
	get_tree().paused = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == 'Player'):
		global_position = Vector2(2721.0, 454.0)
		vulnerable = false
		await get_tree().create_timer(0.5).timeout
		vulnerable = true


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if vulnerable:
		health = health - 15
		$Sprite2D.self_modulate = Color(1, 0, 0)
		if (health <= 0):
			get_tree().paused = true
			$Label.show()
			await get_tree().create_timer(5.0).timeout
			get_tree().quit()
		else:
			await get_tree().create_timer(0.3).timeout
			$Sprite2D.self_modulate = Color(1, 1,1)


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if (body.name == 'Player'):
		get_tree().paused = true
		$Label2.show();
		await get_tree().create_timer(5.0).timeout
		get_tree().quit()
