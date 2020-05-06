library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM is
	port(
			clk: in std_logic;
			reg_addr: in std_logic_vector(9 downto 0);
			enable: in std_logic; --chip select
			read_writen: in std_logic; --1 read, 0 write
			data_in: in signed(7 downto 0);
			data_out: out signed(7 downto 0)
		 );
end MEM;

architecture Behavior of MEM is

subtype reg_width is signed(7 downto 0);
subtype reg_height is integer range 0 to 1023;

type reg_type is array(reg_height) of reg_width; --register matrix representation 8x1024

signal reg: reg_type;

begin

write_process: process(clk)
	begin
		if(rising_edge(clk)) then
			if enable = '1' then
				if read_writen = '0' then
					reg(to_integer(unsigned(reg_addr))) <= data_in;
				end if;
			end if;
		end if;
end process;

read_process: process(clk)
	begin
		if(rising_edge(clk)) then
			if enable = '1' then
				if read_writen = '1' then
					data_out <= reg(to_integer(unsigned(reg_addr)));
				end if;
			end if;
		end if;
end process;

--data_out <= reg(to_integer(unsigned(reg_addr)));

end Behavior;
	