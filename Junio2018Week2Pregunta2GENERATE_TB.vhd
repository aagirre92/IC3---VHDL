library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_comparador is
-- Testbench entity is always empty
end entity tb_comparador;

architecture testbench of tb_comparador is

    -- Generic parameter definition
    constant N : integer := 4;

    -- Signals to connect to the Unit Under Test (UUT)
    signal x_tb    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal y_tb    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal pout_tb : std_logic;

begin

    -- Instantiate your comparator
    uut: entity work.comparador
        generic map (
            N => N
        )
        port map (
            x    => x_tb,
            y    => y_tb,
            pout => pout_tb
        );

    -- Stimulus and verification process
    stim_proc: process
        variable expected_pout : std_logic;
    begin
        
        -- Outer loop for input 'x' (0 to 15)
        for i in 0 to (2**N)-1 loop
            
            -- Inner loop for input 'y' (0 to 15)
            for j in 0 to (2**N)-1 loop
                
                -- Convert integer loop counters to std_logic_vectors
                x_tb <= std_logic_vector(to_unsigned(i, N));
                y_tb <= std_logic_vector(to_unsigned(j, N));
                
                -- Wait for combinational logic to propagate through the cascade
                wait for 10 ns;
                
                -- Determine the expected result
                -- Assuming equality outputs '1' and inequality outputs '0'
                if (i = j) then
                    expected_pout := '1';
                else
                    expected_pout := '0';
                end if;
                
                -- Check if the actual output matches the expected output
                assert (pout_tb = expected_pout)
                    report "ERROR: Mismatch! x = " & integer'image(i) & 
                           ", y = " & integer'image(j)
                    severity error;
                    
            end loop;
        end loop;
        
        -- Print a success message once all 256 loops finish
        report "Simulation complete. If no ERROR messages appeared above, all 256 cases passed!" 
        severity note;
        
        wait; -- Suspend process indefinitely
    end process;

end architecture testbench;
