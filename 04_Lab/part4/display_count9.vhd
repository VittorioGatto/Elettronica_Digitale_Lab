library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_count9 is
  port(
			EN: in std_logic;
			CK: in std_logic;
			CLR: in std_logic;
			SPD: in integer; --defines increment (real = 1, simulation = 1000)
			SEGS_OUT: out std_logic_vector(0 to 6)
		 );
end display_count9;

architecture Structure of display_count9 is
  component count9
    port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			Q: buffer unsigned(3 downto 0)
		 );
  end component;
  
  component segment7_decoder_nums 
	port(
			m: in std_logic_vector(3 downto 0); --inputs
			segs: out std_logic_vector(0 to 6) --segments
		);
  end component;
  
  signal Q_out_counter: unsigned(3 downto 0);
  
  
  begin
    COUNTER: count9 port map(EN,CK,CLR,SPD,Q_out_counter);
    DECODER: segment7_decoder_nums port map(std_logic_vector(Q_out_counter), SEGS_OUT);
  

end Structure;
