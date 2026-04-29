library IEEE;
use IEEE.std_logic_1164.all;

entity xor2 is

	port (
		y0				:			out				std_logic;
		x0,x1			:			in				std_logic
	);
end entity xor2;

-- Architecture xor2

architecture rtl of xor2 is

begin

	y0 <= x0 xor x1;

end architecture rtl;

-- ****************************************************************** 


library IEEE;
use IEEE.std_logic_1164.all;

entity codGray is

	port (
		y			:			out				std_logic_vector(2 downto 0);
		x			:			in				std_logic_vector(2 downto 0)
	);

end entity codGray;

architecture rtl of codGray is


begin

	-- y(2)

	y2: y(2) <= x(2);

	-- y(1)

	y1: entity work.xor2(rtl) port map (x0 => x(1),x1 => x(2), y0 => y(1));
	
	-- y(0)
	
	y0: entity work.xor2(rtl) port map (x0 => x(0),x1 => x(1), y0 => y(0));

end architecture rtl;

