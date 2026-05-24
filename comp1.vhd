library IEEE;
use IEEE.std_logic_1164.all;

entity comp1 is
port(
	x0,y0		:		in		std_logic;
	pin			:		in		std_logic;
	pout		:		out		std_logic
);
end entity comp1;

architecture rtl of comp1 is

begin
	pout <= (x0 xnor y0) and pin;
end architecture rtl;
