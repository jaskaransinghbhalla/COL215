LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_clock_divider IS
END tb_clock_divider;

ARCHITECTURE behavioral OF tb_clock_divider IS
    COMPONENT clock_divider IS
        PORT (
            clk : IN STD_LOGIC;
            pixel_clk : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL clk_in, pixel_clk_out : STD_LOGIC := '0';
    SIGNAL clk_period : TIME := 1 ns;

BEGIN

    uut : clock_divider PORT MAP(
        clk => clk_in,
        pixel_clk => pixel_clk_out
    );

    stimulus_proc : PROCESS
    BEGIN
        FOR i IN 1 TO 1000 LOOP
            clk_in <= NOT clk_in;
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;
END behavioral;