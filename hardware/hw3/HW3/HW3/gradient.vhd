LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY gradient IS
    -- PORT (
    -- clk : IN STD_LOGIC
    -- );
END gradient;

ARCHITECTURE Behavioral OF gradient IS
    -- -----------------------------------------------------------------------------------------------------------
    -- SIGNALS
    -- -----------------------------------------------------------------------------------------------------------

    -- ROM
    SIGNAL rom_address : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- RAM
    SIGNAL we : STD_LOGIC := '0';
    SIGNAL ram_data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_data_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_address : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');

    SIGNAL filter_rom_address : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL filter_rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL filter_ready : STD_LOGIC := '0';
    -- CLOCK
    CONSTANT clock_period : TIME := 1 ns;
    SIGNAL clk : STD_LOGIC := '0';
    -- GRADIENT
    SIGNAL f, g, v, g2, ng : INTEGER;
    SIGNAL i, j : INTEGER := 0;
    SIGNAL counter : INTEGER := 0;
    SIGNAL counter_2 : INTEGER := 0;
    SIGNAL min_v : INTEGER := 2147483647; -- Positive infinity
    SIGNAL max_v : INTEGER := - 2147483648; -- Negative infinity
    SIGNAL trig_normalize : STD_LOGIC := '0';
    -- SIGNAL f1, f2, f3, f4, f5, f6, f7, f8, f9 : INTEGER := 0;
    -- -----------------------------------------------------------------------------------------------------------
    -- COMPONENTS
    -- -----------------------------------------------------------------------------------------------------------

    -- ROM
    COMPONENT gen_rom
        PORT (
            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT filter_rom
        PORT (
            a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT gen_ram
        PORT (
            clk : IN STD_LOGIC;
            a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
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

    uut_filter_rom : filter_rom
    PORT MAP(
        a => filter_rom_address,
        spo => filter_rom_data
    );

    clock_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clock_period/2;
        clk <= '1';
        WAIT FOR clock_period/2;
    END PROCESS;

    f <= TO_INTEGER(SIGNED(filter_rom_data));
    v <= TO_INTEGER(UNSIGNED(rom_data));
    ram_data_in <=  STD_LOGIC_VECTOR(TO_UNSIGNED(ng, 8));
    root_process : PROCESS (clk)
        -- VARIABLE counter : INTEGER := - 1;
        VARIABLE f1, f2, f3, f4, f5, f6, f7, f8, f9 : INTEGER := 0;
        VARIABLE v1, v2, v3, v4, v5, v6, v7, v8, v9 : INTEGER := 0;
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF (trig_normalize = '0') THEN
                IF counter = 21 THEN
                    counter <= 0;
                    filter_ready <= '1';
                ELSE
                    counter <= counter + 1;
                END IF;

                IF (filter_ready = '0') THEN
                    IF (counter < 19) THEN
                        IF (counter = 1) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4));
                        ELSIF (counter = 2) THEN
                            f1 := f;
                        ELSIF (counter = 3) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(1, 4));
                        ELSIF (counter = 4) THEN
                            f2 := f;
                        ELSIF (counter = 5) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(2, 4));
                        ELSIF (counter = 6) THEN
                            f3 := f;
                        ELSIF (counter = 7) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(3, 4));
                        ELSIF (counter = 8) THEN
                            f4 := f;
                        ELSIF (counter = 9) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(4, 4));
                        ELSIF (counter = 10) THEN
                            f5 := f;
                        ELSIF (counter = 11) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(5, 4));
                        ELSIF (counter = 12) THEN
                            f6 := f;
                        ELSIF (counter = 13) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(6, 4));
                        ELSIF (counter = 14) THEN
                            f7 := f;
                        ELSIF (counter = 15) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(7, 4));
                        ELSIF (counter = 16) THEN
                            f8 := f;
                        ELSIF (counter = 17) THEN
                            filter_rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(8, 4));
                        ELSIF (counter = 18) THEN
                            f9 := f;
                        END IF;
                    ELSE
                        IF (counter = 19) THEN
                            -- filter_rom_address <= (OTHERS => '0');
                        END IF;
                    END IF;
                END IF;

                IF (filter_ready = '1') THEN
                    IF (i < 4096) THEN
                        IF (counter = 1) THEN
                            IF (i >= 65 AND (i MOD 64) /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i - 65, 12));
                            END IF;
                        ELSIF (counter = 2) THEN
                            IF (i >= 65 AND (i MOD 64) /= 0) THEN
                                v1 := v;
                            ELSE
                                v1 := 0;
                            END IF;
                        ELSIF (counter = 3) THEN
                            IF (i >= 64) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i - 64, 12));
                            END IF;
                        ELSIF (counter = 4) THEN
                            IF (i >= 64) THEN
                                v2 := v;
                            ELSE
                                v2 := 0;
                            END IF;
                        ELSIF (counter = 5) THEN
                            IF (i >= 63 AND (i + 1) MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i - 63, 12));
                            END IF;
                        ELSIF (counter = 6) THEN
                            IF (i >= 63 AND (i + 1) MOD 64 /= 0) THEN
                                v3 := v;
                            ELSE
                                v3 := 0;
                            END IF;
                        ELSIF (counter = 7) THEN
                            IF (i >= 1 AND i MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i - 1, 12));
                            END IF;
                        ELSIF (counter = 8) THEN
                            IF (i >= 1 AND i MOD 64 /= 0) THEN
                                v4 := v;
                            ELSE
                                v4 := 0;
                            END IF;
                        ELSIF (counter = 9) THEN
                            IF (i >= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 12));
                            END IF;
                        ELSIF (counter = 10) THEN
                            IF (i >= 0) THEN
                                v5 := v;
                            ELSE
                                v5 := 0;
                            END IF;
                        ELSIF (counter = 11) THEN
                            IF ((i + 1) MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 1, 12));
                            END IF;
                        ELSIF (counter = 12) THEN
                            IF ((i + 1) MOD 64 /= 0) THEN
                                v6 := v;
                            ELSE
                                v6 := 0;
                            END IF;
                        ELSIF (counter = 13) THEN
                            IF (i MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 63, 12));
                            END IF;
                        ELSIF (counter = 14) THEN
                            IF (i MOD 64 /= 0) THEN
                                v7 := v;
                            ELSE
                                v7 := 0;
                            END IF;
                        ELSIF (counter = 15) THEN
                            IF (i + 64 < 4096) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 64, 12));
                            END IF;
                        ELSIF (counter = 16) THEN
                            IF (i + 64 < 4096) THEN
                                v8 := v;
                            ELSE
                                v8 := 0;
                            END IF;
                        ELSIF (counter = 17) THEN
                            IF ((i + 1) MOD 64 /= 0 AND (i + 65) < 4096) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 65, 12));
                            END IF;
                        ELSIF (counter = 18) THEN
                            IF ((i + 1) MOD 64 /= 0 AND (i + 65) < 4096) THEN
                                v9 := v;
                            ELSE
                                v9 := 0;
                            END IF;
                        ELSIF (counter = 19) THEN
                            rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 12));
                            g <= v1 * f1 + v2 * f2 + v3 * f3 + v4 * f4 + v5 * f5 + v6 * f6 + v7 * f7 + v8 * f8 + v9 * f9;
                               i <= i + 1;
                        ELSIF (counter = 20) THEN
                            IF (g > max_v) THEN
                                max_v <= g;
                            END IF;
                            IF (g < min_v) THEN
                                min_v <= g;
                            END IF;
--                            i <= i + 1;
                        END IF;
                    ELSE
                        trig_normalize <= '1';
                        counter <= 0;
                        v1 := 0;
                        v2 := 0;
                        v3 := 0;
                        v4 := 0;
                        v5 := 0;
                        v6 := 0;
                        v7 := 0;
                        v8 := 0;
                        v9 := 0;
                    END IF;
                END IF;
            ELSE

            END IF;
        END IF;

        IF (clk'event AND clk = '1') THEN
            IF (trig_normalize = '1') THEN
                IF counter_2 = 24 THEN
                    counter_2 <= 0;
                    filter_ready <= '1';
                ELSE
                    counter_2 <= counter_2 + 1;
                END IF;

                IF (filter_ready = '1') THEN
                    IF (j < 4096) THEN
                        IF (counter_2 = 1) THEN
                            IF (j >= 65 AND (j MOD 64) /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j - 65, 12));
                            END IF;
                        ELSIF (counter_2 = 2) THEN
                            IF (j >= 65 AND (j MOD 64) /= 0) THEN
                                v1 := v;
                            ELSE
                                v1 := 0;
                            END IF;
                        ELSIF (counter_2 = 3) THEN
                            IF (j >= 64) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j - 64, 12));
                            END IF;
                        ELSIF (counter_2 = 4) THEN
                            IF (j >= 64) THEN
                                v2 := v;
                            ELSE
                                v2 := 0;
                            END IF;
                        ELSIF (counter_2 = 5) THEN
                            IF (j >= 63 AND (j + 1) MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j - 63, 12));
                            END IF;
                        ELSIF (counter_2 = 6) THEN
                            IF (j >= 63 AND (j + 1) MOD 64 /= 0) THEN
                                v3 := v;
                            ELSE
                                v3 := 0;
                            END IF;
                        ELSIF (counter_2 = 7) THEN
                            IF (j >= 1 AND j MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j - 1, 12));
                            END IF;
                        ELSIF (counter_2 = 8) THEN
                            IF (j >= 1 AND j MOD 64 /= 0) THEN
                                v4 := v;
                            ELSE
                                v4 := 0;
                            END IF;
                        ELSIF (counter_2 = 9) THEN
                            IF (j >= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 12));
                            END IF;
                        ELSIF (counter_2 = 10) THEN
                            IF (j >= 0) THEN
                                v5 := v;
                            ELSE
                                v5 := 0;
                            END IF;
                        ELSIF (counter_2 = 11) THEN
                            IF ((j + 1) MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j + 1, 12));
                            END IF;
                        ELSIF (counter_2 = 12) THEN
                            IF ((j + 1) MOD 64 /= 0) THEN
                                v6 := v;
                            ELSE
                                v6 := 0;
                            END IF;
                        ELSIF (counter_2 = 13) THEN
                            IF (j MOD 64 /= 0) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j + 63, 12));
                            END IF;
                        ELSIF (counter_2 = 14) THEN
                            IF (j MOD 64 /= 0) THEN
                                v7 := v;
                            ELSE
                                v7 := 0;
                            END IF;
                        ELSIF (counter_2 = 15) THEN
                            IF (j + 64 < 4096) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j + 64, 12));
                            END IF;
                        ELSIF (counter_2 = 16) THEN
                            IF (j + 64 < 4096) THEN
                                v8 := v;
                            ELSE
                                v8 := 0;
                            END IF;
                        ELSIF (counter_2 = 17) THEN
                            IF ((j + 1) MOD 64 /= 0 AND (j + 65) < 4096) THEN
                                rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j + 65, 12));
                            END IF;
                        ELSIF (counter_2 = 18) THEN
                            IF ((j + 1) MOD 64 /= 0 AND (j + 65) < 4096) THEN
                                v9 := v;
                            ELSE
                                v9 := 0;
                            END IF;
                        ELSIF (counter_2 = 19) THEN
                            rom_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 12));
                            -- report "v5: " & integer'image(v5);
                            -- report "v6: " & integer'image(v6);
                            -- report "v7: " & integer'image(v7);
                            -- report "v8: " & integer'image(v8);
                            -- report "v9: " & integer'image(v9);
                            g2 <= v1 * f1 + v2 * f2 + v3 * f3 + v4 * f4 + v5 * f5 + v6 * f6 + v7 * f7 + v8 * f8 + v9 * f9;
                        ELSIF (counter_2 = 20) THEN
                            ng <= ((g2 - min_v) * 255)/(max_v - min_v);
                            we <= '1';
                        ELSIF (counter_2 = 21) THEN
                            ram_address <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 12));
                        ELSIF (counter_2 = 22) THEN
                        ELSIF (counter_2 = 23) THEN
                        ELSIF (counter_2 = 24) THEN
                            j <= j + 1;
                            we <= '0';
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

END behavioral;