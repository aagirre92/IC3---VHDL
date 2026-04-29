library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador_tb is
end entity comparador_tb;

architecture testbench of comparador_tb is

    -- Signals
    signal a, b         : std_logic_vector(7 downto 0);
    signal sel          : std_logic;
    signal x1, x2, x3  : std_logic;

begin

    -- Instantiate DUT (Device Under Test)
	dut: entity work.comparador(behaviour) port map(
		a => a,
		b => b,
		sel => sel,
		x1 => x1,
		x2 => x2,
		x3 => x3
	);

    process is
    begin

        -- =====================
        -- UNSIGNED TESTS (sel=0)
        -- =====================
        sel <= '0';

        -- a > b
        a <= std_logic_vector(to_unsigned(200, 8));
        b <= std_logic_vector(to_unsigned(100, 8));
        wait for 10 ns;
        assert x1 = '1' and x2 = '0' and x3 = '0'
            report "FAIL: Unsigned a > b" severity error;

        -- a = b
        a <= std_logic_vector(to_unsigned(128, 8));
        b <= std_logic_vector(to_unsigned(128, 8));
        wait for 10 ns;
        assert x1 = '0' and x2 = '1' and x3 = '0'
            report "FAIL: Unsigned a = b" severity error;

        -- a < b
        a <= std_logic_vector(to_unsigned(50, 8));
        b <= std_logic_vector(to_unsigned(200, 8));
        wait for 10 ns;
        assert x1 = '0' and x2 = '0' and x3 = '1'
            report "FAIL: Unsigned a < b" severity error;

        -- =====================
        -- SIGNED TESTS (sel=1)
        -- =====================
        sel <= '1';

        -- a > b  (-10 > -50)
        a <= std_logic_vector(to_signed(-10, 8));
        b <= std_logic_vector(to_signed(-50, 8));
        wait for 10 ns;
        assert x1 = '1' and x2 = '0' and x3 = '0'
            report "FAIL: Signed a > b" severity error;

        -- a = b  (-7 = -7)
        a <= std_logic_vector(to_signed(-7, 8));
        b <= std_logic_vector(to_signed(-7, 8));
        wait for 10 ns;
        assert x1 = '0' and x2 = '1' and x3 = '0'
            report "FAIL: Signed a = b" severity error;

        -- a < b  (-100 < 50)
        a <= std_logic_vector(to_signed(-100, 8));
        b <= std_logic_vector(to_signed(50, 8));
        wait for 10 ns;
        assert x1 = '0' and x2 = '0' and x3 = '1'
            report "FAIL: Signed a < b" severity error;

        -- =====================
        -- EDGE CASES
        -- =====================

        -- Unsigned: max value (255 > 0)
        sel <= '0';
        a <= std_logic_vector(to_unsigned(255, 8));
        b <= std_logic_vector(to_unsigned(0, 8));
        wait for 10 ns;
        assert x1 = '1' and x2 = '0' and x3 = '0'
            report "FAIL: Unsigned max vs 0" severity error;

        -- Signed: max positive vs max negative (127 > -128)
        sel <= '1';
        a <= std_logic_vector(to_signed(127, 8));
        b <= std_logic_vector(to_signed(-128, 8));
        wait for 10 ns;
        assert x1 = '1' and x2 = '0' and x3 = '0'
            report "FAIL: Signed max vs min" severity error;

        -- All done
        report "All tests completed successfully!" severity note;
        wait;

    end process;

end architecture testbench;
