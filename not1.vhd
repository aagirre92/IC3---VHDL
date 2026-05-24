library IEEE;
use IEEE.std_logic_1164.all;

entity not1 is
port(
	x0		:	in	std_logic;
	y0		:	out	std_logic
);
end entity not1;

architecture rtl of not1 is

begin
	y0 <= not x0;
end architecture rtl;
