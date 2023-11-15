LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY VGA IS
       PORT (
           clk : IN STD_LOGIC;
           vgaRed : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
           vgaBlue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
           vgaGreen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
           hsync : OUT STD_LOGIC;
           vsync : OUT STD_LOGIC
       );
END VGA;

ARCHITECTURE BEHAVIORAL OF VGA IS
    -- -----------------------------------------------------------------------------------------------------------
    -- SIGNALS
    -- -----------------------------------------------------------------------------------------------------------
    SIGNAL i : INTEGER := 0;
    -- VGA
    SIGNAL PIXEL_CLK : STD_LOGIC := '0';
    SIGNAL ready : STD_LOGIC := '0';
    SIGNAL video_on : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL hcount : INTEGER;
    SIGNAL vcount : INTEGER;
    --
    SIGNAL FSM_ADDRESS : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    SIGNAL FSM_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- CONSTANT clock_period : TIME := 1 ns;
    -- SIGNAL CLK : STD_LOGIC := '0';
    -- SIGNAL hsync : STD_LOGIC := '0';
    -- SIGNAL vsync : STD_LOGIC := '0';
    -- SIGNAL vgaRed : STD_LOGIC_VECTOR(3 DOWNTO 0);
    -- SIGNAL vgaBlue : STD_LOGIC_VECTOR(3 DOWNTO 0);
    -- SIGNAL vgaGreen : STD_LOGIC_VECTOR(3 DOWNTO 0);
    -- SIGNAL rom_address : STD_LOGIC_VECTOR(11 DOWNTO 0);
    -- SIGNAL rom_data : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- -----------------------------------------------------------------------------------------------------------
    -- COMPONENTS
    -- -----------------------------------------------------------------------------------------------------------
    -- ROM

    --    COMPONENT gen_rom
    --        PORT (
    --            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    --            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    --        );
    --    END COMPONENT;
    -- CLOCK DIVIDER
    COMPONENT CLK_DIV IS
        PORT (
            clk : IN STD_LOGIC;
            PIXEL_CLK : OUT STD_LOGIC
        );
    END COMPONENT;
    -- COUNTER
    COMPONENT COUNTER IS
        PORT (
            PIXEL_CLK : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            HCOUNT : OUT INTEGER;
            VCOUNT : OUT INTEGER
        );
    END COMPONENT;
    COMPONENT FSM IS
        PORT (
            CLK : IN STD_LOGIC;
            ADDRESS : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            FSM_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    -- -----------------------------------------------------------------------------------------------------------
    -- PORT MAP
    -- -----------------------------------------------------------------------------------------------------------
    -- ROM
    -- rom_uut : gen_rom PORT MAP(
    --     a => rom_address,
    --     spo => rom_data
    -- );
    --    CLOCK DIVIDER
    CLK_DIV_UUT : CLK_DIV PORT MAP(
        CLK => clk,
        PIXEL_CLK => PIXEL_CLK
    );
    --    COUNTER
    COUNTER_UUT : COUNTER PORT MAP(
        PIXEL_CLK => PIXEL_CLK,
        RST => reset,
        HCOUNT => hcount,
        VCOUNT => vcount
    );
    FSM_UUT : FSM PORT MAP(
        CLK => PIXEL_CLK,
        ADDRESS => FSM_ADDRESS,
        FSM_OUT => FSM_DATA
    );
    -- --------------------------------------------------------------------------------------------------------
    -- PROCESSES
    -- --------------------------------------------------------------------------------------------------------

    -- clock_process : PROCESS
    -- BEGIN
    --     CLK <= '0';
    --     WAIT FOR clock_period/2;
    --     CLK <= '1';
    --     WAIT FOR clock_period/2;
    -- END PROCESS;

    SYNC_PROC : PROCESS (hcount, vcount)
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

    -- RAM
    DISPLAY_PROC : PROCESS (hcount, vcount, clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (video_on = '1') THEN
                -- IF vcount > 0 AND vcount < 65 
                IF vcount > 99 AND vcount < 164 THEN
                    -- IF hcount >= 0 AND hcount < 64 THEN
                    IF hcount >= 99 AND hcount < 163 THEN
                        -- FSM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED((vcount - 1) * 64 + (hcount - 0), 12));
                        FSM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED((vcount - 100) * 64 + (hcount - 99), 12));
                        vgaRed <= FSM_DATA(7 DOWNTO 4);
                        vgaGreen <= FSM_DATA(7 DOWNTO 4);
                        vgaBlue <= FSM_DATA(7 DOWNTO 4);
                    ELSE
                        vgaRed <= "0000";
                        vgaGreen <= "0000";
                        vgaBlue <= "0000";
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
    -- ROM
    -- DISPLAY_PROC : PROCESS (hcount, vcount)
    -- BEGIN
    --     IF (video_on = '1') THEN
    --         IF (hcount < 64 AND vcount < 64) THEN
    --             rom_address <= STD_LOGIC_VECTOR(to_unsigned(vcount * 64 + hcount, 12));
    --             vgaRed <= rom_data(7 DOWNTO 4);
    --             vgaBlue <= rom_data(7 DOWNTO 4);
    --             vgaGreen <= rom_data(7 DOWNTO 4);
    --         ELSE
    --             rom_address <= "000000000000";
    --             vgaRed <= "0000";
    --             vgaBlue <= "0000";
    --             vgaGreen <= "0000";
    --         END IF;
    --     ELSE
    --         vgaRed <= "0000";
    --         vgaBlue <= "0000";
    --         vgaGreen <= "0000";
    --            rom_address <= "000000000000";
    --     END IF;
    -- END PROCESS;
    -- ---------------------------------------------------------------------------------------------------------
    -- IF vcount > 99 AND vcount < 164 THEN
    -- IF hcount >= 99 AND hcount < 163 THEN
    -- FSM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED((vcount - 100) * 64 + (hcount - 99), 12));
END BEHAVIORAL;