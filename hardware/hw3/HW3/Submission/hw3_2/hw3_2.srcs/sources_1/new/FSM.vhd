LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FSM IS
    PORT (
        CLK : IN STD_ULOGIC;
        ADDRESS : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        FSM_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END FSM;

ARCHITECTURE BEHAVIOURAL OF FSM IS
    -- -----------------------------------------------------------------------------------------------------------
    -- COMPONENTS
    -- -----------------------------------------------------------------------------------------------------------
    COMPONENT gen_rom IS
        PORT (
            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT filter_rom IS
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT MAC IS
        PORT (
            CLK : IN STD_LOGIC;
            INP_VAL : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            KERNEL : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            CTRL : IN STD_LOGIC;
            RST : IN STD_LOGIC;
            OUT_MAC : OUT INTEGER
        );
    END COMPONENT;
    COMPONENT FMMN_MODULE IS
        PORT (
            CLK : IN STD_ULOGIC;
            RST : IN STD_LOGIC;
            CTRL : IN STD_LOGIC;
            STATE : IN STD_LOGIC;
            INP_VAL : IN INTEGER;
            OUT_VAL : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT gen_ram IS
        PORT (
            clk : IN STD_LOGIC;
            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            we : IN STD_LOGIC
        );
    END COMPONENT;
    -- -----------------------------------------------------------------------------------------------------------
    -- SIGNALS
    -- -----------------------------------------------------------------------------------------------------------
    -- IMAGE ROM
    SIGNAL ROM_ADDRESS : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL ROM_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- KERNEL ROM
    SIGNAL FILTER_ROM_ADDRESS : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL FILTER_ROM_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- STATE 
    TYPE STATE_TYPE IS (FMMN, WRITE_RAM, VGA_DISPLAY);
    SIGNAL CURR_STATE : STATE_TYPE := FMMN;
    SIGNAL NXT_STATE : STATE_TYPE := WRITE_RAM;
    -- MAC
    SIGNAL CTRL_MAC : STD_LOGIC := '0';
    SIGNAL RST_MAC : STD_LOGIC := '0';
    SIGNAL RESULT_MAC : INTEGER;
    -- FMM_NORMALIZE
    SIGNAL CTRL_FMMN : STD_LOGIC := '0';
    SIGNAL RST_FMMN : STD_LOGIC := '0';
    SIGNAL STATE_FMMN : STD_LOGIC := '0';
    -- RAM
    SIGNAL WE : STD_LOGIC := '0';
    SIGNAL RAM_DATA_IN : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RAM_DATA_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RAM_ADDRESS : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    -- TESTING
    -- CONSTANT clock_period : TIME := 1 ns;
    -- SIGNAL CLK : STD_LOGIC := '0';
    -- SIGNAL ADDRESS : STD_LOGIC_VECTOR(11 DOWNTO 0);
    -- SIGNAL FSM_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    -- -----------------------------------------------------------------------------------------------------------
    -- PORT MAP
    -- -----------------------------------------------------------------------------------------------------------
    ROM_UUT : gen_rom
    PORT MAP(
        a => ROM_ADDRESS,
        spo => ROM_DATA
    );
    FILTER_ROM_UUT : filter_rom
    PORT MAP(
        a => FILTER_ROM_ADDRESS,
        spo => FILTER_ROM_DATA
    );
    MAC_UUT : MAC
    PORT MAP(
        CLK => CLK,
        INP_VAL => ROM_DATA,
        KERNEL => FILTER_ROM_DATA,
        CTRL => CTRL_MAC,
        RST => RST_MAC,
        OUT_MAC => RESULT_MAC
    );
    FMMN_UUT : FMMN_MODULE
    PORT MAP(
        CLK => CLK,
        RST => RST_FMMN,
        CTRL => CTRL_FMMN,
        STATE => STATE_FMMN,
        INP_VAL => RESULT_MAC,
        OUT_VAL => RAM_DATA_IN
    );
    RAM_UUT : gen_ram
    PORT MAP(
        clk => CLK,
        a => RAM_ADDRESS,
        spo => RAM_DATA_OUT,
        we => WE,
        d => RAM_DATA_IN
    );

    -- clock_process : PROCESS
    -- BEGIN
    --     CLK <= '0';
    --     WAIT FOR clock_period/2;
    --     CLK <= '1';
    --     WAIT FOR clock_period/2;
    -- END PROCESS;

    CLK_PROC : PROCESS (CLK)
        VARIABLE COUNTER : INTEGER := - 1;
        VARIABLE COUNTER_2 : INTEGER := - 1;
        VARIABLE CTRL_MAC_TMP : STD_LOGIC := '0';
        VARIABLE I : INTEGER := 0;
        VARIABLE J : INTEGER := 0;
        VARIABLE RST_C : STD_LOGIC := '0';
    BEGIN
        IF (RISING_EDGE(CLK)) THEN
            IF (CURR_STATE = FMMN) THEN
                COUNTER := COUNTER + 1;
                CTRL_MAC_TMP := NOT CTRL_MAC_TMP;
                CTRL_MAC <= CTRL_MAC_TMP;
                RST_C := '0';
                RST_FMMN <= RST_C;
                IF COUNTER = 0 THEN
                ELSE
                    RST_MAC <= '0';
                END IF;
                IF COUNTER = 0 THEN
                    J := I - 65;
                ELSIF COUNTER = 2 THEN
                    J := I - 64;
                ELSIF COUNTER = 4 THEN
                    J := I - 63;
                ELSIF COUNTER = 6 THEN
                    J := I - 1;
                ELSIF COUNTER = 8 THEN
                    J := I;
                ELSIF COUNTER = 10 THEN
                    J := I + 1;
                ELSIF COUNTER = 12 THEN
                    J := I + 63;
                ELSIF COUNTER = 14 THEN
                    J := I + 64;
                ELSIF COUNTER = 16 THEN
                    J := I + 65;
                END IF;
                IF COUNTER = 19 THEN
                    CTRL_FMMN <= '1';
                    STATE_FMMN <= '1';
                ELSE
                    CTRL_FMMN <= '0';
                END IF;
                IF COUNTER = 20 THEN
                    RST_MAC <= '1';
                    COUNTER := 0;
                    I := I + 1;
                END IF;
                IF (
                    (((I + 1) MOD 64) = 0 AND (COUNTER = 4 OR COUNTER = 10 OR COUNTER = 16)) OR
                    ((I MOD 64) = 0 AND (COUNTER = 6 OR COUNTER = 0 OR COUNTER = 12)) OR
                    (I < 64 AND COUNTER < 6) OR
                    (I > 4031 AND COUNTER > 10)
                    ) THEN
                    CTRL_MAC <= '0';
                END IF;

                IF J >= 0 AND J < 4096 THEN
                    ROM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED(J, 12));

                END IF;

                IF I = 4096 THEN
                    CURR_STATE <= NXT_STATE;
                    NXT_STATE <= WRITE_RAM;
                    I := 0;
                    J := 0;
                    CTRL_MAC_TMP := '0';
                END IF;
                FILTER_ROM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER/2, 4));
            ELSIF (CURR_STATE = WRITE_RAM) THEN
                COUNTER_2 := COUNTER_2 + 1;
                CTRL_MAC_TMP := NOT CTRL_MAC_TMP;
                CTRL_MAC <= CTRL_MAC_TMP;
                RST_C := '0';
                RST_FMMN <= RST_C;
                IF COUNTER_2 = 0 THEN
                    -- WE <= '1';
                    WE <= '0';
                ELSE
                    RST_MAC <= '0';
                END IF;

                IF COUNTER_2 = 0 THEN
                    J := I - 65;
                ELSIF COUNTER_2 = 2 THEN
                    J := I - 64;
                ELSIF COUNTER_2 = 4 THEN
                    J := I - 63;
                ELSIF COUNTER_2 = 6 THEN
                    J := I - 1;
                ELSIF COUNTER_2 = 8 THEN
                    J := I;
                ELSIF COUNTER_2 = 10 THEN
                    J := I + 1;
                ELSIF COUNTER_2 = 12 THEN
                    J := I + 63;
                ELSIF COUNTER_2 = 14 THEN
                    J := I + 64;
                ELSIF COUNTER_2 = 16 THEN
                    J := I + 65;
                END IF;
                IF COUNTER_2 = 19 THEN
                    WE <= '1';
                    CTRL_FMMN <= '1';
                ELSE
                    CTRL_FMMN <= '0';
                END IF;
                IF COUNTER_2 = 20 THEN
                    WE <= '0';
                    RST_MAC <= '1';
                    COUNTER_2 := 0;
                    I := I + 1;
                END IF;

                IF (
                    (((I + 1) MOD 64) = 0 AND (COUNTER_2 = 4 OR COUNTER_2 = 10 OR COUNTER_2 = 16)) OR
                    ((I MOD 64) = 0 AND (COUNTER_2 = 6 OR COUNTER_2 = 0 OR COUNTER_2 = 12)) OR
                    (I < 64 AND COUNTER_2 < 6) OR
                    (I > 4031 AND COUNTER_2 > 10)
                    ) THEN
                    CTRL_MAC <= '0';
                END IF;

                IF J >= 0 AND J < 4096 THEN
                    ROM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED(J, 12));
                END IF;
                IF I = 4096 THEN
                    CURR_STATE <= NXT_STATE;
                    NXT_STATE <= VGA_DISPLAY;
                    I := 0;
                END IF;
                FILTER_ROM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER_2/2, 4));
                STATE_FMMN <= '0';
                RAM_ADDRESS <= STD_LOGIC_VECTOR(TO_UNSIGNED(I, 12));
            ELSIF (CURR_STATE = VGA_DISPLAY) THEN
                WE <= '0';
                RAM_ADDRESS <= ADDRESS;
            END IF;
        END IF;
    END PROCESS;
    FSM_OUT <= RAM_DATA_OUT;
END BEHAVIOURAL;