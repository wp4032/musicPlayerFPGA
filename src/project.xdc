## This file is a general .xdc for the PYNQ-Z2 board 
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal 125 MHz

set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { sysclk }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sysclk }];

##Switches

#set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; #IO_L7N_T1_AD2N_35 Sch=sw[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L7P_T1_AD2P_35 Sch=sw[1]

##RGB LEDs

set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { leds_rgb_0[0] }]; 
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { leds_rgb_0[1] }]; 
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { leds_rgb_0[2] }]; 
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { leds_rgb_1[0] }];
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { leds_rgb_1[1] }]; 
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { leds_rgb_1[2] }]; 

##LEDs

set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=led[0]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=led[1]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=led[2]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L23P_T3_35 Sch=led[3]

##Buttons

set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L4P_T0_35 Sch=btn[0]
set_property -dict { PACKAGE_PIN D20   IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L4N_T0_35 Sch=btn[1]
set_property -dict { PACKAGE_PIN L20   IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L9N_T1_DQS_AD3N_35 Sch=btn[2]
set_property -dict { PACKAGE_PIN L19   IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L9P_T1_DQS_AD3P_35 Sch=btn[3]

##PmodA

set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { col[3] }]; #IO_L17P_T2_34 Sch=ja_p[1]
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { col[2] }]; #IO_L17N_T2_34 Sch=ja_n[1]
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { col[1] }]; #IO_L7P_T1_34 Sch=ja_p[2]
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { col[0] }]; #IO_L7N_T1_34 Sch=ja_n[2]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { row[3] }]; #IO_L12P_T1_MRCC_34 Sch=ja_p[3]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { row[2] }]; #IO_L12N_T1_MRCC_34 Sch=ja_n[3]
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { row[1] }]; #IO_L22P_T3_34 Sch=ja_p[4]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { row[0] }]; #IO_L22N_T3_34 Sch=ja_n[4]

##PmodB

#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { jb[0] }]; #IO_L8P_T1_34 Sch=jb_p[1]
#set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { jb[1] }]; #IO_L8N_T1_34 Sch=jb_n[1]
#set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { jb[2] }]; #IO_L1P_T0_34 Sch=jb_p[2]
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { jb[3] }]; #IO_L1N_T0_34 Sch=jb_n[2]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L18P_T2_34 Sch=jb_p[3]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { jb[5] }]; #IO_L18N_T2_34 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L4P_T0_34 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L4N_T0_34 Sch=jb_n[4]

##Audio 

set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { AC_ADR0 }]; #IO_L8P_T1_AD10P_35 Sch=adr0
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { AC_ADR1 }]; #IO_L8N_T1_AD10N_35 Sch=adr1

set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { AC_MCLK }]; #IO_L19N_T3_VREF_13 Sch=au_mclk_r
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { AC_SDA  }]; #IO_L12P_T1_MRCC_13 Sch=au_sda_r 
set_property -dict { PACKAGE_PIN U9    IOSTANDARD LVCMOS33 } [get_ports { AC_SCK  }]; #IO_L17P_T2_13 Sch= au_scl_r 
set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { AC_DOUT }]; #IO_L6N_T0_VREF_35 Sch=au_dout_r
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { AC_DIN  }]; #IO_L16N_T2_35 Sch=au_din_r 
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { AC_WCLK }]; #IO_L20P_T3_34 Sch=au_wclk_r
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { AC_BCLK }]; #IO_L20N_T3_34 Sch=au_bclk_r


## Single Ended Analog Inputs
##NOTE: The ar_an_p pins can be used as single ended analog inputs with voltages from 0-3.3V (Arduino Analog pins a[0]-a[5]). 
##      These signals should only be connected to the XADC core. When using these pins as digital I/O, use pins a[0]-a[5].

#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { ar_an0_p }]; #IO_L3P_T0_DQS_AD1P_35 Sch=ar_an0_p
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { ar_an0_n }]; #IO_L3P_T0_DQS_AD1P_35 Sch=ar_an0_n
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { ar_an1_p }]; #IO_L5N_T0_AD9P_35 Sch=ar_an1_p
#set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { ar_an1_n }]; #IO_L5N_T0_AD9N_35 Sch=ar_an1_n
#set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { ar_an2_p }]; #IO_L20P_T3_AD6P_35 Sch=ar_an2_p
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { ar_an2_n }]; #IO_L20P_T3_AD6N_35 Sch=ar_an2_n
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { ar_an3_p }]; #IO_L24P_T3_AD15P_35 Sch=ar_an3_p
#set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { ar_an3_n }]; #IO_L24P_T3_AD15N_35 Sch=ar_an3_n
#set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { ar_an4_p }]; #IO_L17P_T2_AD5P_35 Sch=ar_an4_p
#set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { ar_an4_n }]; #IO_L17P_T2_AD5P_35 Sch=ar_an4_n
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { ar_an5_p }]; #IO_L18P_T2_AD13P_35 Sch=ar_an5_p
#set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS33 } [get_ports { ar_an5_n }]; #IO_L18P_T2_AD13P_35 Sch=ar_an5_n

##Arduino Digital I/O 

#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { ar[0] }]; #IO_L5P_T0_34 Sch=ar[0]
#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { ar[1] }]; #IO_L2N_T0_34 Sch=ar[1]
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { ar[2] }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=ar[2]
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { ar[3] }]; #IO_L3N_T0_DQS_34 Sch=ar[3]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { ar[4] }]; #IO_L10P_T1_34 Sch=ar[4]
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { ar[5] }]; #IO_L5N_T0_34 Sch=ar[5]
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ar[6] }]; #IO_L19P_T3_34 Sch=ar[6]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { ar[7] }]; #IO_L9N_T1_DQS_34 Sch=ar[7]
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { ar[8] }]; #IO_L21P_T3_DQS_34 Sch=ar[8]
#set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { ar[9] }]; #IO_L21N_T3_DQS_34 Sch=ar[9]
#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { ar[10] }]; #IO_L9P_T1_DQS_34 Sch=ar[10]
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { ar[11] }]; #IO_L19N_T3_VREF_34 Sch=ar[11]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ar[12] }]; #IO_L23N_T3_34 Sch=ar[12]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ar[13] }]; #IO_L23P_T3_34 Sch=ar[13]
#set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS33 } [get_ports { a }]; #IO_L20N_T3_13 Sch=a

##Arduino Digital I/O On Outer Analog Header
##NOTE: These pins should be used when using the analog header signals A0-A5 as digital I/O 

#set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { a[0] }]; #IO_L18N_T2_13 Sch=a[0]
#set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS33 } [get_ports { a[1] }]; #IO_L20P_T3_13 Sch=a[1]
#set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { a[2] }]; #IO_L18P_T2_13 Sch=a[2]
#set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { a[3] }]; #IO_L21P_T3_DQS_13 Sch=a[3]
#set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { a[4] }]; #IO_L19P_T3_13 Sch=a[4]
#set_property -dict { PACKAGE_PIN U10   IOSTANDARD LVCMOS33 } [get_ports { a[5] }]; #IO_L12N_T1_MRCC_13 Sch=a[5]

## Arduino SPI

#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { ck_miso }]; #IO_L10N_T1_34 Sch=miso
#set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { ck_mosi }]; #IO_L2P_T0_34 Sch=ar_mosi_r
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { ck_sck }]; #IO_L19P_T3_35 Sch=sck
#set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { ck_ss }]; #IO_L6P_T0_35 Sch=ss

## Arduino I2C

#set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { ar_scl }]; #IO_L24N_T3_34 Sch=ar_scl
#set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { ar_sda }]; #IO_L24P_T3_34 Sch=ar_sda

##Raspberry Digital I/O 

#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { rpio_02_r }]; #IO_L22P_T3_34 Sch=rpio_02_r
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { rpio_03_r }]; #IO_L22N_T3_34 Sch=rpio_03_r
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { rpio_04_r }]; #IO_L17P_T2_34 Sch=rpio_04_r
#set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { rpio_05_r }]; #IO_L17N_T2_34 Sch=rpio_05_r
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { rpio_06_r }]; #IO_L22P_T3_13 Sch=rpio_06_r
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { rpio_07_r }]; #IO_L12P_T1_MRCC_34 Sch=rpio_07_r
#set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { rpio_08_r }]; #IO_L12N_T1_MRCC_34 Sch=rpio_08_r
#set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { rpio_09_r }]; #IO_L21N_T3_DQS_13 Sch=rpio_09_r
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { rpio_10_r }]; #IO_L15P_T2_DQS_13 Sch=rpio_10_r
#set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { rpio_11_r }]; #IO_L16P_T2_13 Sch=rpio_11_r
#set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { rpio_12_r }]; #IO_L1N_T0_AD0N_35 Sch=rpio_12_r
#set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { rpio_13_r }]; #IO_L15N_T2_DQS_13 Sch=rpio_13_r
#set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { rpio_14_r }]; #IO_L22P_T3_13 Sch=rpio_14_r
#set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { rpio_15_r }]; #IO_L13N_T2_MRCC_13 Sch=rpio_15_r
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { rpio_16_r }]; #IO_L2P_T0_AD8P_35 Sch=rpio_16_r
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { rpio_17_r }]; #IO_L11P_T1_SRCC_13 Sch=rpio_17_r
#set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { rpio_18_r }]; #IO_L1P_T0_AD0P_35 Sch=rpio_18_r
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { rpio_19_r }]; #IO_L14N_T2_SRCC_13 Sch=rpio_19_r
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { rpio_20_r }]; #IO_L2N_T0_AD8N_35 Sch=rpio_20_r
#set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { rpio_21_r }]; #IO_L14P_T2_SRCC_13 Sch=rpio_21_r
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { rpio_22_r }]; #IO_L17N_T2_13 Sch=rpio_22_r
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { rpio_23_r }]; #IO_IO_L22N_T3_13 Sch=rpio_23_r
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { rpio_24_r }]; #IO_L13P_T2_MRCC_13 Sch=rpio_24_r
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { rpio_25_r }]; #IO_L15N_T2_DQS_AD12N_35 Sch=rpio_25_r
#set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { rpio_26_r }]; #IO_L16N_T2_13 Sch=rpio_26_r
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { rpio_sd_r }]; #IO_L7P_T1_34 Sch=rpio_sd_r
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { rpio_sc_r }]; #IO_L7N_T1_34 Sch=rpio_sc_r

##HDMI Rx

#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L13N_T2_MRCC_35 Sch=hdmi_rx_cec
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_n }]; #IO_L13N_T2_MRCC_34 Sch=hdmi_rx_clk_n
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_p }]; #IO_L13P_T2_MRCC_34 Sch=hdmi_rx_clk_p
#set_property -dict { PACKAGE_PIN W20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[0] }]; #IO_L16N_T2_34 Sch=hdmi_rx_d_n[0]
#set_property -dict { PACKAGE_PIN V20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[0] }]; #IO_L16P_T2_34 Sch=hdmi_rx_d_p[0]
#set_property -dict { PACKAGE_PIN U20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[1] }]; #IO_L15N_T2_DQS_34 Sch=hdmi_rx_d_n[1]
#set_property -dict { PACKAGE_PIN T20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[1] }]; #IO_L15P_T2_DQS_34 Sch=hdmi_rx_d_p[1]
#set_property -dict { PACKAGE_PIN P20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[2] }]; #IO_L14N_T2_SRCC_34 Sch=hdmi_rx_d_n[2]
#set_property -dict { PACKAGE_PIN N20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[2] }]; #IO_L14P_T2_SRCC_34 Sch=hdmi_rx_d_p[2]
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_hpd }]; #IO_25_34 Sch=hdmi_rx_hpd
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L11P_T1_SRCC_34 Sch=hdmi_rx_scl
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L11N_T1_SRCC_34 Sch=hdmi_rx_sda

##HDMI Tx
set_property -dict {PACKAGE_PIN L17 IOSTANDARD TMDS_33} [get_ports TMDS_Clk_n]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD TMDS_33} [get_ports TMDS_Clk_p]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n[0]}]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p[0]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n[1]}]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p[1]}]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n[2]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p[2]}]
#set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L19N_T3_VREF_35 Sch=hdmi_tx_cec
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_hpdn }]; #IO_0_34 Sch=hdmi_tx_hpdn


##Crypto SDA 

#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_25_35 Sch=crypto_sda











## This file is a general .xdc for the Add-on board developed for PYNQ-Z2
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal from ENET Controller pin
# set_property PACKAGE_PIN H16 [get_ports clk125]							
# set_property IOSTANDARD LVCMOS33 [get_ports clk125]
# create_clock -add -name clk125_pin -period 8.00 -waveform {0 4} [get_ports clk125]

## Clock signal from Adapter's board 12 MHz via RPIO_21_R, connected to Pin 40, FPGA Signal name RP_IO15
# set_property PACKAGE_PIN Y9 [get_ports clk12]							
# set_property IOSTANDARD LVCMOS33 [get_ports clk12]
# create_clock -add -name clk12_pin -period 83.333 -waveform {0 41.667} [get_ports clk12]
 
## Switches maps to SWA (sw[0]) to SWH (sw[7])
# set_property PACKAGE_PIN V6 [get_ports {sw[0]}];	#RPIO_14_R, connector Pin 8, FPGA Signal name RP_IO02				
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
# set_property PACKAGE_PIN Y6 [get_ports {sw[1]}];	#RPIO_15_R, connector Pin 10, FPGA Signal name RP_IO10					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
# set_property PACKAGE_PIN B19 [get_ports {sw[2]}];	#RPIO_16_R, connector Pin 36, FPGA Signal name RP_IO20					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
# set_property PACKAGE_PIN U7 [get_ports {sw[3]}];	#RPIO_17_R, connector Pin 11, FPGA Signal name RP_IO03					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
# set_property PACKAGE_PIN C20 [get_ports {sw[4]}];	#RPIO_18_R, connector Pin 12, FPGA Signal name RP_IO18					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
# set_property PACKAGE_PIN Y8 [get_ports {sw[5]}];	#RPIO_19_R, connector Pin 35, FPGA Signal name RP_IO13					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
# set_property PACKAGE_PIN A20 [get_ports {sw[6]}];	#RPIO_20_R, connector Pin 38, FPGA Signal name RP_IO21					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
# set_property PACKAGE_PIN W9 [get_ports {sw[7]}];	#RPIO_26_R, connector Pin 37, FPGA Signal name RP_IO14					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]

# set_property PACKAGE_PIN M20 [get_ports {enable}];   #Board SW0					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {enable}]
 

## LEDs maps to LDA (led[0]) to LDF (led[5]), led6 to LD2 and led7 to LD3
#set_property PACKAGE_PIN B20 [get_ports {led[0]}];	#RPIO_12_R, connector Pin 32, FPGA Signal name RP_IO19					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
#set_property PACKAGE_PIN W8 [get_ports {led[1]}];	#RPIO_13_R, connector Pin 33, FPGA Signal name RP_IO12					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
#set_property PACKAGE_PIN U8 [get_ports {led[2]}];	#RPIO_22_R, connector Pin 15, FPGA Signal name RP_IO05					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
#set_property PACKAGE_PIN W6 [get_ports {led[3]}];	#RPIO_23_R, connector Pin 16, FPGA Signal name RP_IO09					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
#set_property PACKAGE_PIN Y7 [get_ports {led[4]}];	#RPIO_24_R, connector Pin 18, FPGA Signal name RP_IO11					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
#set_property PACKAGE_PIN F20 [get_ports {led[5]}];	#RPIO_25_R, connector Pin 22, FPGA Signal name RP_IO17					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
#set_property PACKAGE_PIN N16 [get_ports {led[6]}];	LD2					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
#set_property PACKAGE_PIN M14 [get_ports {led[7]}];	LD3					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
	
##7 segment display
# set_property PACKAGE_PIN Y16 [get_ports {seg[0]}];	#CA-RPIO_SD_R, connector Pin 27, FPGA Signal name JA2_P					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
# set_property PACKAGE_PIN Y17 [get_ports {seg[1]}];	#CB-RPIO_SC_R, connector Pin 28, FPGA Signal name JA2_N					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
# set_property PACKAGE_PIN W18 [get_ports {seg[2]}];	#CC-RPIO_02_R, connector Pin 3, FPGA Signal name JA4_P					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
# set_property PACKAGE_PIN W19 [get_ports {seg[3]}];	#CD-RPIO_03_R, connector Pin 5, FPGA Signal name JA4_N					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
# set_property PACKAGE_PIN Y18 [get_ports {seg[4]}];	#CE-RPIO_04_R, connector Pin 7, FPGA Signal name JA1_P					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
# set_property PACKAGE_PIN Y19 [get_ports {seg[5]}];	#CF-RPIO_05_R, connector Pin 29, FPGA Signal name JA1_N					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
# set_property PACKAGE_PIN U18 [get_ports {seg[6]}];	#CG-RPIO_06_R, connector Pin 31, FPGA Signal name JA3_P					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
# set_property PACKAGE_PIN U19 [get_ports seg[7]];	#DP-RPIO_07_R, connector Pin 26, FPGA Signal name JA3_N							
# 	set_property IOSTANDARD LVCMOS33 [get_ports seg[7]]

# set_property PACKAGE_PIN W10 [get_ports {an[3]}];	#CA-RPIO_11_R, connector Pin 23, FPGA Signal name RP_IO08					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
# set_property PACKAGE_PIN V8 [get_ports {an[2]}];	#CA-RPIO_10_R, connector Pin 19, FPGA Signal name RP_IO06					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
# set_property PACKAGE_PIN V10 [get_ports {an[1]}];	#CA-RPIO_09_R, connector Pin 21, FPGA Signal name RP_IO07					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
# set_property PACKAGE_PIN F19 [get_ports {an[0]}];	#CA-RPIO_08_R, connector Pin 24, FPGA Signal name RP_IO16					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]


# PYNQ-Z2 board Button
# set_property PACKAGE_PIN D19 [get_ports reset];	# BTN0 of the board					
# 	set_property IOSTANDARD LVCMOS33 [get_ports reset]
# Adapter card's button
# set_property PACKAGE_PIN V7 [get_ports clkSel];	#RPIO_27_R, connector Pin 13, FPGA Signal name RP_IO04						
# 	set_property IOSTANDARD LVCMOS33 [get_ports clkSel]




