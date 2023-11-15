LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY gradient IS
    PORT (
        clk : IN STD_LOGIC;
        trig : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        ready : OUT STD_LOGIC
    );
END gradient;

ARCHITECTURE behavioral OF gradient IS
    -- -----------------------------------------------------------------------------------------------------------
    -- SIGNALS
    -- -----------------------------------------------------------------------------------------------------------
    -- ROM
    SIGNAL rom_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    -- RAM
    SIGNAL we : STD_LOGIC := '1';
    SIGNAL ram_data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_data_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    -- GRADIENT
    SIGNAL i : INTEGER := 0;
    SIGNAL prev_val : INTEGER := 0;
    SIGNAL curr_val : INTEGER := 0;
    SIGNAL nxt_val : INTEGER := 0;
    SIGNAL g : INTEGER := 0;
    SIGNAL t : INTEGER := 0;
    SIGNAL add : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
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
    -- RAM
    COMPONENT gen_ram
        PORT (
            clk : IN STD_LOGIC;
            a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            we : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    -- -----------------------------------------------------------------------------------------------------------
    -- PORT MAP
    -- -----------------------------------------------------------------------------------------------------------
    uut_rom : gen_rom
    PORT MAP(
        a => rom_address,
        spo => rom_data
    );
    uut_ram : gen_ram
    PORT MAP(
        clk => clk,
        a => ram_address,
        spo => ram_data_out,
        we => we,
        d => ram_data_in
    );
    -- -----------------------------------------------------------------------------------------------------------
    -- PROCESSES
    -- -----------------------------------------------------------------------------------------------------------
    PROCESS (clk, t)
    BEGIN
        IF t = 20 THEN
            t <= 0;
        ELSIF rising_edge(clk) THEN
            t <= t + 1;
        END IF;
    END PROCESS;
    -- --------------------------------------------------------------------------------------------------------
    data <= ram_data_out;
    gradient_proc : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF t = 18 AND i < 65536 THEN
                i <= i + 1;
                ready <= '0';
            ELSIF i >= 65536 THEN
                we <= '0';
                ready <= '1';
            END IF;

            IF t = 19 THEN
                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 16));
            END IF;

            IF i < 65536 THEN
                we <= '1';
                IF (i MOD 256) = 0 THEN

                    IF t = 3 THEN
                        prev_val <= 0;
                        curr_val <= TO_INTEGER(UNSIGNED(rom_data));
                        rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 1, 16));
                    END IF;

                    IF t = 6 THEN
                        nxt_val <= TO_INTEGER(UNSIGNED(rom_data));
                    END IF;

                    IF t = 7 THEN
                        g <= (prev_val - 2 * curr_val + nxt_val);
                    END IF;

                ELSIF (i MOD 256) = 255 THEN

                    IF t = 3 THEN
                        nxt_val <= 0;
                        curr_val <= TO_INTEGER(UNSIGNED(rom_data));
                        rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i - 1, 16));
                    END IF;

                    IF t = 6 THEN
                        prev_val <= TO_INTEGER(UNSIGNED(rom_data));
                    END IF;

                    IF t = 7 THEN
                        g <= (prev_val - 2 * curr_val + nxt_val);
                    END IF;

                ELSE

                    IF t = 3 THEN
                        curr_val <= TO_INTEGER(UNSIGNED(rom_data));
                        rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i - 1, 16));
                    END IF;

                    IF t = 6 THEN
                        prev_val <= TO_INTEGER(UNSIGNED(rom_data));
                    END IF;

                    IF t = 7 THEN
                        rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 1, 16));
                    END IF;

                    IF t = 10 THEN
                        nxt_val <= TO_INTEGER(UNSIGNED(rom_data));
                    END IF;

                    IF t = 11 THEN
                        g <= (prev_val - 2 * curr_val + nxt_val);
                    END IF;
                END IF;

                IF t = 12 THEN
                    IF g >= 255 THEN
                        add <= x"FF";
                    ELSIF g < 0 THEN
                        add <= x"00";
                    ELSE
                        add <= STD_LOGIC_VECTOR(TO_UNSIGNED(g, 8));
                    END IF;
                END IF;

                IF t = 13 THEN
                    ram_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 16));
                END IF;

                IF t = 16 THEN
                    ram_data_in <= add;
                END IF;

            ELSE
                we <= '0';
                ready <= '1';
                IF (trig = '1') THEN
                    ram_address <= address;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    -- --------------------------------------------------------------------------------------------------------
END behavioral;