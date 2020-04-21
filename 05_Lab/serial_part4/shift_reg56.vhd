library ieee;
use ieee.std_logic_1164.all;

--shift register 56 bit SIPO
entity shift_reg56 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic; --tells registers to load
			closed_loop: in std_logic;--tells if the loop must be closed
			s_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(55 downto 0)
		);
end shift_reg56;

architecture Behavior of shift_reg56 is

component shift_reg7
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic;
			serial_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(0 to 6)
		);
end component;

signal data_in: std_logic_vector(0 to 6);

begin
  
  input_choice: process(closed_loop, s_in, data_out(55 downto 49))
  begin
    if closed_loop = '1' then
      data_in <= data_out(55 downto 49);
    else
      data_in <= s_in;
    end if;
    end process;
	
	SHIFT_REG7_0: shift_reg7 port map(clk, resetn, load, data_in, data_out(6 downto 0));
	  
	SHIFT_REG7_1: shift_reg7 port map(clk, resetn, load, data_out(6 downto 0), data_out(13 downto 7));
	  
	SHIFT_REG7_2: shift_reg7 port map(clk, resetn, load, data_out(13 downto 7), data_out(20 downto 14));
	
	SHIFT_REG7_3: shift_reg7 port map(clk, resetn, load, data_out(20 downto 14), data_out(27 downto 21));
	
	SHIFT_REG7_4: shift_reg7 port map(clk, resetn, load, data_out(27 downto 21), data_out(34 downto 28));
	  
	SHIFT_REG7_5: shift_reg7 port map(clk, resetn, load, data_out(34 downto 28), data_out(41 downto 35));
	  
	SHIFT_REG7_6: shift_reg7 port map(clk, resetn, load, data_out(41 downto 35), data_out(48 downto 42));
	
	SHIFT_REG7_7: shift_reg7 port map(clk, resetn, load, data_out(48 downto 42), data_out(55 downto 49)); 
	  
end Behavior;