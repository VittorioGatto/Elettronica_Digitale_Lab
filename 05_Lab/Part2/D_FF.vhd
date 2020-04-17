LIBRARY ieee;
USE ieee.std_logic_1164.all;

--simple behavioral description of a D flip-flop WITH SYNCHRONOUS CLEAR INPUT

ENTITY D_FF IS
port(	D, clk, clr: IN std_logic;
		  Q: OUT std_logic
	 );
end D_FF;

ARCHITECTURE Behavior OF D_FF IS
BEGIN
PROCESS(clk)
  BEGIN

	IF clk'EVENT AND clk = '1' THEN
		Q <= D;
		IF clr = '0' THEN
			Q <= '0';
		END IF;
	END IF;

END PROCESS;
END Behavior;