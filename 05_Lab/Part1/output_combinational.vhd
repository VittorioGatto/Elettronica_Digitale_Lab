library ieee;
use ieee.std_logic_1164.all;

entity output_combinational is
  port( det0_4,det1_4: in std_logic;
        z: out std_logic
      );
end output_combinational;

architecture Behavior of output_combinational is
begin
  output_assignement: process(det0_4,det1_4) is
  begin
    if det0_4 = '1' then
      z <= '1';
    elsif det1_4 = '1' then
      z <= '1';
    else
      z <= '0';
    end if;
  end process;
end Behavior;