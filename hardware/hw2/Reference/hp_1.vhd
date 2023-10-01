LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HWA2 is
port(rclk:in std_logic;
enable:in std_logic;
last_address: out integer;
current_addr: in std_logic_vector(15 downto 0);
pix : out std_logic_vector(7 downto 0)

);
end HWA2;

architecture behaviour of HWA2 is

component dist_mem_gen_0
port(
    a : in std_logic_vector(15 downto 0);
    spo: out std_logic_vector(7 downto 0)

   );
end component;

component RAM
port(
    a : in std_logic_vector(15 downto 0);
    d : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    we : in std_logic;
    
    spo : out std_logic_vector(7 downto 0)
    );
end component;

-- := "0000000000000000";
signal address : std_logic_vector(15 downto 0) := "0000000000000000";
signal data : std_logic_vector(7 downto 0) ;
signal i : integer := 0;
signal raddress : std_logic_vector(15 downto 0);
signal rdata : std_logic_vector(7 downto 0) ;
 
signal flag : integer := 0;

signal routdata : std_logic_vector(7 downto 0);

signal cur : std_logic_vector (7 downto 0) ;
signal prv : std_logic_vector (7 downto 0);
signal nxt : std_logic_vector (7 downto 0);

signal curval : integer:=0;
signal prvval : integer:=0;
signal nxtval : integer:=0;
signal dataval : integer:=0;
signal dataval2 : integer:=0;

constant clock_period : time := 1 ns;

begin

uut : dist_mem_gen_0 port map(

a => address, spo => data);

uut1 : RAM port map(
a => raddress , d => rdata, spo => pix , clk => rclk, we => enable);
r_proc: process (rclk)
begin
if(rising_edge (rclk)) then
if(i>0) then
rdata <= std_logic_vector(to_unsigned(dataval2,8));
end if;
end if;
end process;


y_proc : process(rclk)
begin
if(rising_edge  (rclk)) then
if(i>0) then
            if(dataval < 0) then
                dataval2 <= 0;
            elsif(dataval > 255) then
                 dataval2  <= 255;
            else
                dataval2 <= dataval;
            end if;
end if;

end if;
end process;

d_proc : process(rclk)
begin
if(rising_edge(rclk)) then
if(i>0) then
if((i-1)mod 256 = 0 ) then
dataval <= (nxtval - 2*curval);
elsif((i-1)mod 256 = 255 )then           
dataval <= prvval - 2*curval;          
else
 dataval <= prvval + nxtval - 2*curval;
     
end if; 
end if;   
end if;  
end process;       

stim_proc  : process(rclk)
begin
last_address <= i;
if(enable='0') then
raddress <= current_addr;
end if;
if(i < 65536) then  
    if(i = 0) then 
        if(falling_edge (rclk)) then
        address <= std_logic_vector(to_unsigned(0,16));
        cur <= data;

        i <= i + 1;
        end if;
    else
     address <= std_logic_vector(to_unsigned(i,16));
     nxt <=data;  
    
    if(rising_edge(rclk)) then
    
        if(flag = 0) then 
        
        flag <= flag + 1;
        
        elsif (flag = 1) then
        flag <= flag + 1;
        
        elsif (flag = 2) then

         raddress <= std_logic_vector(to_unsigned(i-1,16));
         
         if((i-1)mod 256 = 0 ) then
            curval <= to_integer(unsigned(cur));
            nxtval <= to_integer(unsigned(nxt));
         elsif((i-1)mod 256 = 255 )then
         curval <= to_integer(unsigned(cur));
            prvval <= to_integer(unsigned(prv));
         else
         curval <= to_integer(unsigned(cur));
            nxtval <= to_integer(unsigned(nxt));
            prvval <= to_integer(unsigned(prv));
         end if;
         prv <= cur;
         cur <= nxt;
        i<= i+1;
        flag <= 0;
        end if;
     end if;   
end if;
end if;
end process;
end behaviour;