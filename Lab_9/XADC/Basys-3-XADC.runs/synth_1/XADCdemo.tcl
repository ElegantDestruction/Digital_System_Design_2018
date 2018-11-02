# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.cache/wt [current_project]
set_property parent.project_path /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.board [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property ip_repo_paths /home/exposedbuckle48/Documents/Semester_5/repo [current_project]
set_property ip_output_repo /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/DigitToSeg.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/bin2dec.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/counter3bit.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/decoder3_8.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/mux4_4bus.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/segClkDevider.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/sevensegdecoder.v
  /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/imports/hdl/XADCdemo.v
}
read_ip -quiet /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/ip/xadc_wiz_2/xadc_wiz_2.xci
set_property used_in_implementation false [get_files -all /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/ip/xadc_wiz_2/xadc_wiz_2_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/sources_1/ip/xadc_wiz_2/xadc_wiz_2.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/constrs_1/imports/constraints/Basys3_Master.xdc
set_property used_in_implementation false [get_files /home/exposedbuckle48/Documents/Semester_5/DSD/Lab_9/XADC/Basys-3-XADC.srcs/constrs_1/imports/constraints/Basys3_Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top XADCdemo -part xc7a35tcpg236-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef XADCdemo.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file XADCdemo_utilization_synth.rpt -pb XADCdemo_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
