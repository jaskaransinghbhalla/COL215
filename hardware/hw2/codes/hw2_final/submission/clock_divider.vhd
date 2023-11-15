LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY clock_divider IS
    PORT (
        clk : IN STD_LOGIC;
        pixel_clk : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF clock_divider IS
    SIGNAL clk25, clk50 : STD_LOGIC := '0';
BEGIN
    pixel_clk <= clk25;
    clk_50_proc : PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            clk50 <= NOT clk50;
        END IF;
    END PROCESS;

    clk_25_proc : PROCESS (clk50)
    BEGIN
        IF (clk50'event AND clk50 = '1') THEN
            clk25 <= NOT clk25;
        END IF;
    END PROCESS;
END behavioral;