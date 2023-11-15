LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_vpixel_counter IS
END tb_vpixel_counter;

ARCHITECTURE behavioral OF tb_vpixel_counter IS
    COMPONENT vpixel_counter IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            en : INOUT STD_LOGIC;
            vcount : OUT INTEGER
        );
    END COMPONENT;

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
    SIGNAL en : STD_LOGIC;
    SIGNAL clk_period : TIME := 1 ns;
    SIGNAL vcount : INTEGER;
    SIGNAL hcount : INTEGER;

BEGIN

    uut : vpixel_counter PORT MAP(
        pixel_clk => pixel_clk_in,
        rst => rst_in,
        en => en,
        vcount => vcount
    );
    uut_hpixel : hpixel_counter PORT MAP(
        pixel_clk => pixel_clk_in,
        rst => rst_in,
        en => en,
        hcount => hcount
    );

    stimulus_proc : PROCESS
    BEGIN
        FOR i IN 1 TO 100000 LOOP
            pixel_clk_in <= NOT pixel_clk_in;
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;
END behavioral;