library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador is
	port(
		x3,x2,x1	:	out	std_logic;
		   a, b		:	in	std_logic_vector(7 downto 0);
		      sel	:	in	std_logic
);
end entity comparador;

architecture behaviour of comparador is
begin
	process(a,b,sel) is

	begin
		-- Defaults
		x1 <= '0';
		x2 <= '0';
		x3 <= '0';
		if (sel = '0') then -- Unsigned
			if(to_integer(unsigned(a)) > to_integer(unsigned(b))) then
				x1 <= '1';
			elsif (to_integer(unsigned(a)) = to_integer(unsigned(b))) then
				x2 <= '1';
			else
				x3 <= '1';
			end if;
		end if;
		
		if (sel = '1') then -- Signed
			if(to_integer(signed(a)) > to_integer(signed(b))) then
				x1 <= '1';
			elsif (to_integer(signed(a)) = to_integer(signed(b))) then
				x2 <= '1';
			else
				x3 <= '1';
			end if;
		end if;

	end process;


end architecture behaviour;
