package serial_state_types is
	type State_type is (A, B, C, D, E, F, G, H, I);
	type HELLO_type is (IDLE, H, E, L1, L2, O, X1, X2, X3, LOCK, ERROR);
end serial_state_types;