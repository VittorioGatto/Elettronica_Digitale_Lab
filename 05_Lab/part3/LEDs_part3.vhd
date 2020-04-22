library ieee;
use ieee.std_logic_1164.all;
use work.serial_state_types.all;

entity LEDs_part3 is
  port( SW0: in std_logic; --resetn
        SW1: in std_logic; --w
        KEY0: in std_logic; --clock
        LEDG0: out std_logic; --z
        LEDR8_0: buffer std_logic_vector (8 downto 0) --states
      );
end LEDs_part3;

architecture Behavior of LEDs_part3 is
  component part3 
	port(
			clk: in std_logic;
			resetn: in std_logic;
			w: in std_logic;
			z: out std_logic;
			state: out State_type;
			state_decoded: buffer std_logic_vector(8 downto 0)
		 );
end component;
  
  signal states_vector:std_logic_vector(8 downto 0);
  signal current_state_out: State_type; --una delle due saranno da eliminare quando scegliamo l'implementazione della LUT
  
  begin
    in_reg: part3 port map(KEY0,SW1,SW0,LEDG0,current_state_out,states_vector);
	 LEDR8_0 <= states_vector;


end Behavior;
