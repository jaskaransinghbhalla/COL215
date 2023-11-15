LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY tb_rom IS
END tb_rom;

ARCHITECTURE behavioral OF tb_rom IS

    COMPONENT rom_new PORT (
        a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clock : STD_LOGIC := '0';
    SIGNAL rom_rdaddress : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

    -- Clock period definitions
    CONSTANT clock_period : TIME := 10 ns;
    SIGNAL i : INTEGER;

BEGIN

    uut : rom PORT MAP(
        spo => rom_data,
        a => rom_rdaddress
    );

    test_proc : PROCESS
    begin
        clock <= '0';
        WAIT FOR clock_period/2;
        clock <= '1';
        WAIT FOR clock_period/2;
    END PROCESS;

    -- Stimulus process stim_proc: process begin
    rom_proc : PROCESS
    begin
        FOR i IN 0 TO 65535 LOOP
            rdaddress <= STD_LOGIC_VECTOR(to_unsigned(i, 16));
            WAIT FOR 20 ns;
        END LOOP;
        WAIT;
    END PROCESS;
END behavioral;