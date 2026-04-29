library ieee;
use ieee.std_logic_1164.all;

-- 1. Package Declaration
package andoni_string_utils is
    function to_string(slv : std_logic_vector) return string;
	constant TEXTO: string:="Why are you geh"; -- string son double quotes
end package andoni_string_utils;

-- 2. Package Body
package body andoni_string_utils is

    function to_string(slv : std_logic_vector) return string is
        variable resul : string(1 to slv'length);
        variable istr  : integer := 1;
    begin
        for i in slv'range loop
            case slv(i) is
                when 'U' => resul(istr) := 'U';
                when 'X' => resul(istr) := 'X';
                when '0' => resul(istr) := '0';
                when '1' => resul(istr) := '1';
                when 'Z' => resul(istr) := 'Z';
                when 'W' => resul(istr) := 'W';
                when 'L' => resul(istr) := 'L';
                when 'H' => resul(istr) := 'H';
                when '-' => resul(istr) := '-';
                when others => resul(istr) := '?'; -- Catch-all for safety
            end case;
            istr := istr + 1;
        end loop;
        return resul;
    end function to_string;

end package body andoni_string_utils;