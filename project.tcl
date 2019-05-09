################################################################
# Create a new Vivado project
################################################################
set outputDirectory ./project

file mkdir $outputDirectory

create_project fpga_dsp $outputDirectory -part xc7z007sclg225-1 -force

set_property board_part em.avnet.com:minized:part0:1.2 [current_project]

################################################################
# Setup design sources and constraints
################################################################
add_files [glob ./hdl/*.v]

add_files -fileset sim_1 [glob ./sim/*.v]

add_files -fileset constrs_1 [glob ./constrs/*.xdc]
