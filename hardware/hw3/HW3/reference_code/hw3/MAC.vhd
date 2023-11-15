LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MAC IS
    PORT (
        clk : IN STD_ULOGIC;
        in1, in2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        cntrl : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        result : OUT INTEGER
    );
END MAC;

ARCHITECTURE MAC_A OF MAC IS

BEGIN
    MAC_process : PROCESS (clk, reset) IS
        VARIABLE accumulator : INTEGER := 0;
    BEGIN
        IF reset = '1' THEN
            accumulator := 0;
            result <= accumulator;
        END IF;
        IF rising_edge(clk) THEN
            IF cntrl = '1' THEN
                accumulator := accumulator + to_integer(signed(in1)) * to_integer(unsigned(in2));
            END IF;
            result <= accumulator;
        END IF;
    END PROCESS;

END MAC_A; -- MAC_A