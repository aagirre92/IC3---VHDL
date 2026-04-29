library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador_tb_v2 is
end entity comparador_tb_v2;

architecture testbench of comparador_tb_v2 is

    signal a, b        : std_logic_vector(7 downto 0);
    signal sel         : std_logic;
    signal x1, x2, x3 : std_logic;

begin

    dut: entity work.comparador(behaviour) port map(
        a   => a,
        b   => b,
        sel => sel,
        x1  => x1,
        x2  => x2,
        x3  => x3
    );

    process is
        variable n_errors : integer := 0;

        procedure check(
            condition : in boolean;
            msg       : in string
        ) is
        begin
            if not condition then
                n_errors := n_errors + 1;
            end if;
            assert condition
                report msg
                severity error;
        end procedure;

    begin

        -- a="11111111", b="00000000", sel='1' (signed: -1 > 0? NO ? x3)
        a <= "11111111"; b <= "00000000"; sel <= '1';
        wait for 10 ns;
        check(x1 = '0' and x2 = '0' and x3 = '1', "FAIL: a=11111111 b=00000000 sel=1");

        -- a="11111111", b="00000000", sel='0' (unsigned: 255 > 0 ? x1)
        a <= "11111111"; b <= "00000000"; sel <= '0';
        wait for 10 ns;
        check(x1 = '1' and x2 = '0' and x3 = '0', "FAIL: a=11111111 b=00000000 sel=0");

        -- a="00001110", b="00001111", sel='1' (signed: 14 < 15 ? x3)
        a <= "00001110"; b <= "00001111"; sel <= '1';
        wait for 10 ns;
        check(x1 = '0' and x2 = '0' and x3 = '1', "FAIL: a=00001110 b=00001111 sel=1");

        -- a="00001110", b="00001111", sel='0' (unsigned: 14 < 15 ? x3)
        a <= "00001110"; b <= "00001111"; sel <= '0';
        wait for 10 ns;
        check(x1 = '0' and x2 = '0' and x3 = '1', "FAIL: a=00001110 b=00001111 sel=0");

        -- a="01111111", b="01111110", sel='1' (signed: 127 > 126 ? x1)
        a <= "01111111"; b <= "01111110"; sel <= '1';
        wait for 10 ns;
        check(x1 = '1' and x2 = '0' and x3 = '0', "FAIL: a=01111111 b=01111110 sel=1");

        -- a="01111111", b="01111110", sel='0' (unsigned: 127 > 126 ? x1)
        a <= "01111111"; b <= "01111110"; sel <= '0';
        wait for 10 ns;
        check(x1 = '1' and x2 = '0' and x3 = '0', "FAIL: a=01111111 b=01111110 sel=0");

        -- a="00011110", b="00011110", sel='1' (signed: 30 = 30 ? x2)
        a <= "00011110"; b <= "00011110"; sel <= '1';
        wait for 10 ns;
        check(x1 = '0' and x2 = '1' and x3 = '0', "FAIL: a=00011110 b=00011110 sel=1");

        -- a="00011110", b="00011110", sel='0' (unsigned: 30 = 30 ? x2)
        a <= "00011110"; b <= "00011110"; sel <= '0';
        wait for 10 ns;
        check(x1 = '0' and x2 = '1' and x3 = '0', "FAIL: a=00011110 b=00011110 sel=0");

        -- Final report
        if n_errors = 0 then
            report "All tests passed!" severity note;
        else
            report "Total errors: " & integer'image(n_errors) severity error;
        end if;

        wait;
    end process;

end architecture testbench;
