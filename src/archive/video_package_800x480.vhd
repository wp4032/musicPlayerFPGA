-- Package Declartion Section
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package video_package_800x480 is
-- vector width
constant VECTOR_WIDTH : integer :=10;
-- maximum value for the horizontal pixel counter
constant HMAX  : std_logic_vector(VECTOR_WIDTH downto 0) := "01110100000"; -- 928
-- maximum value for the vertical pixel counter
constant VMAX  : std_logic_vector(VECTOR_WIDTH downto 0) := "01000001101"; -- 525
-- total number of visible columns
constant HLINES: std_logic_vector(VECTOR_WIDTH downto 0) := "01100100000"; -- 800
-- value for the horizontal counter where front porch ends
constant HFP   : std_logic_vector(VECTOR_WIDTH downto 0) := "01101001000"; -- 840
-- value for the horizontal counter where the synch pulse ends
constant HSP   : std_logic_vector(VECTOR_WIDTH downto 0) := "01101001000"; -- 840
-- total number of visible lines
constant VLINES: std_logic_vector(VECTOR_WIDTH downto 0) := "00111100000"; -- 480
-- value for the vertical counter where the front porch ends
constant VFP   : std_logic_vector(VECTOR_WIDTH downto 0) := "00111101101"; -- 493
-- value for the vertical counter where the synch pulse ends
constant VSP   : std_logic_vector(VECTOR_WIDTH downto 0) := "00111110000"; -- 496
-- HS WIDTH
constant HS_WIDTH : std_logic_vector(VECTOR_WIDTH downto 0) := "00000110000"; --  48
-- VS WIDTH
constant VS_WIDTH : std_logic_vector(VECTOR_WIDTH downto 0) := "00000000011"; --  3
-- HBP_END 
constant HBP_END : std_logic_vector(VECTOR_WIDTH downto 0) := "00001011000"; --  88
-- HFP_BEGIN 
constant HFP_BEGIN : std_logic_vector(VECTOR_WIDTH downto 0) := "01101111000"; --  888
-- VBP_END
constant VBP_END : std_logic_vector(VECTOR_WIDTH downto 0) := "00000100000"; --  32
-- VFP_BEGIN 
constant VFP_BEGIN : std_logic_vector(VECTOR_WIDTH downto 0) := "01000000000"; --  512
-- polarity of the horizontal and vertical synch pulse
-- only one polarity used, because for this resolution they coincide.
constant SPP   : std_logic := '1';
-- object dimension
constant OBJ_HEIGHT : integer := 20;
constant OBJ_WIDTH : integer := 20;
-- border size
constant BORDER_WIDTH : integer := 30;
constant BORDER_HEIGHT : integer := 20;

end package video_package_800x480;
