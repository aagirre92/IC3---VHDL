library IEEE;
use IEEE.std_logic_1164.all;

entity comparador is
generic(N	:	integer:=4);
port(
	x,y		:		in		std_logic_vector(N-1 downto 0);
	pout		:		out		std_logic
);
end entity comparador;

architecture rtl of comparador is

signal p	:		std_logic_vector(N downto 0);

begin
	p(0) <= '1';
	pout <= p(N);
	
	gen_comparador: for i in 0 to N-1 generate
	
		comp_i : entity work.comp1(rtl) port map (x0 => x(i), y0 => y(i), pin => p(i), pout => p(i+1));
	
	end generate gen_comparador;
end architecture rtl;

