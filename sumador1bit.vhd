library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sumador_1_bit is
port(
	a,b,cin		:		in		std_logic;
	s,cout		:		out		std_logic
);
end entity sumador_1_bit;	


architecture rtl of sumador_1_bit is

begin

	s <= a xor b xor cin;
	cout <= (a and b) or (a and cin) or (b and cin);

end architecture rtl;