library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_detectorPar is
-- A testbench entity is always empty
end entity tb_detectorPar;

architecture testbench of tb_detectorPar is

    -- Signals to connect to the Unit Under Test (UUT)
    signal x_tb : std_logic_vector(3 downto 0) := "0000";
    signal y_tb : std_logic;

begin

    -- Instantiate your parity detector
    -- Using direct entity instantiation (VHDL-93+ standard)
    uut: entity work.detectorPar
        generic map (
            n_bits => 4
        )
        port map (
            x => x_tb,
            y => y_tb
        );

    -- Stimulus and verification process
    stim_proc: process
        variable expected_y : std_logic;
    begin
        -- Loop through all 16 possible combinations for a 4-bit input
        for i in 0 to 15 loop
            
            -- Convert integer loop counter to 4-bit std_logic_vector
            x_tb <= std_logic_vector(to_unsigned(i, 4));
            
            -- Wait a short time for the combinational logic to propagate
            wait for 10 ns;
            
            -- Calculate the expected output: 4-bit XNOR (Even Parity)
            expected_y := not (x_tb(3) xor x_tb(2) xor x_tb(1) xor x_tb(0));
            
            -- Compare actual vs. expected
            -- The 'assert' statement triggers the 'report' ONLY if the condition is FALSE
            assert (y_tb = expected_y)
                report "ERROR: Mismatch at input combination " & integer'image(i)
                severity error;
                
        end loop;
        
        -- Print a success message at the very end
        report "Simulation complete. If no ERROR messages appeared above, all 16 cases passed!" 
        severity note;
        
        wait; -- Suspend the process indefinitely
    end process;

end architecture testbench;