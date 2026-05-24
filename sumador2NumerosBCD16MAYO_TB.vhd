library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- Asegúrate de tener compilado el paquete BCD_CONSTANTS o comenta la línea si no es necesario aquí
use work.BCD_CONSTANTS.all; 

entity BCDSum_tb is
-- Un testbench no tiene puertos
end entity BCDSum_tb;

architecture behavior of BCDSum_tb is

    -- Declaración del componente a probar (Device Under Test - DUT)
    component BCDSum
    port( 
        sum  : out std_logic_vector (WIDTH-1 downto 0);
        cout : out std_logic;
        a, b : in std_logic_vector (WIDTH-1 downto 0);
        cin  : in std_logic 
    );
    end component;

    -- Señales internas para conectar con el componente
    signal a_tb, b_tb : std_logic_vector (7 downto 0) := (others => '0');
    signal cin_tb     : std_logic := '0';
    signal sum_tb     : std_logic_vector (7 downto 0);
    signal cout_tb    : std_logic;

begin

    -- Instanciación del circuito combinacional
    uut: BCDSum port map (
        sum  => sum_tb,
        cout => cout_tb,
        a    => a_tb,
        b    => b_tb,
        cin  => cin_tb
    );

    -- Proceso de estímulos y comprobación
    stim_proc: process
        -- Variable para contar los errores detectados
        variable errores : integer := 0;
    begin
        -- Inicializamos el contador de errores
        errores := 0;

        ------------------------------------------------------------------
        -- CASO 1: a = "00010001" (11 BCD), b = "00010001" (11 BCD), cin = '0'
        -- Resultado esperado: 11 + 11 = 22 BCD -> sum = "00100010", cout = '0'
        ------------------------------------------------------------------
        a_tb   <= "00010001";
        b_tb   <= "00010001";
        cin_tb <= '0';
        wait for 10 ns; -- Esperamos a que la señal se propague
        
        if (sum_tb /= "00100010" or cout_tb /= '0') then
            report "ERROR en Caso 1: Salida incorrecta para 11 + 11 + 0." severity warning;
            errores := errores + 1;
        end if;

        ------------------------------------------------------------------
        -- CASO 2: a = "10011001" (99 BCD), b = "00000001" (01 BCD), cin = '0'
        -- Resultado esperado: 99 + 01 = 100 BCD -> sum = "00000000", cout = '1'
        ------------------------------------------------------------------
        a_tb   <= "10011001";
        b_tb   <= "00000001";
        cin_tb <= '0';
        wait for 10 ns;
        
        if (sum_tb /= "00000000" or cout_tb /= '1') then
            report "ERROR en Caso 2: Salida incorrecta para 99 + 01 + 0." severity warning;
            errores := errores + 1;
        end if;

        ------------------------------------------------------------------
        -- CASO 3: a = "10011001" (99 BCD), b = "00000001" (01 BCD), cin = '1'
        -- Resultado esperado: 99 + 01 + 1 = 101 BCD -> sum = "00000001", cout = '1'
        ------------------------------------------------------------------
        a_tb   <= "10011001";
        b_tb   <= "00000001";
        cin_tb <= '1';
        wait for 10 ns;
        
        if (sum_tb /= "00000001" or cout_tb /= '1') then
            report "ERROR en Caso 3: Salida incorrecta para 99 + 01 + 1." severity warning;
            errores := errores + 1;
        end if;

        ------------------------------------------------------------------
        -- CASO 4: a = "00110101" (35 BCD), b = "10001000" (88 BCD), cin = '1'
        -- Resultado esperado: 35 + 88 + 1 = 124 BCD -> sum = "00100100" (24 BCD), cout = '1'
        ------------------------------------------------------------------
        a_tb   <= "00110101";
        b_tb   <= "10001000";
        cin_tb <= '1';
        wait for 10 ns;
        
        if (sum_tb /= "00100100" or cout_tb /= '1') then
            report "ERROR en Caso 4: Salida incorrecta para 35 + 88 + 1." severity warning;
            errores := errores + 1;
        end if;

        ------------------------------------------------------------------
        -- FIN DEL TEST
        ------------------------------------------------------------------
        report "======================================================";
        report "El test ha finalizado.";
        report "Numero total de errores detectados: " & integer'image(errores);
        report "======================================================";

        -- Detenemos la simulación
        wait;
        
    end process;

end architecture behavior;