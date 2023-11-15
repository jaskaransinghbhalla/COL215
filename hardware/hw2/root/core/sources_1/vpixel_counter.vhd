LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY vpixel_counter IS
    PORT (
        pixel_clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        en : IN STD_LOGIC;
        vcount : OUT INTEGER
    );
END vpixel_counter;

ARCHITECTURE behavioral OF vpixel_counter IS
    CONSTANT VSYNC : INTEGER := 2; -- To be adjusted
    CONSTANT VFRONT : INTEGER := 10;
    CONSTANT VBP : INTEGER := 33;
    CONSTANT VACTIVE : INTEGER := 479;
BEGIN
    vpixel_count_proc : PROCESS (pixel_clk, rst, en)
        VARIABLE vcount_temp : INTEGER := 0;
    BEGIN
        IF (rst = '1') THEN
            vcount_temp := 0;
        ELSIF (rising_edge(en)) THEN
            IF (vcount_temp = (VACTIVE + VFRONT + VSYNC + VBP)) THEN
                vcount_temp := 0;
            ELSE
                vcount_temp := vcount_temp + 1;
            END IF;
        END IF;
        vcount <= vcount_temp;
    END PROCESS;
END behavioral;