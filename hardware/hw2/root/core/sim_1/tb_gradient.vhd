LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_root IS
END tb_root;

ARCHITECTURE Behavioral OF tb_root IS

    COMPONENT rom IS
        PORT (
            a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ram
        PORT (
            a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            clk : IN STD_LOGIC;
            we : IN STD_LOGIC;
            spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Clock period definitions
    SIGNAL clock : STD_LOGIC := '0';
    CONSTANT clock_period : TIME := 1 ns;
    SIGNAL i : INTEGER := 0;

    -- Signals
    -- rom
    SIGNAL rom_rdaddress : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- ram
    SIGNAL ram_rdaddress : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ram_in_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram_out_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram_write_enable : STD_LOGIC := '1';
    SIGNAL ram_clock : STD_LOGIC;

    -- logic
    SIGNAL clock_cycle : INTEGER := 0;
    -- signal curr : std_logic_vector (7 downto 0);
    -- signal prev : std_logic_vector (7 downto 0);
    -- signal nxt : std_logic_vector (7 downto 0);
    SIGNAL gradient_w : STD_LOGIC_VECTOR (7 DOWNTO 0);
    -- logic values

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
        VARIABLE curr_val : INTEGER;
        VARIABLE prev_val : INTEGER;
        VARIABLE nxt_val : INTEGER;
        VARIABLE gradient : INTEGER;

    BEGIN
        IF (rising_edge(ram_clock)) THEN

            IF (i < 65537) THEN
                IF (i = 0) THEN
                    rom_rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 16));
                    nxt_val := to_integer(unsigned(rom_data));
                    -- report "Next Value: " & integer'image(nxt_val);
                ELSE
                    rom_rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 16));
                    prev_val := curr_val;
                    curr_val := nxt_val;
                    nxt_val := to_integer(unsigned(rom_data));
                    -- report "i is: " & integer'image(i) & " Curr Value: " & integer'image(curr_val) & " Next Value: " & integer'image(nxt_val);
                    -- report "Gradient Before " & integer'image(gradient);
                    IF (((i - 1) MOD 256) = 0) THEN
                        gradient := (-2) * curr_val + nxt_val;
                        IF (gradient < 0) THEN
                            gradient := 0;
                        ELSIF (gradient > 255) THEN
                            gradient := 255;
                        ELSE
                            gradient := gradient;
                        END IF;
                    ELSIF ((i MOD 256) = 0) THEN
                        gradient := (-2) * curr_val + prev_val;
                        IF (gradient < 0) THEN
                            gradient := 0;
                        ELSIF (gradient > 255) THEN
                            gradient := 255;
                        ELSE
                            gradient := gradient;
                        END IF;
                    ELSE
                        gradient := prev_val + (-2) * curr_val + nxt_val;
                        IF (gradient < 0) THEN
                            gradient := 0;
                        ELSIF (gradient > 255) THEN
                            gradient := 255;
                        ELSE
                            gradient := gradient;
                        END IF;
                    END IF;
                    gradient_w <= STD_LOGIC_VECTOR(to_unsigned(gradient, 8));
                    ram_rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i - 1, 16));
                    ram_in_data <= gradient_w;
                END IF;
                i <= i + 1;
            END IF;
        END IF;
    END PROCESS;
END;

