library IEEE;
use IEEE.std_logic_1164.all;
entity crono is
end entity crono;
architecture crono of crono is
signal x1, x2, x3, s1, s2, s3, s4: std_logic;
begin
x1 <= '1',
'0' after 15 ns,
'1' after 20 ns,
'0' after 35 ns,
'1' after 50 ns;
x2 <= '0',
'1' after 25 ns,
'0' after 30 ns;
x3 <= '0',
'1' after 10 ns,
'0' after 20 ns;
s1 <= x1 after 5 ns;
Proc1: process (x1, x2, x3)
variable v1: std_logic;
begin
s2 <= x1 xor x2;
v1 := x1 xor x2;
s3 <= s2;
s4 <= v1;
end process;
end architecture crono;
