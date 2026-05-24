library IEEE;
use IEEE.std_logic_1164.all;

entity crono1 is
end entity crono1;

architecture crono1 of crono1 is
signal s1, s2, s3, s4, s5 : std_logic;
begin
	bloque1 : process
		begin
		s1 <= '0'; -- 0
		wait for 10 ns;
		s1 <= '1'; s2 <= '1'; -- 10
		wait for 5 ns;
		s1 <= '0'; s2 <= '0'; -- 15
		wait for 5 ns;
		s1 <= '1'; s2 <= '1'; -- 20
		wait for 15 ns;
		s2 <= '0'; -- 35
		wait for 5 ns;
		s1<= '1'; s2<='1'; -- 40 (FIN)
		wait;
	end process bloque1;
	
	bloque2 : process
	begin
		s3 <= '0'; -- 0,10,20,30,40,50,60
		wait for 5 ns;
		s1 <= '1'; s3 <= '1'; -- 5,15,25,35,45,55
		wait for 5 ns;
	end process bloque2;
	
	s4 <= s2 after 10 ns;
	s5 <= transport s2 after 10 ns;
end architecture crono1;
