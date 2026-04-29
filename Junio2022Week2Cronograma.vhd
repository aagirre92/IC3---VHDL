library IEEE;
use IEEE.std_logic_1164.all;
entity crono2 is
end entity crono2;
architecture crono2 of crono2 is
signal x1, x2, x3, s1, s2, s3, s4 : std_logic;
begin
x1 <= '1', '0' after 5 ns, '1' after 15 ns, '0' after 30 ns,
'1' after 35 ns, '0' after 50 ns;
x2 <= '0', '1' after 15 ns, '0' after 35 ns;
x3 <= x1 after 10 ns;
Proc1: process
variable valor : std_logic;
begin
for i in 0 to 4 loop
valor := x1 and x2;
s1 <= valor;
s2 <= s1;
s3 <= x1 and x2;
s4 <= s2 or s3;
wait for 10 ns;
end loop;
wait;
end process;
end architecture crono2;
