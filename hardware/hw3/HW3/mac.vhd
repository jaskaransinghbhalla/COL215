LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY mac IS
    PORT (
        clk : IN STD_ULOGIC;
        v1, w1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        reset : IN STD_LOGIC;
        cntrl : IN STD_LOGIC; -- doubt
        result : OUT INTEGER
    );
END mac;

ARCHITECTURE Behavioural OF MAC IS
BEGIN
    PROCESS : PROCESS (clk, reset) IS
        VARIABLE accumulator : INTEGER := 0;
    BEGIN

        IF reset = '1' THEN
            accumulator := 0;
        END IF;

        IF rising_edge(clk) THEN
            IF cntrl = '1' THEN -- doubt
                accumulator := accumulator + to_integer(signed(v1)) * to_integer(unsigned(w1));
            END IF;
        END IF;

        result <= accumulator;

    END PROCESS;
END Behavioural;