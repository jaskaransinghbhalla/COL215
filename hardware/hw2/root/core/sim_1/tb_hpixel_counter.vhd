LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_hpixel_counter IS
END tb_hpixel_counter;

ARCHITECTURE behavioral OF tb_hpixel_counter IS
    COMPONENT hpixel_counter IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            en : INOUT STD_LOGIC;
            hcount : OUT INTEGER
        );
    END COMPONENT;

    SIGNAL pixel_clk_in : STD_LOGIC := '0';
    SIGNAL rst_in : STD_LOGIC := '0';
    SIGNAL hcount : INTEGER;
    SIGNAL en_out : STD_LOGIC;
    
    SIGNAL clk_period : TIME := 1 ns;
BEGIN

    uut : hpixel_counter PORT MAP(
        pixel_clk => pixel_clk_in,
        rst => rst_in,
        en => en_out
        hcount => hcount
    );

    stimulus_proc : PROCESS
    BEGIN
        WAIT FOR clk_period / 2;
        FOR i IN 1 TO 10000 LOOP
            pixel_clk_in <= NOT pixel_clk_in;
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;
END behavioral;