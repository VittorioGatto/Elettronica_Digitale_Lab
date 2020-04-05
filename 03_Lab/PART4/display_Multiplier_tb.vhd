library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_Multiplier_tb is
end display_Multiplier_tb;

architecture Behavior of display_Multiplier_tb is

component display_Multiplier
	port(
			SW11_8: in unsigned(3 downto 0); -- A
			SW3_0: in unsigned(3 downto 0); -- B
			HEX6: out std_logic_vector(0 to 6); -- hex(A)
			HEX4: out std_logic_vector(0 to 6); -- hex(B)
			HEX1_0: out std_logic_vector(0 to 13) -- hex(P)
		);
end component;

signal a_in, b_in: unsigned(3 downto 0);

signal HEX_A: std_logic_vector(0 to 6);
signal HEX_B: std_logic_vector(0 to 6);
signal HEX_P_dozens: std_logic_vector(0 to 6);
signal HEX_P_units: std_logic_vector(0 to 6);

begin
	DUT: display_Multiplier port map(SW11_8 => a_in, SW3_0 => b_in,
												HEX6 => HEX_A, HEX4 => HEX_B,
												HEX1_0(0 to 6) => HEX_P_dozens,
												HEX1_0(7 to 13) => HEX_P_units
												);

process
begin
	a_in <= to_unsigned(1, a_in'length);
	b_in <= to_unsigned(1, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(3, a_in'length);
	b_in <= to_unsigned(4, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(5, a_in'length);
	b_in <= to_unsigned(2, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(12, a_in'length);
	b_in <= to_unsigned(14, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(15, a_in'length);
	b_in <= to_unsigned(15, b_in'length);
	wait for 20 ns;
	
end process;
end Behavior;