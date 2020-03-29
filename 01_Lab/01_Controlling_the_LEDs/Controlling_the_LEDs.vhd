LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
-- Simple module that connects 
-- the SW switches to the LEDR lights 
 
ENTITY Controlling_the_LEDs IS
	PORT ( SW  : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)); -- red LEDs 
END Controlling_the_LEDs; 
 
ARCHITECTURE Behavior OF Controlling_the_LEDs IS 
BEGIN 
	LEDR <= SW; 
END Behavior;