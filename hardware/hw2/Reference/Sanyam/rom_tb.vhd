
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
ENTITY rom_tb IS
END rom_tb;
ARCHITECTURE behavior OF rom_tb IS
COMPONENT dist_mem_gen_0
PORT(
clk : IN STD_LOGIC;
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
BEGIN
-- Read image in VHDL
uut: dist_mem_gen_0 PORT MAP (
clk => clock,
spo => data,
a => rdaddress
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
        wait for 1 ns;
    end loop;
    wait;
end process;
END;