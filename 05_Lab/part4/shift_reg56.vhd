library ieee;
use ieee.std_logic_1164.all;

--shift register 56 bit PIPO
entity shift_reg56 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic; --tells registers to load
			writen_shift: in std_logic; --0 if parallel load, 1 if shift
			parallel_load_data_in: in std_logic_vector(0 to 55);
			data_out: buffer std_logic_vector(0 to 55)
		);
end shift_reg56;

architecture Behavior of shift_reg56 is

component shift_reg7
	port(
			clk: in std_logic;
			resetn: in std_logic;
			enable: in std_logic;
			writen_shift: in std_logic;
			shifted_data_in: in std_logic_vector(0 to 6);
			parallel_load_data_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(0 to 6)
		);
end component;

signal feedback: std_logic_vector(0 to 6);

begin

	feedback <= data_out(49 to 55);
	
	SHIFT_REG7_1: shift_reg7 port map(clk, resetn, load, writen_shift,
											 feedback,
											 parallel_load_data_in(0 to 6),
											 data_out(0 to 6)
											 );
	
	SHIFT_REG7_2: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(0 to 6),
											 parallel_load_data_in(7 to 13),
											 data_out(7 to 13)
											 );
											 
   SHIFT_REG7_3: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(7 to 13),
											 parallel_load_data_in(14 to 20),
											 data_out(14 to 20)
											 );
											 
   SHIFT_REG7_4: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(14 to 20),
											 parallel_load_data_in(21 to 27),
											 data_out(21 to 27)
											 );
											 
   SHIFT_REG7_5: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(21 to 27),
											 parallel_load_data_in(28 to 34),
											 data_out(28 to 34)
											 );
											 
	SHIFT_REG7_6: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(28 to 34),
											 parallel_load_data_in(35 to 41),
											 data_out(35 to 41)
											 );
											 
   SHIFT_REG7_7: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(35 to 41),
											 parallel_load_data_in(42 to 48),
											 data_out(42 to 48)
											 );
											 
	SHIFT_REG7_8: shift_reg7 port map(clk, resetn, load, writen_shift,
											 data_out(42 to 48),
											 parallel_load_data_in(49 to 55),
											 data_out(49 to 55)
											 );
end Behavior;
	