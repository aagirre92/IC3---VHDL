library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity crono2 is
end entity crono2;
architecture crono2 of crono2 is
	signal x1, x2, x3, x4, x5 : std_logic;
begin
	process is
		variable temp : unsigned (2 downto 0);
		begin
		for i in 0 to 7 loop
		temp := TO_UNSIGNED(i,3);
		x1 <= std_logic(temp(0));
		x2 <= std_logic(temp(1));
		x3 <= std_logic(temp(2));
		wait for 10 ns;
		end loop;
		wait;
	end process;
	x4 <= x1 after 5 ns;
	x5 <= x1 after 15 ns;
end architecture crono2;

