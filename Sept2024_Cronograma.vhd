library IEEE;
use IEEE.std_logic_1164.all;
entity crono1 is
end entity crono1;
architecture crono1 of crono1 is
signal s1, s2, s3: std_logic := '0';
signal x1, x2, x3, x4 : std_logic;
begin
process (s2)
begin
if (rising_edge(s2)) then
s3 <= x1;
x3 <= s3;
x4 <= x3;
end if;
end process;
s1 <= '0', '1' after 5 ns, '0' after 10 ns,
'1' after 20 ns, '0' after 40 ns;
s2 <= not s2 after 10 ns;
x1 <= transport s1 after 10 ns;
x2 <= s1 after 10 ns;
end architecture crono1;
