library IEEE;
use IEEE.std_logic_1164.all;

entity xor2 is
port(
	x0,x1	:	in	std_logic;
	y0		:	out	std_logic
);
end entity xor2;

architecture rtl of xor2 is

begin
	y0 <= x0 xor x1;
end architecture rtl;