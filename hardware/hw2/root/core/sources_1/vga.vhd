LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY vga IS
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
END vga;

ARCHITECTURE behavioral OF vga IS
    -- COMPONENTS
    COMPONENT clock_divider IS
        PORT (
            clk : IN STD_LOGIC;
            pixel_clk : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT hpixel_counter IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            hcount : OUT INTEGER;
            en : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT vpixel_counter IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            en : IN STD_LOGIC;
            vcount : OUT INTEGER
        );
    END COMPONENT;
    -- SIGNALS
    SIGNAL video_on : STD_LOGIC := '0';
    SIGNAL pixel_clk : STD_LOGIC := '0';
    SIGNAL hcount : INTEGER;
    SIGNAL vcount : INTEGER;
    SIGNAL en : STD_LOGIC := '0';
    SIGNAL hsync_out : STD_LOGIC := '0';
    SIGNAL vsync_out : STD_LOGIC := '0';
    -- CONSTANTS -- TO BE DECIDED
    CONSTANT HSYNC_V : INTEGER := 96;
    CONSTANT HBACK : INTEGER := 48;
    CONSTANT HFRONT : INTEGER := 16;
    CONSTANT HACTIVE : INTEGER := 639;
    CONSTANT VSYNC_V : INTEGER := 2;
    CONSTANT VFRONT : INTEGER := 10;
    CONSTANT VBACK : INTEGER := 33;
    CONSTANT VACTIVE : INTEGER := 479;
    SIGNAL input_data_sample : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
BEGIN
    -- MAPPINGS
    input_data_sample <= input_data;
    -- PORT MAPS
    -- 1. CLOCK DIVIDER
    clock_divider_uut : clock_divider PORT MAP(
        clk => clk,
        pixel_clk => pixel_clk
    );

    -- 2. HCOUNTER
    hcounter_uut : hpixel_counter PORT MAP(
        pixel_clk => pixel_clk,
        rst => rst,
        hcount => hcount,
        en => en
    );
    -- 3. VCOUNTER
    vcounter_uut : vpixel_counter PORT MAP(
        pixel_clk => pixel_clk,
        rst => rst,
        en => en,
        vcount => vcount
    );
    -- PROCESSES
    horizontal_synchronisation_proc : PROCESS (hcount)
    BEGIN
        IF (hcount = 0) THEN
            hsync_out <= '0';
        ELSE
            IF (hcount <= (HACTIVE + HFRONT) OR (hcount > HACTIVE + HFRONT + HSYNC_V)) THEN
                hsync_out <= '1';
            ELSE
                hsync_out <= '0';
            END IF;
        END IF;
    END PROCESS;

    vertical_synchronisation_proc : PROCESS (vcount)
    BEGIN
        IF (vcount = 0) THEN
            vsync_out <= '0';
            IF (vcount <= (VACTIVE + VFRONT) OR (vcount > VACTIVE + VFRONT + VSYNC_V)) THEN
                vsync_out <= '1';
            ELSE
                vsync_out <= '0';
            END IF;
        END IF;
    END PROCESS;

    video_on_proc : PROCESS (hcount, vcount)
    BEGIN
        IF (hcount = 0 AND vcount = 0) THEN
            video_on <= '0';
        ELSE
            IF (hcount <= HACTIVE AND hcount >= HBACK AND vcount <= VACTIVE AND vcount >= VBACK) THEN
                video_on <= '1';
            ELSE
                video_on <= '0';
            END IF;
        END IF;
    END PROCESS;

    display_proc : PROCESS (hsync_out, vsync_out, video_on)
    BEGIN
        hsync <= hsync_out;
        vsync <= vsync_out;
        IF (video_on = '1') THEN
            vga_red <= input_data(7 DOWNTO 4);
            vga_blue <= input_data(7 DOWNTO 4);
            vga_green <= input_data(7 DOWNTO 4);
        ELSE
            vga_red <= "0000";
            vga_blue <= "0000";
            vga_green <= "0000";
        END IF;
    END PROCESS;
END behavioral;