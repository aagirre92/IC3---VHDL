library IEEE;
use IEEE.std_logic_1164.all;
entity crono2 is
end entity crono2;
architecture crono2 of crono2 is
signal x1, x2, x3, x4, x5, x6 : std_logic;
begin
x1 <= '1', '0' after 10 ns, '1' after 20 ns,
'0' after 25 ns, '1' after 40 ns;
Proc1: process
begin
x2 <= '1'; wait for 5 ns;
x2 <= '0'; wait for 10 ns;
x2 <= '1'; wait for 20 ns;
x2 <= '0';
end process;
x3 <= x1 after 10 ns;
x4 <= transport x1 after 10 ns;
Proc2: process
variable v : std_logic;
begin
for i in 0 to 3 loop
v := x1 xor x2; x5 <= v;
x6 <= x5; wait for 10 ns;
end loop;
wait;
end process;
end architecture crono2;

