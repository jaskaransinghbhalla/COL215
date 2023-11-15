LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY tb_mac IS
END tb_mac;
ARCHITECTURE Behavioral OF tb_mac IS
    CONSTANT clock_period : TIME := 1 ns;
    SIGNAL tb_clk : STD_LOGIC := '0';
    SIGNAL tb_input_val : STD_LOGIC_VECTOR(7 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(10, 8));
    SIGNAL tb_kernel : STD_LOGIC_VECTOR(7 DOWNTO 0) := STD_LOGIC_VECTOR(to_signed(3, 8));
    SIGNAL tb_ctrl : STD_LOGIC := '1';
    SIGNAL tb_rst : STD_LOGIC := '0';
    SIGNAL tb_result : INTEGER;
    COMPONENT mac
        PORT (
            clk : IN STD_LOGIC;
            input_val : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            kernel : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ctrl : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            result : OUT INTEGER
        );
    END COMPONENT;
BEGIN
    uut : mac
    PORT MAP(
        clk => tb_clk,
        input_val => tb_input_val,
        kernel => tb_kernel,
        ctrl => tb_ctrl,
        rst => tb_rst,
        result => tb_result
    );
    clock_process : PROCESS
    BEGIN
        tb_clk <= '0';
        WAIT FOR clock_period/2;
        tb_clk <= '1';
        WAIT FOR clock_period/2;
    END PROCESS;
END Behavioral;