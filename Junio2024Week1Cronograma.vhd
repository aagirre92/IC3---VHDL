library IEEE;
use IEEE.std_logic_1164.all;
entity crono1 is
end entity crono1;
architecture crono1 of crono1 is
signal x1, x2 : std_logic;
signal x3, x4 : std_logic;
signal s4, s5 : std_logic;
begin
process (x1)
variable v1, v2: std_logic;
begin
v1 := x2;
v2 := v1;
x3 <= v2;
s4 <= x2;
s5 <= s4;
x4 <= s5;
end process;
x1 <= '0', '1' after 10 ns, '0' after 20 ns,
'1' after 30 ns, '0' after 40 ns,
'1' after 65 ns;
x2 <= transport x1 after 5 ns;
end architecture crono1;

