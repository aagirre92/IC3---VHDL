library IEEE;
use IEEE.std_logic_1164.all;

entity tb_desplazador is
-- Testbench entities are always empty
end entity tb_desplazador;

architecture sim of tb_desplazador is

    -- Signals to connect to the inputs of the Unit Under Test (UUT)
    signal clk_tb  : std_logic := '0';
    signal load_tb : std_logic := '0';
    signal d_tb    : std_logic_vector(3 downto 0) := (others => '0');

    -- Signal to connect to the output of the UUT
    signal q_tb    : std_logic_vector(3 downto 0);

    -- Clock period definition (100 MHz clock)
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.desplazador
        port map (
            q    => q_tb,
            d    => d_tb,
            clk  => clk_tb,
            load => load_tb
        );

    -- Clock generation process
    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process: applies test vectors to the inputs
    stim_proc: process
    begin
        -- Hold initial state for a moment
        wait for 20 ns;

        -- ==============================================
        -- TEST 1: Parallel Load
        -- ==============================================
        -- Let's load the binary value "1101"
        load_tb <= '1';
        d_tb <= "1101";
        wait for clk_period; 
        
        -- Expected output on q_tb at next rising edge: "1101"

        -- ==============================================
        -- TEST 2: Circular Shift Right
        -- ==============================================
        -- Turn off load to allow the shift register to work
        load_tb <= '0';
        
        -- We will wait for 4 clock cycles to see a full 360 rotation.
        -- If you look at the waveform, you should see:
        -- Clock 1: "1110" (the rightmost '1' looped around to the left)
        -- Clock 2: "0111"
        -- Clock 3: "1011"
        -- Clock 4: "1101" (Back to the original loaded value)
        wait for clk_period * 4;

        -- ==============================================
        -- TEST 3: Load a new value
        -- ==============================================
        load_tb <= '1';
        d_tb <= "0011";
        wait for clk_period;
        
        -- Expected output: "0011"

        -- ==============================================
        -- TEST 4: Shift the new value
        -- ==============================================
        load_tb <= '0';
        
        -- Expected shifts: "1001", then "1100", then "0110"...
        wait for clk_period * 3;

        -- End the simulation by waiting forever
        wait; 
    end process;

end architecture sim;
