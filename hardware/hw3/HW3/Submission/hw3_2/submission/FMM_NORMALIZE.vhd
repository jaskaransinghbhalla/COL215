LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FMMN_MODULE IS
    PORT (
        CLK : IN STD_ULOGIC;
        CTRL : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        STATE : IN STD_LOGIC;
        INP_VAL : IN INTEGER;
        OUT_VAL : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF FMMN_MODULE IS
BEGIN
    PROCESS (CLK)
        VARIABLE MIN_V : INTEGER := 2147483647;
        VARIABLE MAX_V : INTEGER := - 2147483648;
    BEGIN
        IF (RST = '1') THEN
            MAX_V := - 2147483648;
            MIN_V := 2147483647;
            OUT_VAL <= "00000000";
        END IF;
        IF (RISING_EDGE(CLK)) THEN
            IF CTRL = '1' THEN
                OUT_VAL <= "00000000";
                IF (STATE = '1') THEN
                    IF MAX_V < INP_VAL THEN
                        MAX_V := INP_VAL;
                    END IF;
                    IF MIN_V > INP_VAL THEN
                        MIN_V := INP_VAL;
                    END IF;
                ELSIF (STATE = '0') THEN
                    IF (MAX_V = MIN_V) THEN
                        OUT_VAL <= STD_LOGIC_VECTOR(TO_UNSIGNED(MAX_V, 8));
                    ELSE
                        OUT_VAL <= STD_LOGIC_VECTOR(TO_UNSIGNED(((INP_VAL - MIN_V) * (255))/(MAX_V - MIN_V), 8));
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END BEHAVIOURAL;