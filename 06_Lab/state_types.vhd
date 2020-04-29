package serial_state_types is
	type State_type is (IDLE, START, WRITE_A, DONE_A, READ_EK, BLOCK_P, BLOCK_I, BLOCK_D, BLOCK_S1, BLOCK_S2, WRITE_B, DONE_B);
end serial_state_types;
