LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY tb_root IS
END tb_root;

ARCHITECTURE behavioral OF tb_root IS
    COMPONENT root IS
        PORT (
            clk : IN STD_LOGIC;
            vga_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            vga_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            vga_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hsync : OUT STD_LOGIC;
            vsync : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    stimulus_proc : PROCESS
    BEGIN
        FOR i IN 1 TO 10000 LOOP
            clk <= NOT clk;
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;
END behavioral;