package state_types is
	type State_type is (IDLE, WRITE_A, DONE_A, BLOCK_P, BLOCK_I, BLOCK_D, BLOCK_S1, BLOCK_S2, SAT_CONTROL, WRITE_B, READ_B, DONE_B);
end state_types;
