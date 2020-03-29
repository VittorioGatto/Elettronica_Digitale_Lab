LIBRARY ieee; 
USE ieee.std_logic_1164.all; 

ENTITY Controlling_the_LEDs_tb IS
END Controlling_the_LEDs_tb; 

ARCHITECTURE behaviour OF Controlling_the_LEDs_tb IS
  
  COMPONENT Controlling_the_LEDs IS
	PORT ( SW  : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0));
  END COMPONENT; 

  SIGNAL switches, LEDs: std_logic_vector(17 downto 0);
  
  begin
    
    switches <= "000000000000000000", "010101010101010101" after 2 ns, "101010101010101010" after 4 ns, "111111111111111111" after 6 ns;
    
    dut: Controlling_the_LEDs port map (SW(17 downto 0) => switches(17 downto 0), LEDR(17 downto 0) => LEDs(17 downto 0));
  
  
END ARCHITECTURE; 