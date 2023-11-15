LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY tb_vga IS
END tb_vga;

ARCHITECTURE behavioral OF tb_vga IS
    COMPONENT vga IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            input_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            vga_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            vga_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            vga_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hsync : OUT STD_LOGIC;
            vsync : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL clk_in : STD_LOGIC := '0';
    SIGNAL rst_in : STD_LOGIC := '0';
    SIGNAL input_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL clk_period : TIME := 1 ns;
    SIGNAL vga_blue : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL vga_red : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL vga_green :  STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL hsync : STD_LOGIC;
    SIGNAL vsync : STD_LOGIC;

BEGIN

    uut : vga PORT MAP(
        clk => clk_in,
        rst => rst_in,
        input_data => input_data,
        vga_red => vga_red,
        vga_blue => vga_blue,
        vga_green => vga_green,
        hsync => hsync,
        vsync => vsync
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