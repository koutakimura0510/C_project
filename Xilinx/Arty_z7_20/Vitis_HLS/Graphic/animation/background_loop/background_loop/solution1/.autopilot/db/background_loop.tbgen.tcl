set moduleName background_loop
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {background_loop}
set C_modelType { void 0 }
set C_modelArgList {
	{ copy int 32 regular {axi_master 0}  }
	{ update int 32 regular {axi_master 1}  }
	{ ddr_copy int 64 regular {axi_slave 0}  }
	{ ddr_update int 64 regular {axi_slave 0}  }
	{ width int 32 regular {axi_slave 0}  }
	{ height int 32 regular {axi_slave 0}  }
	{ frame_size int 32 regular {axi_slave 0}  }
	{ direction int 32 unused {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "copy", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "ddr_copy","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "ddr_copy","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "update", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "ddr_update","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "ddr_update","bundle": "control"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "ddr_copy", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "ddr_update", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "width", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "width","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":40}, "offset_end" : {"in":47}} , 
 	{ "Name" : "height", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "height","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":48}, "offset_end" : {"in":55}} , 
 	{ "Name" : "frame_size", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "frame_size","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":56}, "offset_end" : {"in":63}} , 
 	{ "Name" : "direction", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "direction","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":64}, "offset_end" : {"in":71}} ]}
# RTL Port declarations: 
set portNum 110
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_copy_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_copy_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_copy_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_copy_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_copy_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_copy_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_copy_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_copy_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_copy_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_copy_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_copy_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_copy_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_copy_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_copy_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_copy_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_copy_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_copy_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_copy_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_copy_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_copy_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_copy_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_copy_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_copy_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_copy_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_copy_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_copy_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_copy_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_copy_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_copy_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_copy_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_copy_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_copy_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_copy_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_copy_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_copy_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_copy_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_copy_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_copy_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_copy_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_update_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_update_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_update_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_update_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_update_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_update_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_update_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_update_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_update_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_update_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_update_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_update_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_update_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_update_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_update_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_update_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_update_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_update_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_update_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_update_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_update_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_update_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_update_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_update_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_update_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_update_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_update_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_update_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_update_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_update_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_update_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_update_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_update_BUSER sc_in sc_lv 1 signal 1 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 7 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 7 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"background_loop","role":"start","value":"0","valid_bit":"0"},{"name":"background_loop","role":"continue","value":"0","valid_bit":"4"},{"name":"background_loop","role":"auto_start","value":"0","valid_bit":"7"},{"name":"ddr_copy","role":"data","value":"16"},{"name":"ddr_update","role":"data","value":"28"},{"name":"width","role":"data","value":"40"},{"name":"height","role":"data","value":"48"},{"name":"frame_size","role":"data","value":"56"},{"name":"direction","role":"data","value":"64"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"background_loop","role":"start","value":"0","valid_bit":"0"},{"name":"background_loop","role":"done","value":"0","valid_bit":"1"},{"name":"background_loop","role":"idle","value":"0","valid_bit":"2"},{"name":"background_loop","role":"ready","value":"0","valid_bit":"3"},{"name":"background_loop","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_copy_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWVALID" }} , 
 	{ "name": "m_axi_copy_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWREADY" }} , 
 	{ "name": "m_axi_copy_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "copy", "role": "AWADDR" }} , 
 	{ "name": "m_axi_copy_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWID" }} , 
 	{ "name": "m_axi_copy_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "copy", "role": "AWLEN" }} , 
 	{ "name": "m_axi_copy_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_copy_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "AWBURST" }} , 
 	{ "name": "m_axi_copy_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_copy_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_copy_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "AWPROT" }} , 
 	{ "name": "m_axi_copy_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "AWQOS" }} , 
 	{ "name": "m_axi_copy_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "AWREGION" }} , 
 	{ "name": "m_axi_copy_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWUSER" }} , 
 	{ "name": "m_axi_copy_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WVALID" }} , 
 	{ "name": "m_axi_copy_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WREADY" }} , 
 	{ "name": "m_axi_copy_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy", "role": "WDATA" }} , 
 	{ "name": "m_axi_copy_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "WSTRB" }} , 
 	{ "name": "m_axi_copy_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WLAST" }} , 
 	{ "name": "m_axi_copy_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WID" }} , 
 	{ "name": "m_axi_copy_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WUSER" }} , 
 	{ "name": "m_axi_copy_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARVALID" }} , 
 	{ "name": "m_axi_copy_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARREADY" }} , 
 	{ "name": "m_axi_copy_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "copy", "role": "ARADDR" }} , 
 	{ "name": "m_axi_copy_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARID" }} , 
 	{ "name": "m_axi_copy_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "copy", "role": "ARLEN" }} , 
 	{ "name": "m_axi_copy_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_copy_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "ARBURST" }} , 
 	{ "name": "m_axi_copy_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_copy_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_copy_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "ARPROT" }} , 
 	{ "name": "m_axi_copy_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "ARQOS" }} , 
 	{ "name": "m_axi_copy_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "ARREGION" }} , 
 	{ "name": "m_axi_copy_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARUSER" }} , 
 	{ "name": "m_axi_copy_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RVALID" }} , 
 	{ "name": "m_axi_copy_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RREADY" }} , 
 	{ "name": "m_axi_copy_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy", "role": "RDATA" }} , 
 	{ "name": "m_axi_copy_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RLAST" }} , 
 	{ "name": "m_axi_copy_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RID" }} , 
 	{ "name": "m_axi_copy_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RUSER" }} , 
 	{ "name": "m_axi_copy_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "RRESP" }} , 
 	{ "name": "m_axi_copy_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BVALID" }} , 
 	{ "name": "m_axi_copy_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BREADY" }} , 
 	{ "name": "m_axi_copy_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "BRESP" }} , 
 	{ "name": "m_axi_copy_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BID" }} , 
 	{ "name": "m_axi_copy_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BUSER" }} , 
 	{ "name": "m_axi_update_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWVALID" }} , 
 	{ "name": "m_axi_update_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWREADY" }} , 
 	{ "name": "m_axi_update_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update", "role": "AWADDR" }} , 
 	{ "name": "m_axi_update_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWID" }} , 
 	{ "name": "m_axi_update_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "update", "role": "AWLEN" }} , 
 	{ "name": "m_axi_update_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_update_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "AWBURST" }} , 
 	{ "name": "m_axi_update_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_update_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_update_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "AWPROT" }} , 
 	{ "name": "m_axi_update_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "AWQOS" }} , 
 	{ "name": "m_axi_update_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "AWREGION" }} , 
 	{ "name": "m_axi_update_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWUSER" }} , 
 	{ "name": "m_axi_update_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WVALID" }} , 
 	{ "name": "m_axi_update_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WREADY" }} , 
 	{ "name": "m_axi_update_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "update", "role": "WDATA" }} , 
 	{ "name": "m_axi_update_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "WSTRB" }} , 
 	{ "name": "m_axi_update_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WLAST" }} , 
 	{ "name": "m_axi_update_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WID" }} , 
 	{ "name": "m_axi_update_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WUSER" }} , 
 	{ "name": "m_axi_update_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARVALID" }} , 
 	{ "name": "m_axi_update_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARREADY" }} , 
 	{ "name": "m_axi_update_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update", "role": "ARADDR" }} , 
 	{ "name": "m_axi_update_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARID" }} , 
 	{ "name": "m_axi_update_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "update", "role": "ARLEN" }} , 
 	{ "name": "m_axi_update_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_update_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "ARBURST" }} , 
 	{ "name": "m_axi_update_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_update_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_update_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "ARPROT" }} , 
 	{ "name": "m_axi_update_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "ARQOS" }} , 
 	{ "name": "m_axi_update_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "ARREGION" }} , 
 	{ "name": "m_axi_update_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARUSER" }} , 
 	{ "name": "m_axi_update_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RVALID" }} , 
 	{ "name": "m_axi_update_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RREADY" }} , 
 	{ "name": "m_axi_update_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "update", "role": "RDATA" }} , 
 	{ "name": "m_axi_update_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RLAST" }} , 
 	{ "name": "m_axi_update_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RID" }} , 
 	{ "name": "m_axi_update_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RUSER" }} , 
 	{ "name": "m_axi_update_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "RRESP" }} , 
 	{ "name": "m_axi_update_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BVALID" }} , 
 	{ "name": "m_axi_update_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BREADY" }} , 
 	{ "name": "m_axi_update_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "BRESP" }} , 
 	{ "name": "m_axi_update_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BID" }} , 
 	{ "name": "m_axi_update_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "16", "20"],
		"CDFG" : "background_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "60", "EstimateLatencyMax" : "324663",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "16", "SubInstance" : "grp_dataflow_parent_loop_proc_fu_121", "Port" : "copy"},
					{"ID" : "5", "SubInstance" : "grp_dataflow_parent_loop_proc3_fu_108", "Port" : "copy"}]},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "20", "SubInstance" : "grp_dataflow_parent_loop_proc4_fu_137", "Port" : "update"},
					{"ID" : "5", "SubInstance" : "grp_dataflow_parent_loop_proc3_fu_108", "Port" : "update"}]},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "direction", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.copy_m_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.update_m_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.ycopy_V_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108", "Parent" : "0", "Child" : ["6"],
		"CDFG" : "dataflow_parent_loop_proc3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "29", "EstimateLatencyMax" : "314094",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "6", "Name" : "dataflow_in_loop_right_height_loop_U0"}],
		"OutputProcess" : [
			{"ID" : "6", "Name" : "dataflow_in_loop_right_height_loop_U0"}],
		"Port" : [
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "dataflow_in_loop_right_height_loop_U0", "Port" : "copy"}]},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "dataflow_in_loop_right_height_loop_U0", "Port" : "update"}]}]},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0", "Parent" : "5", "Child" : ["7", "8", "10", "12", "13", "14", "15"],
		"CDFG" : "dataflow_in_loop_right_height_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "26", "EstimateLatencyMax" : "1304",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "8", "Name" : "right_width_loop_proc8_U0"}],
		"OutputProcess" : [
			{"ID" : "10", "Name" : "right_copy_loop_proc_U0"}],
		"Port" : [
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "right_width_loop_proc8_U0", "Port" : "copy"}]},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "10", "SubInstance" : "right_copy_loop_proc_U0", "Port" : "update"}]}]},
	{"ID" : "7", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.xcopy_V_U", "Parent" : "6"},
	{"ID" : "8", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.right_width_loop_proc8_U0", "Parent" : "6", "Child" : ["9"],
		"CDFG" : "right_width_loop_proc8",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "13", "EstimateLatencyMax" : "652",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "copy_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "copy_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "xcopy_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "10", "DependentChan" : "7"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "width_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "10", "DependentChan" : "12", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_1_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "10", "DependentChan" : "13", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_1_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "10", "DependentChan" : "14", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ddr_update_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "10", "DependentChan" : "15", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ddr_update_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "9", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.right_width_loop_proc8_U0.mul_32ns_32ns_62_2_1_U21", "Parent" : "8"},
	{"ID" : "10", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.right_copy_loop_proc_U0", "Parent" : "6", "Child" : ["11"],
		"CDFG" : "right_copy_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "12", "EstimateLatencyMax" : "651",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "width", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "12", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_1", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "13", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "14", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xcopy_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "7"},
			{"Name" : "ddr_update", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "15", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ddr_update_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "update_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "11", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.right_copy_loop_proc_U0.mul_32ns_32ns_62_2_1_U33", "Parent" : "10"},
	{"ID" : "12", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.width_c_U", "Parent" : "6"},
	{"ID" : "13", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.y_1_c_U", "Parent" : "6"},
	{"ID" : "14", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.frame_size_c_U", "Parent" : "6"},
	{"ID" : "15", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc3_fu_108.dataflow_in_loop_right_height_loop_U0.ddr_update_c_U", "Parent" : "6"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc_fu_121", "Parent" : "0", "Child" : ["17"],
		"CDFG" : "dataflow_parent_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "14", "EstimateLatencyMax" : "5762",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "17", "Name" : "dataflow_in_loop_copy_U0"}],
		"OutputProcess" : [
			{"ID" : "17", "Name" : "dataflow_in_loop_copy_U0"}],
		"Port" : [
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "dataflow_in_loop_copy_U0", "Port" : "copy"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "dataflow_in_loop_copy_U0", "Port" : "ycopy_V"}]}]},
	{"ID" : "17", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc_fu_121.dataflow_in_loop_copy_U0", "Parent" : "16", "Child" : ["18"],
		"CDFG" : "dataflow_in_loop_copy",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "11", "EstimateLatencyMax" : "11",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "18", "Name" : "Block_entry_proc_proc_U0"}],
		"OutputProcess" : [
			{"ID" : "18", "Name" : "Block_entry_proc_proc_U0"}],
		"Port" : [
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "18", "SubInstance" : "Block_entry_proc_proc_U0", "Port" : "copy"}]},
			{"Name" : "trunc_ln1345", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "18", "SubInstance" : "Block_entry_proc_proc_U0", "Port" : "ycopy_V"}]}]},
	{"ID" : "18", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc_fu_121.dataflow_in_loop_copy_U0.Block_entry_proc_proc_U0", "Parent" : "17", "Child" : ["19"],
		"CDFG" : "Block_entry_proc_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "11", "EstimateLatencyMax" : "11",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "copy_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "copy_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "O"}]},
	{"ID" : "19", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc_fu_121.dataflow_in_loop_copy_U0.Block_entry_proc_proc_U0.mul_32ns_32ns_62_2_1_U1", "Parent" : "18"},
	{"ID" : "20", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc4_fu_137", "Parent" : "0", "Child" : ["21"],
		"CDFG" : "dataflow_parent_loop_proc4",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "12", "EstimateLatencyMax" : "4802",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "21", "Name" : "dataflow_in_loop_copy2_U0"}],
		"OutputProcess" : [
			{"ID" : "21", "Name" : "dataflow_in_loop_copy2_U0"}],
		"Port" : [
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "21", "SubInstance" : "dataflow_in_loop_copy2_U0", "Port" : "ycopy_V"}]},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "21", "SubInstance" : "dataflow_in_loop_copy2_U0", "Port" : "update"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "21", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc4_fu_137.dataflow_in_loop_copy2_U0", "Parent" : "20", "Child" : ["22"],
		"CDFG" : "dataflow_in_loop_copy2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "9", "EstimateLatencyMax" : "9",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "22", "Name" : "Block_entry_proc_proc7_U0"}],
		"OutputProcess" : [
			{"ID" : "22", "Name" : "Block_entry_proc_proc7_U0"}],
		"Port" : [
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "22", "SubInstance" : "Block_entry_proc_proc7_U0", "Port" : "ycopy_V"}]},
			{"Name" : "trunc_ln329", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "22", "SubInstance" : "Block_entry_proc_proc7_U0", "Port" : "update"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "22", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc4_fu_137.dataflow_in_loop_copy2_U0.Block_entry_proc_proc7_U0", "Parent" : "21", "Child" : ["23"],
		"CDFG" : "Block_entry_proc_proc7",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "9", "EstimateLatencyMax" : "9",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "trunc_ln329", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "update_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "23", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_dataflow_parent_loop_proc4_fu_137.dataflow_in_loop_copy2_U0.Block_entry_proc_proc7_U0.mul_32ns_32ns_62_2_1_U59", "Parent" : "22"}]}


set ArgLastReadFirstWriteLatency {
	background_loop {
		copy {Type I LastRead 11 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 4}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		height {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		direction {Type I LastRead -1 FirstWrite -1}}
	dataflow_parent_loop_proc3 {
		height {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 11 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}
	dataflow_in_loop_right_height_loop {
		width {Type I LastRead 0 FirstWrite -1}
		y_1 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 11 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}
	right_width_loop_proc8 {
		width {Type I LastRead 0 FirstWrite -1}
		y_1 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 2 FirstWrite -1}
		copy {Type I LastRead 11 FirstWrite -1}
		xcopy_V1 {Type O LastRead -1 FirstWrite 12}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		width_out {Type O LastRead -1 FirstWrite 0}
		y_1_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out {Type O LastRead -1 FirstWrite 0}
		ddr_update_out {Type O LastRead -1 FirstWrite 0}}
	right_copy_loop_proc {
		width {Type I LastRead 0 FirstWrite -1}
		y_1 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		xcopy_V1 {Type I LastRead 5 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}
	dataflow_parent_loop_proc {
		height {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 10 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		ycopy_V {Type O LastRead -1 FirstWrite 11}}
	dataflow_in_loop_copy {
		copy {Type I LastRead 10 FirstWrite -1}
		trunc_ln1345 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		ycopy_V {Type O LastRead -1 FirstWrite 11}}
	Block_entry_proc_proc {
		copy {Type I LastRead 10 FirstWrite -1}
		trunc_ln1345 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 1 FirstWrite -1}
		ddr_copy {Type I LastRead 2 FirstWrite -1}
		ycopy_V {Type O LastRead -1 FirstWrite 11}}
	dataflow_parent_loop_proc4 {
		height {Type I LastRead 0 FirstWrite -1}
		ycopy_V {Type I LastRead 2 FirstWrite -1}
		update {Type O LastRead 5 FirstWrite 4}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}}
	dataflow_in_loop_copy2 {
		ycopy_V {Type I LastRead 2 FirstWrite -1}
		trunc_ln329 {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 5 FirstWrite 4}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}}
	Block_entry_proc_proc7 {
		ycopy_V {Type I LastRead 2 FirstWrite -1}
		trunc_ln329 {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 5 FirstWrite 4}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 2 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "60", "Max" : "324663"}
	, {"Name" : "Interval", "Min" : "61", "Max" : "324664"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	copy { m_axi {  { m_axi_copy_AWVALID VALID 1 1 }  { m_axi_copy_AWREADY READY 0 1 }  { m_axi_copy_AWADDR ADDR 1 64 }  { m_axi_copy_AWID ID 1 1 }  { m_axi_copy_AWLEN LEN 1 8 }  { m_axi_copy_AWSIZE SIZE 1 3 }  { m_axi_copy_AWBURST BURST 1 2 }  { m_axi_copy_AWLOCK LOCK 1 2 }  { m_axi_copy_AWCACHE CACHE 1 4 }  { m_axi_copy_AWPROT PROT 1 3 }  { m_axi_copy_AWQOS QOS 1 4 }  { m_axi_copy_AWREGION REGION 1 4 }  { m_axi_copy_AWUSER USER 1 1 }  { m_axi_copy_WVALID VALID 1 1 }  { m_axi_copy_WREADY READY 0 1 }  { m_axi_copy_WDATA DATA 1 32 }  { m_axi_copy_WSTRB STRB 1 4 }  { m_axi_copy_WLAST LAST 1 1 }  { m_axi_copy_WID ID 1 1 }  { m_axi_copy_WUSER USER 1 1 }  { m_axi_copy_ARVALID VALID 1 1 }  { m_axi_copy_ARREADY READY 0 1 }  { m_axi_copy_ARADDR ADDR 1 64 }  { m_axi_copy_ARID ID 1 1 }  { m_axi_copy_ARLEN LEN 1 8 }  { m_axi_copy_ARSIZE SIZE 1 3 }  { m_axi_copy_ARBURST BURST 1 2 }  { m_axi_copy_ARLOCK LOCK 1 2 }  { m_axi_copy_ARCACHE CACHE 1 4 }  { m_axi_copy_ARPROT PROT 1 3 }  { m_axi_copy_ARQOS QOS 1 4 }  { m_axi_copy_ARREGION REGION 1 4 }  { m_axi_copy_ARUSER USER 1 1 }  { m_axi_copy_RVALID VALID 0 1 }  { m_axi_copy_RREADY READY 1 1 }  { m_axi_copy_RDATA DATA 0 32 }  { m_axi_copy_RLAST LAST 0 1 }  { m_axi_copy_RID ID 0 1 }  { m_axi_copy_RUSER USER 0 1 }  { m_axi_copy_RRESP RESP 0 2 }  { m_axi_copy_BVALID VALID 0 1 }  { m_axi_copy_BREADY READY 1 1 }  { m_axi_copy_BRESP RESP 0 2 }  { m_axi_copy_BID ID 0 1 }  { m_axi_copy_BUSER USER 0 1 } } }
	update { m_axi {  { m_axi_update_AWVALID VALID 1 1 }  { m_axi_update_AWREADY READY 0 1 }  { m_axi_update_AWADDR ADDR 1 64 }  { m_axi_update_AWID ID 1 1 }  { m_axi_update_AWLEN LEN 1 8 }  { m_axi_update_AWSIZE SIZE 1 3 }  { m_axi_update_AWBURST BURST 1 2 }  { m_axi_update_AWLOCK LOCK 1 2 }  { m_axi_update_AWCACHE CACHE 1 4 }  { m_axi_update_AWPROT PROT 1 3 }  { m_axi_update_AWQOS QOS 1 4 }  { m_axi_update_AWREGION REGION 1 4 }  { m_axi_update_AWUSER USER 1 1 }  { m_axi_update_WVALID VALID 1 1 }  { m_axi_update_WREADY READY 0 1 }  { m_axi_update_WDATA DATA 1 32 }  { m_axi_update_WSTRB STRB 1 4 }  { m_axi_update_WLAST LAST 1 1 }  { m_axi_update_WID ID 1 1 }  { m_axi_update_WUSER USER 1 1 }  { m_axi_update_ARVALID VALID 1 1 }  { m_axi_update_ARREADY READY 0 1 }  { m_axi_update_ARADDR ADDR 1 64 }  { m_axi_update_ARID ID 1 1 }  { m_axi_update_ARLEN LEN 1 8 }  { m_axi_update_ARSIZE SIZE 1 3 }  { m_axi_update_ARBURST BURST 1 2 }  { m_axi_update_ARLOCK LOCK 1 2 }  { m_axi_update_ARCACHE CACHE 1 4 }  { m_axi_update_ARPROT PROT 1 3 }  { m_axi_update_ARQOS QOS 1 4 }  { m_axi_update_ARREGION REGION 1 4 }  { m_axi_update_ARUSER USER 1 1 }  { m_axi_update_RVALID VALID 0 1 }  { m_axi_update_RREADY READY 1 1 }  { m_axi_update_RDATA DATA 0 32 }  { m_axi_update_RLAST LAST 0 1 }  { m_axi_update_RID ID 0 1 }  { m_axi_update_RUSER USER 0 1 }  { m_axi_update_RRESP RESP 0 2 }  { m_axi_update_BVALID VALID 0 1 }  { m_axi_update_BREADY READY 1 1 }  { m_axi_update_BRESP RESP 0 2 }  { m_axi_update_BID ID 0 1 }  { m_axi_update_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ copy { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 32 MAX_WRITE_BURST_LENGTH 16 } } \
	{ update { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 32 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ copy 1 }
	{ update 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ copy 1 }
	{ update 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}