library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder1 is
port(
xi,yi,cin		:	in	std_logic;
si,cout			:	out	std_logic
);
end entity fullAdder1;

architecture rtl of fullAdder1 is

begin
	cout <= (xi and yi) or (xi and cin) or (yi and cin);
	si <= xi xor yi xor cin;
end architecture rtl;


