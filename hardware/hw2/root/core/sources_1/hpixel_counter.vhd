LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY hpixel_counter IS
    PORT (
        pixel_clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        en : OUT STD_LOGIC;
        hcount : OUT INTEGER
    );
END hpixel_counter;

ARCHITECTURE behavioral OF hpixel_counter IS
    CONSTANT HSYNC : INTEGER := 96;
    CONSTANT HBACK : INTEGER := 48;
    CONSTANT HFRONT : INTEGER := 16;
    CONSTANT HACTIVE : INTEGER := 639;
BEGIN
    hpixel_count_proc : PROCESS (pixel_clk, rst)
        VARIABLE hcount_temp : INTEGER := 0;
    BEGIN
        IF (rst = '1') THEN
            hcount_temp := 0;
            en <= '0';
        ELSIF (pixel_clk'event AND pixel_clk = '1') THEN
            IF (hcount_temp = (HACTIVE + HFRONT + HSYNC + HBACK)) THEN
                hcount_temp := 0;
                en <= '1';
            ELSE
                hcount_temp := hcount_temp + 1;
            END IF;
        END IF;
        hcount <= hcount_temp;
    END PROCESS;
END behavioral;