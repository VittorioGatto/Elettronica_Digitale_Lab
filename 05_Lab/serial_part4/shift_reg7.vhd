library ieee;
use ieee.std_logic_1164.all;

--shift register 7 bit 
entity shift_reg7 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic;
			serial_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(0 to 6)
		);
end shift_reg7;

architecture Behavior of shift_reg7 is

begin
	process(clk)
	begin	
		if rising_edge(clk) then
			if resetn = '0' then --synchronous reset
				data_out <= (others => '1');--reset to "1111111" => the display is OFF!
			elsif load = '1' then
					data_out <= serial_in;
			end if;
		end if;
	end process;
end Behavior;