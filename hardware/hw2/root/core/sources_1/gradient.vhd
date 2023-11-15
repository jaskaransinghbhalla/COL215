LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY gradient IS
    PORT (
        data_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    );
END gradient;

ARCHITECTURE behavioral OF main_tb IS
    uut : PORTMAP()

    -- Clock period definitions
    SIGNAL clock : STD_LOGIC := '0';
    CONSTANT clock_period : TIME := 1 ns;
    SIGNAL i : INTEGER := 0;

    -- Signals

    -- logic
    SIGNAL clock_cycle : INTEGER := 0;
    SIGNAL curr : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL prev : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL nxt : STD_LOGIC_VECTOR (7 DOWNTO 0);

    -- logic values
    SIGNAL curr_val : INTEGER;
    SIGNAL prev_val : INTEGER;
    SIGNAL nxt_val : INTEGER;
    SIGNAL gradient : INTEGER;

BEGIN

    rom_uut : rom PORT MAP(
        a => rom_rdaddress,
        spo => rom_data
    );

    ram_uut : ram PORT MAP(
        a => ram_rdaddress,
        d => ram_in_data,
        spo => ram_out_data,
        clk => ram_clock,
        we => ram_write_enable
    );

    -- Clock process definitions
    clock_process : PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR clock_period/2;
        clock <= '1';
        WAIT FOR clock_period/2;
    END PROCESS;

    -- Stimulus process
    ram_clock <= clock;
    stim_proc : PROCESS (ram_clock)
        VARIABLE temp : INTEGER;
    BEGIN
        IF (rising_edge(ram_clock)) THEN
            IF (clock_cycle = 0) THEN
                -- CODE HERE
                IF (i < 65536) THEN
                    IF (i = 0) THEN
                        rom_rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 16));
                        nxt <= rom_data;
                        nxt_val <= to_integer(unsigned(nxt));
                        --i <= i + 1;
                    ELSE
                        rom_rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 16));
                        prev <= curr;
                        prev_val <= curr_val;
                        curr <= nxt;
                        curr_val <= nxt_val;
                        nxt <= rom_data;
                        nxt_val <= to_integer(unsigned(nxt));
                        -- Case 1 Left Column
                        IF ((i - 1) MOD 256 = 0) THEN
                            -- temp := (-2)*curr_val + nxt_val;
                            IF ((-2) * curr_val + nxt_val < 0) THEN
                                gradient <= 0;
                            ELSIF ((-2) * curr_val + nxt_val > 255) THEN
                                gradient <= 255;
                            ELSE
                                gradient <= (-2) * curr_val + nxt_val;
                            END IF;
                            --i <= i + 1;
                        ELSIF (i MOD 256 = 0) THEN
                            IF ((-2) * curr_val + prev_val < 0) THEN
                                gradient <= 0;
                            ELSIF ((-2) * curr_val + prev_val > 255) THEN
                                gradient <= 255;
                            ELSE
                                gradient <= (-2) * curr_val + prev_val;
                            END IF;
                            --i <= i + 1;
                        ELSE
                            IF (prev_val + (-2) * curr_val + nxt_val < 0) THEN
                                gradient <= 0;
                            ELSIF (prev_val + (-2) * curr_val + nxt_val > 255) THEN
                                gradient <= 255;
                            ELSE
                                gradient <= prev_val + (-2) * curr_val + nxt_val;
                            END IF;
                        END IF;
                    END IF;
                    i <= i + 1;
                END IF;

                clock_cycle <= clock_cycle + 1;
            ELSIF (clock_cycle = 1) THEN
                clock_cycle <= clock_cycle + 1;
            ELSIF (clock_cycle = 2) THEN
                clock_cycle <= 0;
            END IF;
        END IF;
    END PROCESS;
END;