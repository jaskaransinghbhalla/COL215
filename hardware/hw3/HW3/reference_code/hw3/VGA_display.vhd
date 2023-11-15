LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY VGA_display IS
    --port();
    PORT (
        clk : IN STD_ULOGIC;
        R0, R1, R2, R3, G0, G1, G2, G3, B0, B1, B2, B3 : OUT STD_LOGIC;
        Hs, Vs : OUT STD_LOGIC);
END VGA_display;

ARCHITECTURE VGA_display_a OF VGA_display IS
    --for Display counter
    COMPONENT displayCounter IS
        PORT (
            clk : IN STD_ULOGIC;
            pclk : OUT STD_ULOGIC;
            Hcnt, Vcnt : OUT INTEGER;
            rst : IN BIT);
    END COMPONENT;
    SIGNAL Hcnt, Vcnt : INTEGER;
    SIGNAL rst : BIT;

    --    component gradient is
    --        port(clk: in std_ulogic;
    --            vga_enable: out BIT;
    --            a: In STD_LOGIC_VECTOR(15 downto 0);
    --            d: OUT STD_LOGIC_VECTOR(7 downto 0));
    --    end component;
    COMPONENT FSM IS
        PORT (
            clk : IN STD_ULOGIC;
            VGA_DAddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    SIGNAL vga_enable : BIT := '1';
    SIGNAL addr : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL d : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL count : INTEGER := 0;
    SIGNAL pclk : STD_LOGIC;
    CONSTANT addressWidth : INTEGER := 12;
    CONSTANT widthLastIndP100 : INTEGER := 163; --this is the last location of the pizel to be dipslayed
    CONSTANT totalPixelCountM1 : INTEGER := 4095;

BEGIN
    displayCounter_Comp : DisplayCounter PORT MAP(clk, pclk, Hcnt, Vcnt, rst);
    FSM_Comp : FSM PORT MAP(pclk, addr, d);
    -- edgeDetectionProcess: process(clk) begin

    -- end process;
    diplayProcess : PROCESS (Hcnt, Vcnt) BEGIN
        IF Hcnt = 656 THEN
            Hs <= '0';
        END IF;
        IF Hcnt = 752 THEN
            Hs <= '1';
        END IF;
        IF Vcnt = 490 THEN
            Vs <= '0';
        END IF;
        IF Vcnt = 492 THEN
            Vs <= '1';
        END IF;
        --need to code the logic for edge and ram changes
        R0 <= '0';
        R1 <= '0';
        R2 <= '0';
        R3 <= '0';
        G0 <= '0';
        G1 <= '0';
        G2 <= '0';
        G3 <= '0';
        B0 <= '0';
        B1 <= '0';
        B2 <= '0';
        B3 <= '0';

        --can show the dipslay
        IF Vcnt > 99 THEN
            IF Vcnt <= widthLastIndP100 THEN
                IF Hcnt = 99 THEN
                    addr <= STD_LOGIC_VECTOR(to_unsigned(Hcnt - 99 + (Vcnt - 100) * 64, addressWidth));
                END IF;
                IF Hcnt > 99 THEN
                    IF Hcnt <= widthLastIndP100 THEN
                        R0 <= d(4);
                        R1 <= d(5);
                        R2 <= d(6);
                        R3 <= d(7);
                        G0 <= d(4);
                        G1 <= d(5);
                        G2 <= d(6);
                        G3 <= d(7);
                        B0 <= d(4);
                        B1 <= d(5);
                        B2 <= d(6);
                        B3 <= d(7);
                        addr <= STD_LOGIC_VECTOR(to_unsigned(Hcnt - 99 + (Vcnt - 100) * 64, addressWidth));

                    END IF;
                END IF;
            END IF;
        END IF;

    END PROCESS;
END VGA_display_a;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY clockDivider IS
    --  Port ( );
    PORT (
        clk : IN STD_ULOGIC;
        pclk : OUT STD_ULOGIC);
END clockDivider;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY horizontalCounter IS
    PORT (
        pclk : IN STD_ULOGIC;
        rst : IN BIT;
        Hcnt : OUT INTEGER;
        en : OUT BIT);
END horizontalCounter;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY verticalCounter IS
    PORT (
        pclk : IN STD_ULOGIC;
        rst : IN BIT;
        Vcnt : OUT INTEGER;
        enable : IN BIT);
END verticalCounter;

ARCHITECTURE Behavioral2 OF clockDivider IS
    SIGNAL count : INTEGER := 0;
    SIGNAL q : STD_ULOGIC := '0';
BEGIN
    pclk <= q;
    clock_divider : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF count = 1 THEN
                count <= 0;
            ELSE
                count <= count + 1;
            END IF;
            IF count = 0 THEN
                q <= NOT q;
            END IF;
        END IF;
    END PROCESS;

END Behavioral2;

ARCHITECTURE HorizontalCounter_a OF horizontalCounter IS
    SIGNAL count : INTEGER := 0;
    SIGNAL reset : BIT := '1';
BEGIN
    Hcnt <= count;
    HoriozntalCounter_p : PROCESS (pclk) BEGIN
        IF rst = '1' THEN
            reset <= '1';
        END IF;
        IF rising_edge(pclk) THEN
            IF count = 799 THEN
                count <= 0;
            ELSE
                count <= count + 1;
            END IF;
            IF reset = '1' THEN
                count <= 0;
                reset <= '0';
            END IF;
        END IF;
        IF count = 799 THEN
            en <= '1';
        ELSE
            en <= '0';
        END IF;
    END PROCESS;

END HorizontalCounter_a;
ARCHITECTURE verticalCounter_a OF verticalCounter IS
    SIGNAL count : INTEGER := 0;
    SIGNAL reset : BIT := '1';
BEGIN
    Vcnt <= count;
    verticalCounter_p : PROCESS (pclk, rst) BEGIN
        IF rst = '1' THEN
            reset <= '1';
        END IF;
        IF rising_edge(pclk) THEN
            IF enable = '1' THEN
                IF (count = 524) THEN
                    count <= 0;
                ELSE
                    count <= count + 1;
                END IF;
            END IF;
            IF reset = '1' THEN
                count <= 0;
                reset <= '0';
            END IF;
        END IF;
    END PROCESS;

END verticalCounter_a;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY displayCounter IS
    PORT (
        clk : IN STD_ULOGIC;
        pclk : OUT STD_ULOGIC;
        Hcnt, Vcnt : OUT INTEGER;
        rst : IN BIT);
END displayCounter;

ARCHITECTURE displayCounter_A OF displayCounter IS
    COMPONENT clockDivider IS
        PORT (
            clk : IN STD_ULOGIC;
            pclk : OUT STD_ULOGIC);
    END COMPONENT;
    COMPONENT horizontalCounter IS
        PORT (
            pclk : IN STD_ULOGIC;
            rst : IN BIT;
            Hcnt : OUT INTEGER;
            en : OUT BIT);
    END COMPONENT;
    COMPONENT verticalCounter IS
        PORT (
            pclk : IN STD_ULOGIC;
            rst : IN BIT;
            Vcnt : OUT INTEGER;
            enable : IN BIT);
    END COMPONENT;

    SIGNAL pclk2 : STD_ULOGIC := '0';
    SIGNAL en : BIT;
BEGIN
    clockdividerComponent : clockDivider PORT MAP(clk, pclk2);
    horiznotalCounterComponent : horizontalCounter PORT MAP(pclk2, rst, Hcnt, en);
    verticalCounterComponent : verticalCounter PORT MAP(pclk2, rst, Vcnt, en);
    pclk <= pclk2;
END displayCounter_A; -- displayCounter_A