class_name PlayerDetector
extends RayCast2D

func player_detected() -> bool:
	return is_colliding() && get_collider() is Plyr_Cat

func player_position() -> Vector2:
	return null if !player_detected() else get_collision_point()
