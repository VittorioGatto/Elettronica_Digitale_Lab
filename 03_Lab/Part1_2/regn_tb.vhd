library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regn_tb is
end regn_tb;

architecture Behavior of regn_tb is

component regn
	generic(n: integer:=8);
	port(
			R: in signed(7 downto 0);
			Clock, Resetn: in std_logic;
			Q: out signed(7 downto 0)
		  );
end component;

signal R_IN: signed(7 downto 0);
signal Clock_IN: std_logic;
signal Resetn_IN: std_logic;
signal Q_OUT: signed(7 downto 0);

begin

  DUT: regn port map (R => R_IN, Clock => Clock_IN, Resetn => Resetn_IN, Q => Q_OUT);
    
   -- generate clock 
process
  begin
  for i in 1 to 2 loop    -- clock period 10 ns
    clock_IN <= '0';
    wait for 5 ns;
    clock_IN <= '1';
    wait for 5 ns;
  end loop;
end process;

  -- generate input
process  
begin
  R_IN <= "10101010";
  wait for 2 ns;
   
  R_IN <= "01010101";
  wait for 6 ns;
  
  R_IN <= "11111111";
  wait for 8 ns;
  
  R_IN <= "10000001";
  wait for 4 ns; 
  
end process;

process
  begin
    Resetn_IN <= '1';
    wait for 12 ns;
    
    Resetn_IN <= '0';
    wait for 8 ns;
  end process;

end Behavior;
