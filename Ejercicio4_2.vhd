library  IEEE;
use IEEE.std_logic_1164.all;

entity comparador is
port(
	x		:		in		std_logic_vector(3 downto 0);
	y		:		out		std_logic
);
end entity comparador;

architecture rtl of comparador is

	signal aux1,aux2	:	std_logic;

begin

	aux1 <= not x(3) and not x(2);
	aux2 <= not x(1) and not x(0) and not x(3);
	y <= aux1 or aux2;

end architecture rtl;
