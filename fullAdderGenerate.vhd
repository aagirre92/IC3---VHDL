library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is
generic(N	:	integer:=3);
port(
x,y				:	in	std_logic_vector(N-1 downto 0);
cin				:		in	std_logic;
cout			:		out	std_logic;
sum				:		out	std_logic_vector(N-1 downto 0)
);
end entity fullAdder;

architecture rtl of fullAdder is
	signal c	:	std_logic_vector(N downto 0);
begin
	
	c(0) <= cin;
	cout <= c(N);
	
	-- Generate
	gen_add: for i in 0 to N-1 generate
	
		fa_i: entity work.fullAdder1(rtl) port map (xi => x(i), yi => y(i), cin => c(i), cout => c(i+1), si => sum(i));
	end generate gen_add;
end architecture rtl;



