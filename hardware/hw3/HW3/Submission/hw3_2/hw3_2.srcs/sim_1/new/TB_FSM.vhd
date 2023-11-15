--LIBRARY IEEE;
--USE IEEE.STD_LOGIC_1164.ALL;

--ENTITY TB_FSM IS
--END TB_FSM;

--ARCHITECTURE BEHAVIORAL OF TB_FSM IS
--    COMPONENT gen_rom IS
--        PORT (
--            CLK : IN STD_ULOGIC;
--            ADDRESS : IN STD_LOGIC_VECTOR(11 DOWNTO 0) := ();
--            FSM_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--        );
--    END COMPONENT;

--    CONSTANT clock_period : TIME := 1 ns;
--    SIGNAL CLK : STD_LOGIC := '0';
--    SIGNAL ADDRESS : STD_LOGIC_VECTOR(11 DOWNTO 0) ;
--    SIGNAL FSM_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
--BEGIN

--    FSM_UUT : gen_rom
--    PORT MAP(
--        CLK => CLK,
--        ADDRESS => ADDRESS,
--        FSM_OUT => FSM_OUT
--    );

--    clock_process : PROCESS
--    BEGIN
--        clk <= '0';
--        WAIT FOR clock_period/2;
--        clk <= '1';
--        WAIT FOR clock_period/2;
--    END PROCESS;
--END BEHAVIORAL;