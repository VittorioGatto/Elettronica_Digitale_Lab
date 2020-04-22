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
			state: out State_type
		 );
end component;

component StateLookUp
  port(
			 current_state: in State_type;
			 result: out std_logic_vector(8 downto 0)
		  );
  end component;
  
    
 signal current_state_out: State_type;
  
  begin
    
    in_reg: part3 port map(KEY0,SW0,SW1,LEDG0,current_state_out);
      
    S_LUT: StateLookUp port map(current_state => current_state_out, result => LEDR8_0);
	 

end Behavior;
