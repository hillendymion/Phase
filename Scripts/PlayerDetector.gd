class_name PlayerDetector
extends RayCast2D

func player_detected() -> bool:
	return is_colliding() && get_collider() is Plyr_Cat
