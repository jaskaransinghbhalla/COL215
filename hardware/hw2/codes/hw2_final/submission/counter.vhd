LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY counter IS
    PORT (
        pixel_clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        hcount : OUT INTEGER;
        vcount : OUT INTEGER
    );
END counter;

ARCHITECTURE behavioral OF counter IS
BEGIN
    hpixel_count_proc : PROCESS (pixel_clk, rst)
        VARIABLE hcount_temp : INTEGER := - 1;
        VARIABLE vcount_temp : INTEGER := 0;

    BEGIN
        IF (rst = '1') THEN
            hcount_temp := 0;
            vcount_temp := 0;
        ELSIF (pixel_clk'event AND pixel_clk = '1') THEN
            IF (hcount_temp = 799) THEN
                hcount_temp := 0;
                IF (vcount_temp = 525) THEN
                    vcount_temp := 0;
                ELSE
                    vcount_temp := vcount_temp + 1;
                END IF;
            ELSE
                hcount_temp := hcount_temp + 1;
            END IF;
        END IF;
        hcount <= hcount_temp;
        vcount <= vcount_temp;
    END PROCESS;
END behavioral;