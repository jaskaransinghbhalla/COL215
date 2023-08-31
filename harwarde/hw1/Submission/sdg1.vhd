----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 13:35:58
-- Design Name: 
-- Module Name: sdg1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sdg1 is

--  Port ( );
Port (
        a : in STD_LOGIC;
        b : in STD_LOGIC;
        c : in STD_LOGIC;
        d : in STD_LOGIC;
        o1 : out STD_LOGIC;
        o2 : out STD_LOGIC;
        o3 : out STD_LOGIC;
        o4 : out STD_LOGIC;
        o5 : out STD_LOGIC;
        o6 : out STD_LOGIC;
        o7 : out STD_LOGIC;
        m1 : out STD_LOGIC;
        m2 : out STD_LOGIC;
        m3 : out STD_LOGIC;
        m4 : out STD_LOGIC
          );
end sdg1;

architecture Behavioral of sdg1 is
begin
o1 <= not((b and c) or (not a and not b and c) or (a AND NOT c and not d) or (not a and not b and not c and not d) or(not a and b and not c and d) or (a and not b and not c and d) or (a and not b and c and not d));    
o2 <= not((not a and not b) or (not a and b and not c and not d) or ( not a and b and c and d) or (a and not c and d) or (a and not b and not c and not d) or (a and not b and c and not d));
o3 <= not((not a and b) or (a and not b ) or (a and b and not c and d ) or (not a and not b and not c) or (not a and not b and c and d));
o4 <= not((a and not c ) or ( a and not b and c and d ) or ( not a and not b and not c and not d) or ( not a and b and not c and d ) or (not a and not b and c) or (b and c and not d));
o5 <= not((not a and not b and not c and not d) or (a and b ) or (a and not b and not c and not d) or (a and not b and c) or (not a and c and not d));
o6 <= not((a and not b) or (not a and not b and not c and not d) or (not a and b and c and not d) or (a and b and not c and not d) or (not a and b and not c) or (a and b and c));
o7 <= not((a and c) or (a and not c and d) or (not a and b and not c) or (not a and not b and c) or ( a and not b and not c and not d) or ( not a and b and c and not d));
    -- Logic
    m1 <= a or not a;
    m2 <= a or not a;
    m3 <= a or not a;
    m4 <= a and not a; 
end Behavioral;
