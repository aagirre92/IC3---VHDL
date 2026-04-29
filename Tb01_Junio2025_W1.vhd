library IEEE;
use IEEE.std_logic_1164.all;

entity crono1 is
end entity crono1;

architecture crono1 of crono1 is
signal s1, s2, x3, x4, x5, x6 : std_logic;
begin
s1 <= '1', '0' after 5 ns,'1' after 20 ns,
'0' after 30 ns,'1' after 40 ns;
s2 <= '0', '1' after 25 ns, '0' after 35 ns,
'1' after 45 ns;
Proc1: process
variable valor : std_logic;
begin
wait for 5 ns;
for i in 0 to 6 loop
x3 <= s1 or s2;
valor := s1 or s2;
x4 <= valor;
x5 <= x3;
wait for 10 ns;
end loop;
wait;
end process;
x6 <= s1 or s2 after 12 ns;
end architecture crono1;
