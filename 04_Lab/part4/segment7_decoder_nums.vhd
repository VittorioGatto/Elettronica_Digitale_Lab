library ieee;
use ieee.std_logic_1164.all;

entity segment7_decoder_nums is
	port(
			m: in std_logic_vector(3 downto 0); --inputs
			segs: out std_logic_vector(0 to 6) --segments
		);
end segment7_decoder_nums;

architecture Behavior of segment7_decoder_nums is
begin
  segs(0) <= (not m(3) and not m(2) and not m(1) and m(0)) or (m(2) and not m(1) and not m(0)) or (m(3) and m(1)) or (m(3) and m(2));
  segs(1) <= (m(2) and not m(1) and m(0)) or (m(2) and m(1) and not m(0)) or (m(3) and m(1)) or (m(3) and m(2));
  segs(2) <= (not m(2) and m(1) and not m(0)) or (m(3) and m(1)) or (m(3) and m(2));
  segs(3) <= (not m(3) and not m(2) and not m(1) and m(0)) or (m(2) and not m(1) and not m(0)) or (m(2) and m(1) and m(0)) or (m(3) and m(1)) or (m(3) and m(2));
  segs(4) <= (m(0)) or (m(2) and not m(1)) or (m(3) and m(1));
  segs(5) <= (not m(3) and not m(2) and m(0)) or (not m(2) and m(1)) or (m(1) and m(0)) or (m(3) and m(2)); 
  segs(6) <= (not m(3) and not m(2) and not m(1)) or (m(2) and m(1) and m(0)) or (m(3) and m(1)) or (m(3) and m(2));   
  
end Behavior;
