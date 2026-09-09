# directory location
set this_project_dir [get_property DIRECTORY [current_project]]
set this_project_name [current_project]
open_bd_design ${this_project_dir}/${this_project_name}.srcs/sources_1/bd/design_1/design_1.bd

# Customization BEGIN
set block_name top
set block_cell_name top_0

create_bd_cell -type module -reference top top_0
set btn [ create_bd_port -dir I -from 3 -to 0 btn ]
connect_bd_net -net btn_0_1 [get_bd_ports btn] [get_bd_pins top_0/btn]
set led [ create_bd_port -dir O -from 3 -to 0 led ]
connect_bd_net -net top_0_led [get_bd_pins top_0/led] [get_bd_ports led]
# Customization END

save_bd_design
