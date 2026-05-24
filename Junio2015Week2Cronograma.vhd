library IEEE;
use IEEE.std_logic_1164.all;

entity cronoW is
end entity cronoW;

architecture cronoW of cronoW is

signal x1, x2, x3, x4 : std_logic;

begin
    x1 <= '1', '0' after 15 ns,
    '1' after 20 ns, '0' after 35 ns,
    '1' after 40 ns;

    Proc1: process
        variable valor : std_logic;
        begin
        for i in 0 to 3 loop
        x2 <= x1;
        wait for 10 ns;
        x3 <= x1 or x2;
        end loop;
        x4 <= x1 or x2;
        wait;
    end process;

    Proc2: process
        variable valor : std_logic;
        begin
        x1 <= '0';
        wait for 5 ns;
        x1 <= '1';
        wait for 15 ns;
    end process;

end architecture cronoW;
