################################################################
# PL Pmod #1 using Samtec Connectors
################################################################
set_property PACKAGE_PIN M15 [get_ports {tx_mclk}];
set_property IOSTANDARD LVCMOS33 [get_ports {tx_mclk}];

set_property PACKAGE_PIN L15 [get_ports {tx_lrck}];
set_property IOSTANDARD LVCMOS33 [get_ports {tx_lrck}];

set_property PACKAGE_PIN M14 [get_ports {tx_sclk}];
set_property IOSTANDARD LVCMOS33 [get_ports {tx_sclk}];

set_property PACKAGE_PIN L14 [get_ports {tx_sdata}];
set_property IOSTANDARD LVCMOS33 [get_ports {tx_sdata}];

set_property PACKAGE_PIN L13 [get_ports {rx_mclk}];
set_property IOSTANDARD LVCMOS33 [get_ports {rx_mclk}];

set_property PACKAGE_PIN K13 [get_ports {rx_lrck}];
set_property IOSTANDARD LVCMOS33 [get_ports {rx_lrck}];

set_property PACKAGE_PIN N14 [get_ports {rx_sclk}];
set_property IOSTANDARD LVCMOS33 [get_ports {rx_sclk}];

set_property PACKAGE_PIN N13 [get_ports {rx_sdata}];
set_property IOSTANDARD LVCMOS33 [get_ports {rx_sdata}];
