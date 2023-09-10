-- Our Code
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity main_tb is
end main_tb;
architecture Behavioral of main_tb is

-- ROM
COMPONENT rom
PORT(
a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

--Inputs
signal clock : std_logic := '0';
signal rdaddress : std_logic_vector(15 downto 0) := (others => '0');

--Outputs
signal data : std_logic_vector(7 downto 0) := (others => '0');

-- Clock period definitions
constant clock_period : time := 10 ns;
signal i: integer;

-- RAM
COMPONENT ram
PORT(
a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
we : IN STD_LOGIC;
clk : IN STD_LOGIC;
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

-- RAM Signals
signal ram_rdaddress : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal ram_d : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal ram_data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal ram_we : STD_LOGIC := '1';



BEGIN
-- Read image in VHDL
uut: rom PORT MAP (
spo => data,
a => rdaddress
);

ult: ram PORT MAP (
a => ram_rdaddress,
d => ram_d,
spo => ram_data, 
clk => clock,
we => ram_we
);

-- Clock process definitions
clock_process :process
begin
clock <= '0';
wait for clock_period/2;
clock <= '1';
wait for clock_period/2;
end process;

-- Stimulus process
stim_proc: process
begin
for i in 0 to 65535 loop
 rdaddress <= std_logic_vector(to_unsigned(i, 16));
-- ram_rdaddress <= std_logic_vector(to_unsigned(i, 16));
wait for 5 ns;
end loop;
wait;
end process;
END;