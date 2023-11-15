LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY vga IS
    PORT (
        clk : IN STD_LOGIC;
        vga_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        vga_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        vga_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        hsync : OUT STD_LOGIC;
        vsync : OUT STD_LOGIC
    );
END vga;

ARCHITECTURE behavioral OF vga IS
    -- -----------------------------------------------------------------------------------------------------------
    -- SIGNALS
    -- -----------------------------------------------------------------------------------------------------------
    -- ROM
    SIGNAL rom_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    -- RAM
    SIGNAL ram_we : STD_LOGIC := '1';
    -- GRADIENT
    SIGNAL clk_4_v_2 : INTEGER := 0;
    SIGNAL ctr : INTEGER := 0;
    SIGNAL ctr2 : INTEGER := 0;
    SIGNAL i : INTEGER := 0;
    SIGNAL address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL trigger : STD_LOGIC := '0';
    -- CLOCK
    SIGNAL clk_4 : STD_LOGIC := '0';
    SIGNAL clk_4_v : INTEGER := 0;
    -- VGA
    SIGNAL pixel_clk : STD_LOGIC := '0';
    SIGNAL ready : STD_LOGIC := '0';
    SIGNAL video_on : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL hcount : INTEGER;
    SIGNAL vcount : INTEGER;
    -- -----------------------------------------------------------------------------------------------------------
    -- COMPONENTS
    -- -----------------------------------------------------------------------------------------------------------
    -- ROM
    COMPONENT gen_rom
        PORT (
            a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    -- CLOCK DIVIDER
    COMPONENT clock_divider IS
        PORT (
            clk : IN STD_LOGIC;
            pixel_clk : OUT STD_LOGIC
        );
    END COMPONENT;
    -- COUNTER
    COMPONENT counter IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            hcount : OUT INTEGER;
            vcount : OUT INTEGER
        );
    END COMPONENT;
    -- GRADIENT
    COMPONENT gradient
        PORT (
            clk : IN STD_LOGIC;
            ready : OUT STD_LOGIC;
            data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            trig : IN STD_LOGIC
        );
    END COMPONENT;
BEGIN
    -- -----------------------------------------------------------------------------------------------------------
    -- PORT MAP
    -- -----------------------------------------------------------------------------------------------------------
    -- ROM
    rom_uut : gen_rom PORT MAP(
        a => rom_address,
        spo => rom_data
    );
    -- CLOCK DIVIDER
    clock_divider_uut : clock_divider PORT MAP(
        clk => clk,
        pixel_clk => pixel_clk
    );
    -- COUNTER
    counter_uut : counter PORT MAP(
        pixel_clk => pixel_clk,
        rst => reset,
        hcount => hcount,
        vcount => vcount
    );
    -- GRADIENT 
    gradient_uut : gradient
    PORT MAP(
        clk => clk,
        ready => ready,
        data => data,
        address => address,
        trig => trigger
    );
    -- --------------------------------------------------------------------------------------------------------
    -- PROCESSES
    -- --------------------------------------------------------------------------------------------------------
    synchronisation_proc : PROCESS (hcount, vcount)
    BEGIN
        -- 
        IF (hcount = 0) THEN
            hsync <= '1';
        ELSE
            IF ((hcount < 752) AND (hcount > 655)) THEN
                hsync <= '0';
            ELSE
                hsync <= '1';
            END IF;
        END IF;
        -- 
        IF (vcount = 0) THEN
            vsync <= '1';
        ELSE
            IF ((vcount < 492) AND (vcount >= 490)) THEN
                vsync <= '0';
            ELSE
                vsync <= '1';
            END IF;
        END IF;
        -- 
        IF (hcount <= 639 AND vcount <= 479) THEN
            video_on <= '1';
        ELSE
            video_on <= '0';
        END IF;
        -- 
    END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
    gradient_clk_proc : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF clk_4_v = 3 THEN
                clk_4 <= '1';
                clk_4_v <= 0;
            ELSE
                clk_4 <= '0';
                clk_4_v <= clk_4_v + 1;
            END IF;
        END IF;
    END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
    gradient_clk_proc_2 : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF ready = '1' THEN
                reset <= '0';
                IF clk_4 = '1' THEN
                    clk_4_v_2 <= 0;
                ELSE
                    clk_4_v_2 <= clk_4_v_2 + 1;
                END IF;
            ELSE
                reset <= '1';
            END IF;
        END IF;
    END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
    -- RAM
    ram_display_proc : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (ready = '1') THEN
                IF (video_on = '1') THEN
                    IF hcount < 256 AND vcount < 256 THEN
                        IF clk_4_v_2 = 0 THEN
                            trigger <= '1';
                            address <= STD_LOGIC_VECTOR(TO_UNSIGNED(ctr, 16));
                        END IF;
                        IF clk_4_v_2 = 3 THEN
                            trigger <= '0';
                            vga_red <= data(7 DOWNTO 4);
                            vga_green <= data(7 DOWNTO 4);
                            vga_blue <= data(7 DOWNTO 4);
                            IF ctr = 65535 THEN
                                ctr <= 0;
                            ELSE
                                ctr <= ctr + 1;
                            END IF;
                        END IF;
                    ELSE
                        vga_red <= "0000";
                        vga_green <= "0000";
                        vga_blue <= "0000";
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
    -- ROM
    -- rom_display_proc : PROCESS (hcount, vcount)
    -- BEGIN
    --     IF (video_on = '1') THEN
    --         IF (hcount < 256 AND vcount < 256) THEN
    --             rom_address <= STD_LOGIC_VECTOR(to_unsigned(vcount * 256 + hcount, 16));
    --             vga_red <= rom_data(7 DOWNTO 4);
    --             vga_blue <= rom_data(7 DOWNTO 4);
    --             vga_green <= rom_data(7 DOWNTO 4);
    --         ELSE
    --             rom_address <= "0000000000000000";
    --             vga_red <= "0000";
    --             vga_blue <= "0000";
    --             vga_green <= "0000";
    --         END IF;
    --     ELSE
    --         vga_red <= "0000";
    --         vga_blue <= "0000";
    --         vga_green <= "0000";
    --         rom_address <= "0000000000000000";
    --     END IF;
    -- END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
END behavioral;