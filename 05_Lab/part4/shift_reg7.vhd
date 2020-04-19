library ieee;
use ieee.std_logic_1164.all;

--shift register 56 bit PIPO
entity shift_reg7 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			enable: in std_logic;
			writen_shift: in std_logic; --0 if parallel load, 1 if shift
			shifted_data_in: in std_logic_vector(0 to 6);
			parallel_load_data_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(0 to 6)
		);
end shift_reg7;

architecture Behavior of shift_reg7 is

component D_FF
	port(
			clk, resetn, enable: in std_logic;
			D: in std_logic_vector(0 to 6);
			Q: out std_logic_vector(0 to 6)
		  );
end component;

begin
	process(clk, resetn, enable)
	begin	
		if rising_edge(clk) then
			if resetn = '0' then --synchronous reset
				data_out <= parallel_load_data_in;
			elsif enable = '1' then
				if writen_shift = '0' then --parallel load
					data_out <= parallel_load_data_in;
				else --shifted load
					data_out <= shifted_data_in;
				end if;
			end if;
		end if;
	end process;
end Behavior;