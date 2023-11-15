LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY computeUnit IS
    PORT (
        computeUnit_clk : IN STD_ULOGIC;
        accumulatedInt : IN INTEGER;
        finalOutput : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        findMaxMinState : IN STD_LOGIC);
END ENTITY;

ARCHITECTURE computeUnit_A OF computeUnit IS
BEGIN
    PROCESS (computeUnit_clk)
        VARIABLE minvalue : INTEGER := 3000000;
        VARIABLE maxvalue : INTEGER := - 3000000;
    BEGIN
        IF (rising_edge(computeUnit_clk)) THEN
            finalOutput <= "00000000";
            IF (findMaxMinState = '1') THEN
                IF minvalue > accumulatedInt THEN
                    minvalue := accumulatedInt;
                END IF;
                IF maxvalue < accumulatedInt THEN
                    maxvalue := accumulatedInt;
                END IF;
            ELSE
                IF (maxvalue = minvalue) THEN
                    finalOutput <= STD_LOGIC_VECTOR(to_unsigned(minvalue, 8));
                ELSE
                    finalOutput <= STD_LOGIC_VECTOR(to_unsigned(((255) * (accumulatedInt - minvalue))/(maxvalue - minvalue), 8));
                END IF;
            END IF;
        END IF;
    END PROCESS;
END computeUnit_A; -- computeUnit_A