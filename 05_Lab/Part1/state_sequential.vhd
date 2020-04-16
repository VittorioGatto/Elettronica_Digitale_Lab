library ieee;
use ieee.std_logic_1164.all;

entity state_sequential is
  port( w, resetn, clock: in std_logic;
        idle_out, det0_1_out,det0_2_out,det0_3_out,det0_4_out,det1_1_out,det1_2_out,det1_3_out,det1_4_out: buffer std_logic
      );
end state_sequential;

architecture Behavior of state_sequential is
  component D_FF
    port(	D, clk, res: in std_logic;
		      Q: out std_logic
	       );
  end component;

signal neg_idle_out,det0_1_next,det0_2_next,det0_3_next,det0_4_next,det1_1_next,det1_2_next,det1_3_next,det1_4_next: std_logic;

begin
  next_state_evaluation: process(w,idle_out, det0_1_out,det0_2_out,det0_3_out,det0_4_out,det1_1_out,det1_2_out,det1_3_out,det1_4_out)
  begin
      det0_1_next <= (idle_out or det1_1_out or det1_2_out or det1_3_out or det1_4_out) and not w;
      det0_2_next <= det0_1_out and not w;
      det0_3_next <= det0_2_out and not w;
      det0_4_next <= (det0_3_out or det0_4_out) and not w;
      det1_1_next <= (idle_out or det0_1_out or det0_2_out or det0_3_out or det0_4_out) and w;
      det1_2_next <= det1_1_out and w;
      det1_3_next <= det1_2_out and w;
      det1_4_next <= (det1_3_out or det1_4_out) and w;
  end process;
  
  idle_ps: D_FF port map ('1', clock, resetn, neg_idle_out);
    idle_out <= not neg_idle_out;
  det0_1_ps: D_FF port map (det0_1_next, clock, resetn, det0_1_out);
  det0_2_ps: D_FF port map (det0_2_next, clock, resetn, det0_2_out);
  det0_3_ps: D_FF port map (det0_3_next, clock, resetn, det0_3_out);
  det0_4_ps: D_FF port map (det0_4_next, clock, resetn, det0_4_out);
  det1_1_ps: D_FF port map (det1_1_next, clock, resetn, det1_1_out);
  det1_2_ps: D_FF port map (det1_2_next, clock, resetn, det1_2_out);
  det1_3_ps: D_FF port map (det1_3_next, clock, resetn, det1_3_out);
  det1_4_ps: D_FF port map (det1_4_next, clock, resetn, det1_4_out);


end Behavior;