library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
  Port (rclk: in std_logic; 
	  HSYNC: out STD_LOGIC;
	  VSYNC: out STD_LOGIC;
	    R0: out STD_LOGIC;
	    R1: out STD_LOGIC;
	    R2: out STD_LOGIC;
	    R3: out STD_LOGIC;
	    B0: out STD_LOGIC;
	    B1: out STD_LOGIC;
	    B2: out STD_LOGIC;
	    B3: out STD_LOGIC;
	    G0: out STD_LOGIC;
	    G1: out STD_LOGIC;
	    G2: out STD_LOGIC;
	    G3: out STD_LOGIC
  
   );
end main;

architecture Behavioral of main is


component HWA2
port(rclk:in std_logic;
enable:in std_logic ;
last_address:out integer;
current_addr: in std_logic_vector(15 downto 0);
pix: out std_logic_vector(7 downto 0));
end component;


component RAM
port(
 clk : in STD_LOGIC ; 
    we : in STD_LOGIC ;
 
    a : in STD_LOGIC_VECTOR( 15 downto 0 ); 
    d : in STD_LOGIC_VECTOR( 7 downto 0 ); 
    spo : out STD_LOGIC_VECTOR( 7 downto 0 )

);
end component;


component VGA
port(
CLK25: in STD_LOGIC;
	pixel_value: in STD_LOGIC_VECTOR(7 downto 0);
		RST: in STD_LOGIC;	
	  HSYNC: out STD_LOGIC;
	  VSYNC: out STD_LOGIC;
	    R0: out STD_LOGIC;
	    R1: out STD_LOGIC;
	    R2: out STD_LOGIC;
	    R3: out STD_LOGIC;
	    B0: out STD_LOGIC;
	    B1: out STD_LOGIC;
	    B2: out STD_LOGIC;
	    B3: out STD_LOGIC;
	    G0: out STD_LOGIC;
	    G1: out STD_LOGIC;
	    G2: out STD_LOGIC;
	    G3: out STD_LOGIC;
	  hPo: out integer;
	  vPo: out integer);

end component;
signal hposition: integer := 0;
signal vposition: integer := 0;
signal clk25 : std_logic :='0';
signal enabler : std_logic:= '1'; 
signal pixel:  std_logic_vector (7 downto 0);
signal flag: integer := 0;
signal l_addr: integer;
signal addra:std_logic_vector(15 downto 0);
signal i:integer :=0;
begin

uut: HWA2 port map(
rclk => rclk, enable => enabler,last_address=> l_addr ,pix => pixel,current_addr=>addra );

uut1:VGA port map(
CLK25 => clk25,
	pixel_value => pixel,
		RST	=>enabler,
	  HSYNC=>HSYNC,
	  VSYNC=>VSYNC,
	    R0=>R0,
	    R1=>R1,
	    R2=>R2,
	    R3=>R3,
	    B0=>B0,
	    B1=>B1,
	    B2=>B2,
	    B3=>B3,
	    G0=>G0,
	    G1=>G1,
	    G2=>G2,
	    G3=>G3,
	  hPo=>hposition,
	  vPo=>vposition);

process(rclk)
begin 
if(rising_edge(rclk)) then 
if(flag = 0) then
clk25 <='1';
flag<= flag +1;
else
flag<=0;
clk25 <='0';
end if;

end if;
end process;

computation: process(rclk)
begin
if(l_addr = 65536) then 
enabler <= '0';
end if;
end process;

display: process(rclk)
begin
if(enabler = '0') then 
if(i<65535) then
if(rising_edge(rclk)) then
addra <= std_logic_vector(to_unsigned(i,16));
i<= i+1;
end if;
end if;
end if;
end process;

end Behavioral;