LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY root IS
    PORT (
        clk : IN STD_LOGIC;
        vga_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        vga_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        vga_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        hsync : OUT STD_LOGIC;
        vsync : OUT STD_LOGIC
    );
END root;

ARCHITECTURE behavioral OF root IS
    -- COMPONENTS
    -- 1. ROM
    COMPONENT rom IS
        PORT (
            a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- 2. RAM
    -- COMPONENT ram
    --     PORT (
    --         clk : IN STD_LOGIC;
    --         we : IN STD_LOGIC;
    --         a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    --         d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    --         spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    --         -- re :IN STD_LOGIC;
    --     );
    -- END COMPONENT;

    -- 3. Gradient
    -- COMPONENT gradient IS
    -- END COMPONENT;

    -- 4. VGA
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

    -- SIGNALS
    -- 1. ROM
    SIGNAL rom_rdaddress : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- 2. RAM
    -- SIGNAL ram_clock : STD_LOGIC;
    -- SIGNAL ram_write_enable : STD_LOGIC := '1';
    -- SIGNAL ram_rdaddress : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    -- SIGNAL ram_in_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    -- SIGNAL ram_out_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- 3. GRADIENT

    -- 4. VGA
    SIGNAL vga_input : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- 5. CLOCK
    SIGNAL clock : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL i : STD_LOGIC := '0';

BEGIN
    -- Mappings

    -- PORT MAPS
    -- 1. ROM
    rom_uut : dist_mem_gen_0 PORT MAP(
        a => rom_rdaddress,
        spo => rom_data
    );

    -- 2. RAM
    -- ram_uut : ram PORT MAP(
    --     a => ram_rdaddress,
    --     d => ram_in_data,
    --     spo => ram_out_data,
    --     we => ram_write_enable,
    --     clk => ram_clock
    -- );
    -- 3. GRADIENT
    -- 4. VGA
    vga_uut : vga PORT MAP(
        clk => clk,
        rst => rst,
        input_data => vga_input,
        vga_red => vga_red,
        vga_blue => vga_blue,
        vga_green => vga_green,
        hsync => hsync,
        vsync => vsync
    );
    test_rom_vga_proc : PROCESS (clk)
    BEGIN
        FOR i IN 0 TO 65535 LOOP
            IF (rising_edge(clk)) THEN
                rom_rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 16));
                vga_input <= rom_data;
            END IF;
        END LOOP;
    END PROCESS;

    -- ROOT FPGA PROCESS
    -- main_proc : PROCESS (clk)
    -- BEGIN
    -- END PROCESS;
END behavioral;