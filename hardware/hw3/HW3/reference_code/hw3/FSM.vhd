LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FSM IS
    PORT (
        clk : IN STD_ULOGIC;
        VGA_DAddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END FSM;

ARCHITECTURE Behavioral OF FSM IS

    COMPONENT RAM_K IS
        PORT (
            clk : IN STD_ULOGIC;
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    COMPONENT RAM_I IS
        PORT (
            clk : IN STD_ULOGIC;
            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    COMPONENT RAM IS
        PORT (
            clk : IN STD_ULOGIC;
            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            we : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT MAC IS
        PORT (
            clk : IN STD_ULOGIC;
            in1, in2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            cntrl : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            result : OUT INTEGER
        );
    END COMPONENT;

    COMPONENT computeUnit IS
        PORT (
            computeUnit_clk : IN STD_ULOGIC;
            reset : IN STD_LOGIC;
            compute_ctrl : IN STD_LOGIC;
            accumulatedInt : IN INTEGER;
            finalOutput : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            findMaxMinState : IN STD_LOGIC);
    END COMPONENT;

    SIGNAL romIA : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL romKA : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL romID, romKD : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL mac_ctrl, mac_reset : STD_LOGIC := '0';
    SIGNAL mac_result : INTEGER;

    SIGNAL compute_ctrl, compute_reset : STD_LOGIC := '0';
    SIGNAL findMinMaxState : STD_LOGIC := '0';

    SIGNAL ramA : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL ramWe : STD_LOGIC := '0';
    SIGNAL ramWriteData, ramD : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL vga_ok : BIT := '0';

    TYPE state_type IS (FMM, Write, Display);
    SIGNAL current_state : state_type := FMM;
    SIGNAL next_state : state_type := Write;
BEGIN

    mac_comp : MAC PORT MAP(clk, romKD, romID, mac_ctrl, mac_reset, mac_result);
    computeUnit_comp : ComputeUnit PORT MAP(computeUnit_clk => clk, reset => compute_reset, compute_ctrl => compute_ctrl, accumulatedInt => mac_result, finalOutput => ramWriteData, findMaxMinState => findMinMaxState);
    ROM_I_comp : RAM_I PORT MAP(clk, romIA, romID);
    ROM_K_comp : RAM_K PORT MAP(clk, romKA, romKD);
    RAM_comp : RAM PORT MAP(clk, ramA, ramD, ramWriteData, ramWe);
    data <= ramD;

    PROCESS (clk)
        VARIABLE looper, looper2 : INTEGER := 0;
        VARIABLE process_id : INTEGER := 0;
        VARIABLE mac_pin_state : STD_LOGIC := '1';
        VARIABLE reset_compute : STD_LOGIC := '1';
        VARIABLE addToSet : INTEGER := 0;
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (current_state = Display) THEN
                ramA <= VGA_DAddr;
            ELSIF (current_state = Write) THEN
                IF looper = 0 THEN
                    mac_reset <= '1';
                ELSE
                    mac_reset <= '0';
                END IF;

                mac_ctrl <= mac_pin_state;
                mac_pin_state := NOT mac_pin_state;

                compute_reset <= reset_compute;
                reset_compute := '0';

                --rom address setting
                --image address setting
                CASE looper/2 IS
                    WHEN 0 =>
                        addToSet := process_id - 65;
                    WHEN 1 =>
                        addToSet := process_id - 64;
                    WHEN 2 =>
                        addToSet := process_id - 63;
                    WHEN 3 =>
                        addToSet := process_id - 1;
                    WHEN 4 =>
                        addToSet := process_id;
                    WHEN 5 =>
                        addToSet := process_id + 1;
                    WHEN 6 =>
                        addToSet := process_id + 63;
                    WHEN 7 =>
                        addToSet := process_id + 64;
                    WHEN 8 =>
                        addToSet := process_id + 65;
                    WHEN -2147483648 TO -1 =>
                        addToSet := 0;
                    WHEN 9 TO 2147483647 =>
                        addToSet := 0;
                END CASE;
                IF process_id < 64 THEN
                    IF looper/2 < 3 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;
                IF process_id > 4031 THEN
                    IF looper/2 > 5 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;
                IF ((process_id MOD 64) = 0) THEN
                    IF looper/2 = 3 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;
                IF ((process_id MOD 64) = 63) THEN
                    IF looper/2 = 5 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;
                IF addToSet >= 0 AND addToSet < 4096 THEN
                    romIA <= STD_LOGIC_VECTOR(to_unsigned(addToset, 12));
                ELSE
                    romIA <= STD_LOGIC_VECTOR(to_unsigned(0, 12));
                END IF;
                --kernal address setting
                romKA <= STD_LOGIC_VECTOR(to_unsigned(looper/2, 4));
                --end address setting
                IF looper = 19 THEN
                    compute_ctrl <= '1';
                    compute_ctrl <= '1';
                ELSE
                    compute_ctrl <= '0';
                    compute_ctrl <= '0';
                END IF;
                findMinMaxState <= '0';
                ramA <= STD_LOGIC_VECTOR(to_unsigned(process_id, 12));
                IF looper = 0 THEN
                    ramWe <= '1';
                ELSE
                    ramWe <= '0';
                END IF;
                looper := looper + 1;
                IF looper = 20 THEN
                    looper := 0;
                    process_id := process_id + 1;
                END IF;
                IF process_id = 4096 THEN
                    current_state <= next_state;
                    next_state <= Display;
                    process_id := 0;
                END IF;
            ELSE
                IF looper = 0 THEN
                    mac_reset <= '1';
                ELSE
                    mac_reset <= '0';
                END IF;
                mac_ctrl <= mac_pin_state;
                mac_pin_state := NOT mac_pin_state;

                compute_reset <= reset_compute;
                reset_compute := '0';

                --rom address setting
                --image address setting
                CASE looper/2 IS
                    WHEN 0 =>
                        addToSet := process_id - 65;
                    WHEN 1 =>
                        addToSet := process_id - 64;
                    WHEN 2 =>
                        addToSet := process_id - 63;
                    WHEN 3 =>
                        addToSet := process_id - 1;
                    WHEN 4 =>
                        addToSet := process_id;
                    WHEN 5 =>
                        addToSet := process_id + 1;
                    WHEN 6 =>
                        addToSet := process_id + 63;
                    WHEN 7 =>
                        addToSet := process_id + 64;
                    WHEN 8 =>
                        addToSet := process_id + 65;
                    WHEN -2147483648 TO -1 =>
                        addToSet := 0;
                    WHEN 9 TO 2147483647 =>
                        addToSet := 0;
                END CASE;

                IF process_id < 64 THEN
                    IF looper/2 < 3 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;

                IF process_id > 4031 THEN
                    IF looper/2 > 5 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;
                IF ((process_id MOD 64) = 0) THEN
                    IF looper/2 = 3 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;

                IF ((process_id MOD 64) = 63) THEN
                    IF looper/2 = 5 THEN
                        mac_ctrl <= '0';
                    END IF;
                END IF;

                IF addToSet >= 0 AND addToSet < 4096 THEN
                    romIA <= STD_LOGIC_VECTOR(to_unsigned(addToset, 12));
                ELSE
                    romIA <= STD_LOGIC_VECTOR(to_unsigned(0, 12));
                END IF;

                --kernal address setting
                romKA <= STD_LOGIC_VECTOR(to_unsigned(looper/2, 4));
                --end address setting
                IF looper = 19 THEN
                    compute_ctrl <= '1';
                    findMinMaxState <= '1';
                    compute_ctrl <= '1';
                ELSE
                    compute_ctrl <= '0';
                    findMinMaxState <= '0';
                    compute_ctrl <= '0';
                END IF;

                looper := looper + 1;

                IF looper = 20 THEN
                    looper := 0;
                    process_id := process_id + 1;
                END IF;

                IF process_id = 4096 THEN
                    current_state <= next_state;
                    next_state <= Display;
                    process_id := 0;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;