-- Divisor de frecuencia por 3
-- fichero: divisor_frecuencia_3.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divisor_frecuencia_3 is
    port ( clk3        : out std_logic;
           clk, resetn : in  std_logic );
end divisor_frecuencia_3;

architecture divisor_frecuencia_3 of divisor_frecuencia_3 is
    signal rise, fall : std_logic;
begin

    process (clk, resetn)  -- Calculo fall
        variable r_cnt : integer range 0 to 2; -- Variable contadora
    begin
        if resetn = '0' then
            r_cnt := 0;
            rise  <= '0';
        elsif rising_edge(clk) then
            if r_cnt = 2 then
                r_cnt := 0;
                rise  <= not rise;
            else
                r_cnt := r_cnt + 1;
            end if;
        end if;
    end process;

    process (clk, resetn)  -- Calculo rise
        variable f_cnt : integer range 0 to 2; -- Variable contadora
    begin
        if resetn = '0' then
            f_cnt := 2;
            fall  <= '1';
        elsif falling_edge(clk) then
            if f_cnt = 2 then
                f_cnt := 0;
                fall  <= not fall;
            else
                f_cnt := f_cnt + 1;
            end if;
        end if;
    end process;

    clk3 <= fall xnor rise;

end divisor_frecuencia_3;
