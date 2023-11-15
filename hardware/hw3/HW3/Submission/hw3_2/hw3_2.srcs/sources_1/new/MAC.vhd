LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MAC IS
    PORT (
        CLK : IN STD_LOGIC;
        INP_VAL : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        KERNEL : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        RST : IN STD_LOGIC;
        CTRL : IN STD_LOGIC;
        OUT_MAC : OUT INTEGER
    );
END MAC;

ARCHITECTURE Behavioral OF mac IS

BEGIN
    MAC_PROC : PROCESS (CLK, RST) IS
        VARIABLE A : INTEGER := 0;
        VARIABLE M : INTEGER := 0;
    BEGIN
        IF RST = '1' THEN
            A := 0;
            OUT_MAC <= A;
        END IF;

        IF RISING_EDGE(CLK) THEN
            IF CTRL = '1' THEN
                M := TO_INTEGER(SIGNED(KERNEL)) * TO_INTEGER(UNSIGNED(INP_VAL));
                A := A + M;
            END IF;
            OUT_MAC <= A;
        END IF;

    END PROCESS;
END Behavioral;