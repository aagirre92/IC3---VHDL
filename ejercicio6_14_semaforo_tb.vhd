library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_ej614 is
end entity bp_ej614;

architecture bp of bp_ej614 is
	constant 		ClockFreqHz								:		integer	:= 60; --HZ
	constant 		PERIODO									:		time	:=	1000 ms / ClockFreqHz;
	signal			clk, reset,r1,y1,g1,r2,y2,g2			:		std_logic:='0';

begin

	-- uut
	
	uut: entity work.semaforo(rtl) 
	generic map (ClockFreqHz => ClockFreqHz)
	port map (clk => clk, reset => reset, r1 => r1, y1 => y1, g1 => g1, r2 => r2, y2 => y2, g2 => g2);

	-- Igual mejor pongo el reset en segundos (le voy a dejar 10 segundos)
	
	reset <= '0', '1' after 10 sec, '0' after 20 sec;
	
	clk <= not clk after (PERIODO/2);
	
	
end architecture bp;

