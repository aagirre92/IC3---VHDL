library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_fullAdder is
-- Testbench entity is empty
end entity tb_fullAdder;

architecture testbench of tb_fullAdder is

    -- Match the generic N from your design
    constant N : integer := 3;

    -- Signals to connect to the Unit Under Test (UUT)
    signal x_tb    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal y_tb    : std_logic_vector(N-1 downto 0) := (others => '0');
    signal cin_tb  : std_logic := '0';
    signal cout_tb : std_logic;
    signal sum_tb  : std_logic_vector(N-1 downto 0);

begin

    -- Instantiate your N-bit full adder
    uut: entity work.fullAdder
        generic map (
            N => N
        )
        port map (
            x    => x_tb,
            y    => y_tb,
            cin  => cin_tb,
            cout => cout_tb,
            sum  => sum_tb
        );

    -- Stimulus and automated checking process
    stim_proc: process
        -- We need an N+1 bit vector to hold the mathematical result so we can capture the carry-out
        variable expected_val  : unsigned(N downto 0); 
        variable expected_sum  : std_logic_vector(N-1 downto 0);
        variable expected_cout : std_logic;
    begin
        
        -- Loop over all possible values for 'x' (0 to 7 for N=3)
        for i in 0 to (2**N)-1 loop
            
            -- Loop over all possible values for 'y' (0 to 7 for N=3)
            for j in 0 to (2**N)-1 loop
                
                -- Loop over 'cin' (0 or 1)
                for k in 0 to 1 loop
                    
                    -- 1. Apply Stimulus
                    x_tb <= std_logic_vector(to_unsigned(i, N));
                    y_tb <= std_logic_vector(to_unsigned(j, N));
                    
                    if k = 1 then
                        cin_tb <= '1';
                    else
                        cin_tb <= '0';
                    end if;
                    
                    -- Wait for the ripple carry to propagate through the N gates
                    wait for 10 ns;
                    
                    -- 2. Calculate Expected Result
                    -- Add i + j + k together into an N+1 bit unsigned number
                    expected_val := to_unsigned(i + j + k, N+1);
                    
                    -- Split the mathematical result into the Sum and the Carry Out
                    expected_sum  := std_logic_vector(expected_val(N-1 downto 0));
                    expected_cout := expected_val(N);
                    
                    -- 3. Verify
                    assert (sum_tb = expected_sum and cout_tb = expected_cout)
                        report "ERROR: Mismatch!" & 
                               " x=" & integer'image(i) & 
                               " y=" & integer'image(j) & 
                               " cin=" & integer'image(k)
                        severity error;
                        
                end loop;
            end loop;
        end loop;
        
        -- Success message
        report "Simulation complete. If no ERROR messages appeared above, all 128 cases passed!" 
        severity note;
        
        wait; -- Suspend process
    end process;

end architecture testbench;
