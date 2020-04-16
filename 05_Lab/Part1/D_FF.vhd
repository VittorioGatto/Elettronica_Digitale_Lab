LIBRARY ieee;
USE ieee.std_logic_1164.all;

--simple behavioral description of a D flip-flop

ENTITY D_FF IS
port(	D, clk, res: IN std_logic;
		  Q: OUT std_logic
	 );
end D_FF;

ARCHITECTURE Behavior OF D_FF IS
BEGIN
PROCESS(clk, res)
  BEGIN
		IF res = '0' THEN
			Q <= '0';
		ELSIF clk'EVENT AND clk = '1' THEN
			Q <= D;
		END IF;
	END PROCESS;
END Behavior;