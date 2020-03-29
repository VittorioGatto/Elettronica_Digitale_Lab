library ieee;
use ieee.std_logic_1164.all;

entity segments7_5_tb is
end segments7_5_tb;

architecture Behavior of segments7_5_tb is

component segments7_5
	port(
			SW_control: in std_logic_vector(2 downto 0);
			SW_data: in std_logic_vector(14 downto 3);
			HEXes: out std_logic_vector(0 to 34)
		 );
end component;

signal SW_in: std_logic_vector(17 downto 0) := "000000001010011100";  -- Displays "HELLO" as default
signal HEXes_out1: std_logic_vector(0 to 6);
signal HEXes_out2: std_logic_vector(7 to 13);
signal HEXes_out3: std_logic_vector(14 to 20);
signal HEXes_out4: std_logic_vector(21 to 27);
signal HEXes_out5: std_logic_vector(28 to 34);

begin
	DUT: segments7_5 port map(SW_control => SW_in(17 downto 15), SW_data => SW_in(14 downto 3),
									  HEXes(0 to 6) => HEXes_out1, HEXes(7 to 13) => HEXes_out2,
									  HEXes(14 to 20) => HEXes_out3, HEXes(21 to 27) => HEXes_out4,
									  HEXes(28 to 34) => HEXes_out5);

process
begin
	SW_in(17 downto 15) <= "000"; -- "HELLO => 1001000 0110000 1110001 1110001 0000001";
	wait for 20 ns;
	SW_in(17 downto 15) <= "001"; -- "ELLOH => 0110000 1110001 1110001 0000001 1001000";
	wait for 20 ns;
	SW_in(17 downto 15) <= "010"; -- "LLOHE => 1110001 1110001 0000001 1001000 0110000";
	wait for 20 ns;
	SW_in(17 downto 15) <= "011"; -- "LOHEL => 1110001 0000001 1001000 0110000 1110001";
	wait for 20 ns;
	SW_in(17 downto 15) <= "100"; -- "OHELL => 0000001 1001000 0110000 1110001 1110001";
	wait for 20 ns;
end process;
end Behavior;