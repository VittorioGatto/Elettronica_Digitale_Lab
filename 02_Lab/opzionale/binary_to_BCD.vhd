library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_to_BCD is
	port(
			v: in unsigned(5 downto 0); -- 2^6 = 64
			BCD: out std_logic_vector(7 downto 0)
		 );
end binary_to_BCD;

architecture Behavior of binary_to_BCD is

component check_and_add
	port(
			terms: in unsigned(3 downto 0);
			result: out unsigned(3 downto 0)
		 );
end component;

signal s1: unsigned(3 downto 0);
signal s2: unsigned(3 downto 0);
signal s3: unsigned(3 downto 0);

begin
	CAA0: check_and_add port map(terms(3) => '0', terms(2 downto 0) => v(5 downto 3), result => s1);
	CAA1: check_and_add port map(terms(3 downto 1) => s1(2 downto 0), terms(0) => v(2), result => s2);
	CAA2: check_and_add port map(terms(3 downto 1) => s2(2 downto 0), terms(0) => v(1), result => s3);

	BCD(0) <= v(0);
	BCD(4 downto 1) <= std_logic_vector(s3(3 downto 0));
	BCD(5) <= s2(3);
	BCD(6) <= s1(3);
	BCD(7) <= '0';

end Behavior;



