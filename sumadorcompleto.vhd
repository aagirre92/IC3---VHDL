library IEEE;
use IEEE.std_logic_1164.all;

entity sumador_n_bits is
    generic (
        N : integer := 4  -- Definimos N con un valor por defecto de 4 bits
    );
    port (
        A, B : in  std_logic_vector(N-1 downto 0);
        Cin  : in  std_logic;
        S    : out std_logic_vector(N-1 downto 0);
        Cout : out std_logic
    );
end entity sumador_n_bits;

architecture estructural of sumador_n_bits is


    -- Solo necesitamos una signal AUXILIAR para la cadena de acarreos
    signal acarreo : std_logic_vector(N downto 0);

begin

    -- Conectamos el acarreo de entrada (Cin) a la posición 0
    acarreo(0) <= Cin;

    -- BUCLE GENERATE
    gen_sumadores: for i in 0 to N-1 generate
        -- INSTANCIACIÓN DIRECTA: Llamamos directamente a la entidad compilada en "work"
        inst_sumador: entity work.sumador_1_bit(rtl)
            port map (
                a    => A(i),
                b    => B(i),
                cin  => acarreo(i),
                s    => S(i),
                cout => acarreo(i+1) --salida
            );
    end generate gen_sumadores;

    -- Conectamos el último acarreo generado a la salida final Cout
    Cout <= acarreo(N);

end architecture estructural;