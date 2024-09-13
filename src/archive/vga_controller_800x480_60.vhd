------------------------------------------------------------------------
-- vga_controller_800x480_60.vhd
------------------------------------------------------------------------

-- This module generates the video synch pulses for the monitor to
-- enter 800x400@60Hz resolution state. It also provides horizontal
-- and vertical counters for the currently displayed pixel and a blank
-- signal that is active when the pixel is not inside the visible screen
-- and the color outputs should be reset to 0.

-- timing diagram for the horizontal synch signal (HS)
-- 0    HSW  HBP_END                        HFP_BEGIN   HMAX (pixels)
-- |----|-------|------------------------------|---------|
-- |----|________________________________________________

-- timing diagram for the vertical synch signal (VS)
-- 0    VSW  VBP_END                        VFP_BEGIN   VMAX (lines)
-- |----|-------|------------------------------|---------|
-- |----|________________________________________________

-- The blank signal is delayed one pixel clock period from where
-- the pixel leaves the visible screen, according to the counters, to
-- account for the pixel pipeline delay. This delay happens because
-- it takes time from when the counters indicate current pixel should
-- be displayed to when the color data actually arrives at the monitor
-- pins (memory read delays, synchronization delays).
------------------------------------------------------------------------
--  Port definitions
------------------------------------------------------------------------
-- rst               - global reset signal
-- pixel_clk         - input pin, from clocking wizard
--                   - Frequency of 30.000 MHz.
-- HS                - output pin, to monitor
--                   - horizontal synch pulse
-- VS                - output pin, to monitor
--                   - vertical synch pulse
-- hcount            - output pin, VECTOR_WIDTH bits, to clients
--                   - horizontal count of the currently displayed
--                   - pixel (even if not in visible area)
-- vcount            - output pin, VECTOR_WIDTH bits, to clients
--                   - vertical count of the currently active video
--                   - line (even if not in visible area)
-- blank             - output pin, to clients
--                   - active when pixel is not in visible area.
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.video_package_800x480.all;

-- the vga_controller_800x480_60 entity declaration
-- read above for behavioral description and port definitions.
entity vga_controller_800x480_60 is
    port(
        rst         : in std_logic;
        pixel_clk   : in std_logic;

        HS          : out std_logic;
        VS          : out std_logic;
        VDE         : out std_logic;
        hcount      : out std_logic_vector(VECTOR_WIDTH downto 0);
        vcount      : out std_logic_vector(VECTOR_WIDTH downto 0);
        blank       : out std_logic
    );
end vga_controller_800x480_60;

architecture Behavioral of vga_controller_800x480_60 is

------------------------------------------------------------------------
-- CONSTANTS
------------------------------------------------------------------------
-- -- vector width
-- constant VECTOR_WIDTH : integer :=10;
-- -- maximum value for the horizontal pixel counter
-- constant HMAX  : std_logic_vector(VECTOR_WIDTH downto 0) := "01111100000"; -- 992
-- -- maximum value for the vertical pixel counter
-- constant VMAX  : std_logic_vector(VECTOR_WIDTH downto 0) := "00110100100"; -- 420
-- total number of visible columns
-- constant HLINES: std_logic_vector(VECTOR_WIDTH downto 0) := "01100100000"; -- 800
-- value for the horizontal counter where front porch ends
-- constant HFP   : std_logic_vector(VECTOR_WIDTH downto 0) := "01100111000"; -- 824
-- value for the horizontal counter where the synch pulse ends
-- constant HSP   : std_logic_vector(VECTOR_WIDTH downto 0) := "01110000000"; -- 896
-- -- total number of visible lines
-- constant VLINES: std_logic_vector(VECTOR_WIDTH downto 0) := "00110010000"; -- 400
-- -- value for the vertical counter where the front porch ends
-- constant VFP   : std_logic_vector(VECTOR_WIDTH downto 0) := "00110010011"; -- 403
-- -- value for the vertical counter where the synch pulse ends
-- constant VSP   : std_logic_vector(VECTOR_WIDTH downto 0) := "00110011101"; -- 413
-- -- HS WIDTH
-- constant HS_WIDTH : std_logic_vector(VECTOR_WIDTH downto 0) := "00000101000"; --  72
-- VS WIDTH
-- constant VS_WIDTH : std_logic_vector(VECTOR_WIDTH downto 0) := "00000000101"; --  10
-- -- HBP_END 
-- constant HBP_END : std_logic_vector(VECTOR_WIDTH downto 0) := "00100000100"; --  168
-- -- HFP_BEGIN 
-- constant HFP_BEGIN : std_logic_vector(VECTOR_WIDTH downto 0) := "11000000100"; --  968
-- -- VBP_END
-- constant VBP_END : std_logic_vector(VECTOR_WIDTH downto 0) := "00000011001"; --  17
-- -- VFP_BEGIN 
-- constant VFP_BEGIN : std_logic_vector(VECTOR_WIDTH downto 0) := "01011101001"; --  417
-- -- polarity of the horizontal and vertical synch pulse
-- -- only one polarity used, because for this resolution they coincide.
-- constant SPP   : std_logic := '1';

------------------------------------------------------------------------
-- SIGNALS
------------------------------------------------------------------------

-- horizontal and vertical counters
signal hcounter : std_logic_vector(VECTOR_WIDTH downto 0) := (others => '0');
signal vcounter : std_logic_vector(VECTOR_WIDTH downto 0) := (others => '0');

-- active when inside visible screen area.
signal video_enable: std_logic;

begin

    -- output horizontal and vertical counters
    hcount <= hcounter;
    vcount <= vcounter;

    -- blank is active when outside screen visible area
    -- color output should be blacked (put on 0) when blank in active
    -- blank is delayed one pixel clock period from the video_enable
    -- signal to account for the pixel pipeline delay.
    blank <= not video_enable when rising_edge(pixel_clk);

    -- increment horizontal counter at pixel_clk rate
    -- until HMAX is reached, then reset and keep counting
    h_count: process(pixel_clk)
    begin
        if(rising_edge(pixel_clk)) then
            if(rst = '1') then
                hcounter <= (others => '0');
            elsif(hcounter = HMAX) then
                hcounter <= (others => '0');
            else
                hcounter <= hcounter + 1;
            end if;
        end if;
    end process h_count;

    -- increment vertical counter when one line is finished
    -- (horizontal counter reached HMAX)
    -- until VMAX is reached, then reset and keep counting
    v_count: process(pixel_clk)
    begin
        if(rising_edge(pixel_clk)) then
            if(rst = '1') then
                vcounter <= (others => '0');
            elsif(hcounter = HMAX) then
                if(vcounter = VMAX) then
                    vcounter <= (others => '0');
                else
                    vcounter <= vcounter + 1;
                end if;
            end if;
        end if;
    end process v_count;

    -- generate horizontal synch pulse
    -- when horizontal counter is between where the
    -- front porch ends and the synch pulse ends.
    -- The HS is active (with polarity SPP) for a total of HSW pixels.
    do_hs: process(pixel_clk)
    begin
        if(rising_edge(pixel_clk)) then
            if(hcounter >= 0 and hcounter < HS_WIDTH) then
                HS <= SPP;
            else
                HS <= not SPP;
            end if;
        end if;
    end process do_hs;

    -- generate vertical synch pulse
    -- when vertical counter is between where the
    -- front porch ends and the synch pulse ends.
    -- The VS is active (with polarity SPP) for a total of VSW video lines
     do_vs: process(pixel_clk)
    begin
        if(rising_edge(pixel_clk)) then
            if(vcounter >= 0 and vcounter < VS_WIDTH) then
                VS <= SPP;
            else
                VS <= not SPP;
            end if;
        end if;
    end process do_vs;

    -- enable video output when pixel is in visible area
    video_enable <= '1' when ((hcounter >= HBP_END) and (hcounter < HFP_BEGIN) and (vcounter >= VBP_END) and (vcounter < VFP_BEGIN)) else '0';
    VDE <= video_enable;
    
end Behavioral;
