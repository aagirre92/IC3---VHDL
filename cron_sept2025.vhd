library IEEE;
use IEEE.std_logic_1164.all;
entity crono1 is
end entity crono1;
architecture crono1 of crono1 is
signal s1, x1, x2, x3, x4 : std_logic;
signal x5 : std_logic := '0';
begin
process (s1, x5)
variable temp : std_logic;
begin
temp := x5;
x1 <= s1;
x2 <= x1;
x3 <= temp;
end process;
s1 <= '0', '1' after 10 ns, '0' after 30 ns,
'1' after 40 ns, '0' after 60 ns;
x4 <= transport s1 after 15 ns;
x5 <= s1 after 15 ns;
end architecture crono1;
