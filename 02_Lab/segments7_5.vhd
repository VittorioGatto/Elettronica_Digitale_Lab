library ieee;
use ieee.std_logic_1164.all;

entity segments7_5 is
	port(
			SW_control: in std_logic_vector(2 downto 0);
			SW_data: in std_logic_vector(14 downto 3); -- the remaining 3 bits are the blank character, we remove it
			HEXes: out std_logic_vector(0 to 34)
		 );
end segments7_5;

architecture Behavior of segments7_5 is

component segments7_mux
	port( 
			SW: in std_logic_vector(17 downto 0);
			HEX0: out std_logic_vector(0 to 6)
		 );
end component;

-- Suppose we have as SW_data="000 001 010 011 100" (example in lab exercise), to display our words
-- having only the possibility to change the connections between switches and muxes, it is easy to see
-- a pattern: ROTATING LEFT SW_data changes the bits order, similarly  to the word "hello" rotating left
-- in our display (bits movement -> physical movement)
-- Rotating left is easily doable by manually assigning data in the order we want

signal SW_H: std_logic_vector(2 downto 0);
signal SW_E: std_logic_vector(2 downto 0);
signal SW_L: std_logic_vector(2 downto 0);
signal SW_O: std_logic_vector(2 downto 0);

begin
	
	SW_H <= SW_data(14 downto 12);
	SW_E <= SW_data(11 downto 9);
	SW_L <= SW_data(8 downto 6);
	SW_O <= SW_data(5 downto 3);
	
	SEG7_1: segments7_mux port map (SW(17 downto 15) => SW_control,
											  SW(14 downto 12) => SW_H, --H ELLO
											  SW(11 downto 9) => SW_E, --E LLOH
											  SW(8 downto 6) => SW_L, --L LOHE
											  SW(5 downto 3) => SW_L, --L OHEL
											  SW(2 downto 0) => SW_O, --O HELL
											  HEX0 => HEXes(0 to 6));
	
	SEG7_2: segments7_mux port map (SW(17 downto 15) => SW_control, 
											  SW(14 downto 12) => SW_E, --H E LLO
											  SW(11 downto 9) => SW_L, --E L LOH
											  SW(8 downto 6) => SW_L, --L L OHE
											  SW(5 downto 3) => SW_O, --L O HEL
											  SW(2 downto 0) => SW_H, --O H ELL
											  HEX0 => HEXes(7 to 13));
											  
	SEG7_3: segments7_mux port map (SW(17 downto 15) => SW_control, 
											  SW(14 downto 12) => SW_L, --HE L LO
											  SW(11 downto 9) => SW_L, --EL L OH
											  SW(8 downto 6) => SW_O, --LL O HE
											  SW(5 downto 3) => SW_H, --LO H EL
											  SW(2 downto 0) => SW_E, --OH E LL,  
											  HEX0 => HEXes(14 to 20));
											  
	SEG7_4: segments7_mux port map (SW(17 downto 15) => SW_control, 
											  SW(14 downto 12) => SW_L, --EL L O
											  SW(11 downto 9) => SW_O, --LL O H
											  SW(8 downto 6) => SW_H, --LLO H E
											  SW(5 downto 3) => SW_E, --LOH E L
											  SW(2 downto 0) => SW_L, --OHE L L
											  HEX0 => HEXes(21 to 27));
											  
	SEG7_5: segments7_mux port map (SW(17 downto 15) => SW_control, 
											  SW(14 downto 12) => SW_O, --HELL O
											  SW(11 downto 9) => SW_H, --ELLO H
											  SW(8 downto 6) => SW_E, --LLOH E
											  SW(5 downto 3) => SW_L, --LOHE L
											  SW(2 downto 0) => SW_L, --OHEL L
											  HEX0 => HEXes(28 to 34));
	
end Behavior;