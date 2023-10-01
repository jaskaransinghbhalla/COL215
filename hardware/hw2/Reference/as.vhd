library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

ENTITY input_ROM IS
END input_ROM;

ARCHITECTURE behavior OF input_ROM IS
    COMPONENT dist_mem_gen_2
    PORT (
        a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT dist_mem_gen_1
    PORT (
        clk : IN STD_LOGIC;
        a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        we : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    signal rdaddress : std_logic_vector(15 downto 0) := (others => '0');
    signal rdaddress_prv : std_logic_vector(15 downto 0) := (others => '0');
    signal rdaddress_nxt : std_logic_vector(15 downto 0) := (others => '0');
    signal data : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out : std_logic_vector(7 downto 0) := (others => '0');
    signal data_prv : std_logic_vector(7 downto 0) := (others => '0');
    signal data_nxt : std_logic_vector(7 downto 0) := (others => '0');
    signal i : integer := 0;
    signal res_pixel : std_logic_vector(7 downto 0) := (others => '0');
    signal write_enable : std_logic := '0';
    signal clock : std_logic := '0';
    constant clock_period : time := 20 ns;

BEGIN
    uut : dist_mem_gen_2 PORT MAP (
        spo => data,
        a => rdaddress
    );

    uut_prv : dist_mem_gen_2 PORT MAP (
        spo => data_prv,
        a => rdaddress_prv
    );

    uut_nxt : dist_mem_gen_2 PORT MAP (
        spo => data_nxt,
        a => rdaddress_nxt
    );

    uut_out : dist_mem_gen_1 PORT MAP (
        clk => clock,
        spo => data_out,
        a => rdaddress,
        we => write_enable,
        d => res_pixel
    );

    clock_process : process
    begin
        while true loop
            clock <= not clock;
            wait for clock_period/2;
        end loop;
    end process clock_process;

    p1 : process
        variable t0 : std_logic_vector(7 downto 0) := (others => '0');
        variable t1 : std_logic_vector(7 downto 0) := (others => '0');
        variable t2 : std_logic_vector(7 downto 0) := (others => '0');
        variable t0_int : integer;
        variable result : integer;
    begin
        for i in 0 to 65535 loop
            rdaddress <= std_logic_vector(to_unsigned(i, 16));
            rdaddress_nxt <= std_logic_vector(to_unsigned((i + 1) mod 65535, 16));
            rdaddress_prv <= std_logic_vector(to_unsigned(((i - 1) + 65535) mod 65535, 16));

            -- Wait for a rising clock edge
            wait until rising_edge(clock);

            if i mod 256 = 0 then
                t1 := data_nxt;
            elsif (i + 1) mod 256 = 0 then
                t2 := data_prv;
            else
                t1 := data_nxt;
                t2 := data_prv;
            end if;

            t0 := data;
            t0_int := to_integer(unsigned(t0));
            result := to_integer(unsigned(t1)) + to_integer(unsigned(t2)) - (2 * t0_int);

            if result < 0 then
                result := 0;
            elsif result > 255 then
                result := 255;
            end if;

            write_enable <= '1';

            -- Wait for a rising clock edge
            wait until rising_edge(clock);

            res_pixel <= std_logic_vector(to_unsigned(result, 8));
            write_enable <= '0';

            -- Wait for a rising clock edge
            wait until rising_edge(clock);
        end loop;
        wait;
    end process p1;
end behavior;