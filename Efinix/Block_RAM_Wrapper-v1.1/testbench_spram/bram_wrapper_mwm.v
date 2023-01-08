////////////////////////////////////////////////////////////////////////////
//           _____       
//          / _______    Copyright (C) 2013-2022 Efinix Inc. All rights reserved.
//         / /       \   
//        / /  ..    /   tb_top.v
//       / / .'     /    
//    __/ /.'      /     Description:
//   __   \       /    
//  /_/ /\ \_____/ /     
// ____/  \_______/      
//
// *******************************
// Revisions:
// 0.0 Initial rev
//
// *******************************

module bram_wrapper_mwm #(
	//parameter FAMILY = 0,	//0:Trion,  1:Titanium
	
	//Trion and Titanium parameters 
	parameter WCLK_POLARITY  = 1'b1, 		//wclk polarity,  0:falling edge, 1:rising edge
	parameter WCLKE_POLARITY = 1'b1, 		//wclke polarity, 0:active low, 1:active high
	parameter WE_POLARITY	 = 1'b1, 		//we polarity,    0:active low, 1:active high
	parameter WRITE_MODE  	 = "READ_FIRST",//write mode,  	  "READ_FIRST" 	:Old memory content is read. (default)
											//			  	  "WRITE_FIRST" :Write data is passed to the read port.
											//				  "READ_UNKNOWN": Read and writes are unsynchronized, therefore, the results of the address can conflict.
	parameter RCLK_POLARITY  = 1'b1, 		// rclk polarity, 0:falling edge, 1:rising edge
	parameter RE_POLARITY    = 1'b1, 		// re polarity,	  0:active low  , 1:active high
	parameter OUTPUT_REG     = 1'b0, 		// Output register enable, 1:add pipe-line read register
	
    parameter BYTEEN_POLARITY   = 1'b1,     // byteen polarity		0:active low, 1:active high 
	
	//Titanium extra paramters 
	parameter RST_POLARITY 	    = 1'b1,    	// rst polarity
	parameter RESET_RAM 	    = "ASYNC", 	// reset mode on ram,  "NONE": RST signals does not affect the RAM output.
											//					  "ASYNC": RAM output resets asynchronously to RCLK.
											//                     "SYNC": RAM output resets synchronously to RCLK. 
	parameter RESET_OUTREG 	    = "ASYNC", 	// reset mode on output register
											//					   "NONE": RST signals does not affect the RAM output register		
											//					  "ASYNC": RAM output register resets asynchronously to RCLK.
	parameter WADDREN_POLARITY  = 1'b1,    	// waddren polarity
	parameter RADDREN_POLARITY  = 1'b1    	// raddren polarity

   
    
)   
(
	//Trion and Titanium ports
	wclk, 		// Write clock input
	wclke,		// Write clock-enable input
    byteen,		// Byteen input 
    we, 		// Write-enable input
    waddr, 		// Write address input
    wdata,		// Write data input
  
	rclk, 		// Read clock input	
    re, 		// Read-enable input
    raddr, 		// Read address input
    rdata, 		// Read data output     
     
	//Titanium extra ports
	reset,		 // reset	
	waddren,	 // write address enable
	raddren		 // read address enable
	
 );


`include "bram_decompose.vh"
//`include "bram_feature.vh"

input wclk; 
input wclke;
input we;
input [BYTEEN_WIDTH-1:0] byteen;
input [ADDR_WIDTH_A-1:0 ] waddr; 
input [DATA_WIDTH_A-1:0 ] wdata;

input rclk; 
input re; 
input [ADDR_WIDTH_B-1:0 ] raddr; 
output [DATA_WIDTH_B-1:0 ]rdata;     

input reset;
input waddren;
input raddren;

wire [ADDR_WIDTH_A-1:0 ] w_waddr_map; 
wire [DATA_WIDTH_A-1:0 ] w_wdata_map;

wire [ADDR_WIDTH_B-1:0 ] w_raddr_map; 
wire [DATA_WIDTH_B-1:0 ] w_rdata_map;


function integer get_current_row_index;
input integer row;//Mode type 
integer x;	
	begin
		get_current_row_index = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if (bram_mapping_table(x,0) < row)
				get_current_row_index = get_current_row_index +1;
		end
	end 
endfunction 

function integer get_current_column_index;
input integer column;//Mode type 
integer x;	
	begin
		get_current_column_index = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if (bram_mapping_table(x,1) < column)
				get_current_column_index = get_current_column_index +1;
		end
	end 
endfunction 


function integer get_max_mux_row_A;
input integer temp;//Mode type
integer x;	
	begin
		get_max_mux_row_A = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_mux_row_A < bram_mapping_table(x,5) )
				get_max_mux_row_A =  bram_mapping_table(x,5);
		end
	end 
endfunction 

function integer get_max_wen_decode_A;
input integer temp;//Mode type
integer x;	
	begin
		get_max_wen_decode_A = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_wen_decode_A < bram_mapping_table(x,6) )
				get_max_wen_decode_A =  bram_mapping_table(x,6);
		end
	end 
endfunction 


function integer get_max_mux_row_B;
input integer temp;//Mode type
integer x;	
	begin
		get_max_mux_row_B = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_mux_row_B < bram_mapping_table(x,12) )
				get_max_mux_row_B =  bram_mapping_table(x,12);
		end
	end 
endfunction 

function integer get_max_wen_decode_B;
input integer temp;//Mode type
integer x;	
	begin
		get_max_wen_decode_B = 0;
		for (x=0; x<bram_mapping_size; x=x+1)
		begin
			if ( get_max_wen_decode_B < bram_mapping_table(x,13) )
				get_max_wen_decode_B =  bram_mapping_table(x,13);
		end
	end 
endfunction 



 //   localparam column_size = (bram_table_loop_mode==1)?bram_table_size:1;
   // wire [DATA_WIDTH_B-1:0] w_rdata [bram_table_size-1:0 ];
   // assign rdata = w_rdata[wdata];
    genvar gen_x;
    genvar gen_y;
	genvar gen_z;
	
    generate
			
		wire [DATA_WIDTH_B-1:0 ] rMux [get_max_mux_row_B(0):0]; 
		if (rMux_mapping_B_size == 0) 
        begin
            assign w_rdata_map = rMux[0]; 
        end 
        else 
        begin
            for (gen_y=0; gen_y<rMux_mapping_B_size; gen_y =gen_y +1)
            begin:rDataMux
                localparam ADDR_START = rMux_mapping_table_B(gen_y,1);
                localparam ADDR_END   = rMux_mapping_table_B(gen_y,0);
                
                localparam DATA_START = rMux_mapping_table_B(gen_y,3);
                localparam DATA_END   = rMux_mapping_table_B(gen_y,2);
				localparam BYPRASSED  = rMux_mapping_table_A(gen_y,6);
                
				if( BYPRASSED == 0 )
				begin 
				
					wire [ADDR_END:ADDR_START] rdSel;
					reg [ADDR_END:ADDR_START] r_rdSel_1P;
					
					assign rdSel = w_raddr_map[ADDR_END:ADDR_START];
					
					always @ (posedge rclk)
					begin
						r_rdSel_1P <= rdSel;
					end
                    
                    
                    if (OUTPUT_REG == 0)
                    begin
                        assign w_rdata_map[DATA_END:DATA_START] = rMux[r_rdSel_1P][DATA_END:DATA_START];
                    end 
                    else 
                    begin
                        reg [ADDR_END:ADDR_START] r_rdSel_2P;
                        always @ (posedge rclk)
                        begin
                            r_rdSel_2P <= r_rdSel_1P;
                        end
                            assign w_rdata_map[DATA_END:DATA_START] = rMux[r_rdSel_2P][DATA_END:DATA_START];
                    end 
                end 
				else 
				begin 
					assign w_rdata_map[DATA_END:DATA_START] = rMux[0][DATA_END:DATA_START];
				
				end 
            
            end
        end 
        
		wire [get_max_wen_decode_A(0):0] wen_decode ;
        if (wen_sel_mapping_A_size!=0)
        begin  
			for (gen_y=0; gen_y<wen_sel_mapping_A_size; gen_y =gen_y +1)
			begin:wDataEn
				localparam ADDR_START = wen_sel_mapping_table_A(gen_y,1);
				localparam ADDR_END   = wen_sel_mapping_table_A(gen_y,0);
				
				localparam SEL_START = wen_sel_mapping_table_A(gen_y,3);
				localparam SEL_END   = wen_sel_mapping_table_A(gen_y,2);
				
				localparam BYPRASSED  = wen_sel_mapping_table_A(gen_y,4);
				
				if( BYPRASSED == 0 )
				begin 
					wire [ADDR_END:ADDR_START] wrSel;
					assign wrSel = w_waddr_map[ADDR_END:ADDR_START];
					
					for (gen_x=SEL_START; gen_x<(SEL_END+1); gen_x = gen_x +1)
					begin
						assign wen_decode[gen_x] = (wrSel==(gen_x-SEL_START))?1'b1:1'b0;
					end 
				end 
				else 
				begin
				
					for (gen_x=SEL_START; gen_x<(SEL_END+1); gen_x = gen_x +1)
					begin
						assign wen_decode[gen_x] = 1'b1;
					end 
				end 
			
			end
		end 
		else 
		begin 
			assign wen_decode = {(get_max_wen_decode_A(0)+1){1'b1}};
		end 
		
		
		//For Mixed Width Mode 
		if (data_mapping_table_A_size!=0)
        begin  
			for (gen_y=0; gen_y<data_mapping_table_A_size; gen_y = gen_y +1)
			begin
				assign w_wdata_map[data_mapping_table_A(gen_y)] =  wdata[gen_y] ;
			end
		end 
		else 
		begin 
			assign w_wdata_map = wdata;
		end 
	
		if (address_mapping_table_A_size!=0)
        begin  
			for (gen_y=0; gen_y<address_mapping_table_A_size; gen_y = gen_y +1)
			begin
				assign w_waddr_map[address_mapping_table_A(gen_y)] =  waddr[gen_y] ;
			end
		end 
		else 
		begin 
			assign w_waddr_map = waddr;
		end 
	
	
		if (data_mapping_table_B_size!=0)
        begin  
			for (gen_y=0; gen_y<data_mapping_table_B_size; gen_y = gen_y +1)
			begin
				assign rdata[gen_y]  = w_rdata_map[data_mapping_table_B(gen_y)] ;
			end
		end 
		else 
		begin 
			assign rdata = w_rdata_map;
		end 
	
		if (address_mapping_table_B_size!=0)
        begin  
			for (gen_y=0; gen_y<address_mapping_table_B_size; gen_y = gen_y +1)
			begin
				assign w_raddr_map[address_mapping_table_B(gen_y)] =  raddr[gen_y] ;
			end
		end 
		else 
		begin 
			assign w_raddr_map = raddr;
		end 
			
			
		if (bram_table_loop_mode == 0 ) 
		begin:scan_column
			for (gen_x=0; gen_x<bram_table_size; gen_x =gen_x +1)
			begin:column
				localparam bram_mode_a = bram_decompose_table(gen_x,0); 
				localparam bram_mode_b = bram_decompose_table(gen_x,1); 
				localparam row_count = bram_decompose_table(gen_x,2);
			
				localparam WADDR_WIDTH_ROW = bram_feature_table(bram_mode_a,0);
				localparam WDATA_WIDTH_ROW = bram_feature_table(bram_mode_a,1); 
				localparam WEN_WIDTH_ROW   = bram_feature_table(bram_mode_a,2); 
				
				localparam RADDR_WIDTH_ROW = bram_feature_table(bram_mode_b,0);
				localparam RDATA_WIDTH_ROW = bram_feature_table(bram_mode_b,1); 
				
				localparam START_COLUMN_INDEX = get_current_column_index(gen_x);
				
										
				for (gen_y=0; gen_y<row_count; gen_y =gen_y +1)
				begin:row
					
					localparam DATA_MAP_INDEX = START_COLUMN_INDEX+gen_y;

					localparam WDATA_END     = bram_mapping_table(DATA_MAP_INDEX,2);					
					localparam WDATA_START   = bram_mapping_table(DATA_MAP_INDEX,3);
					localparam WDATA_REPART  = bram_mapping_table(DATA_MAP_INDEX,4);
					localparam WRSEL_INDEX   = bram_mapping_table(DATA_MAP_INDEX,6);
					localparam BYTEEN_INDEX  = bram_mapping_table(DATA_MAP_INDEX,8);
					
					localparam RDATA_END     = bram_mapping_table(DATA_MAP_INDEX,9);
					localparam RDATA_START   = bram_mapping_table(DATA_MAP_INDEX,10);
					localparam RDATA_REPART  = bram_mapping_table(DATA_MAP_INDEX,11);
					localparam RMUX_INDEX    = bram_mapping_table(DATA_MAP_INDEX,12);
					
					wire [WADDR_WIDTH_ROW-1:0] w_waddr;
					wire [WDATA_WIDTH_ROW-1:0] w_wdata;
					wire [WEN_WIDTH_ROW-1:0]   w_we;

					wire [RADDR_WIDTH_ROW-1:0] w_raddr;
					wire [RDATA_WIDTH_ROW-1:0] w_rdata;
					
					assign w_waddr[WADDR_WIDTH_ROW-1:0] = w_waddr_map[WADDR_WIDTH_ROW-1:0];
					assign w_raddr[RADDR_WIDTH_ROW-1:0] = w_raddr_map[RADDR_WIDTH_ROW-1:0];
					
					
					if (WDATA_REPART == 0)
					begin
						assign w_wdata[WDATA_WIDTH_ROW-1:0] = w_wdata_map[WDATA_END:WDATA_START];
					end
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<WDATA_REPART; gen_z = gen_z+1)
						begin
							localparam MIXED_WDATA_START =  WDATA_START + gen_z*row_count*(RDATA_END - RDATA_START+1); //RDATA_WIDTH_ROW;
							localparam MIXED_WDATA_END   =  WDATA_END   + gen_z*row_count*(RDATA_END - RDATA_START+1); //RDATA_WIDTH_ROW; 
							
							localparam MAPPED_WDATA_START =  RDATA_WIDTH_ROW* gen_z;
							localparam MAPPED_WDATA_END   =  RDATA_WIDTH_ROW*(gen_z+1) -1; 
							
							
							assign w_wdata[MAPPED_WDATA_END: MAPPED_WDATA_START]  =  w_wdata_map[MIXED_WDATA_END:MIXED_WDATA_START];
						end
					end 
	
					if (RDATA_REPART == 0)
					begin
						assign rMux[RMUX_INDEX][RDATA_END:RDATA_START]   = w_rdata[RDATA_WIDTH_ROW-1:0];
					end 
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<RDATA_REPART; gen_z = gen_z+1)
						begin
							localparam MIXED_RDATA_START =  RDATA_START + gen_z*row_count*(WDATA_END - WDATA_START+1); //WDATA_WIDTH_ROW;
							localparam MIXED_RDATA_END   =  RDATA_END   + gen_z*row_count*(WDATA_END - WDATA_START+1); //WDATA_WIDTH_ROW; 
							
							localparam MAPPED_RDATA_START =  RDATA_WIDTH_ROW* gen_z;
							localparam MAPPED_RDATA_END   =  RDATA_WIDTH_ROW*(gen_z+1) -1; 
							
							
							assign rMux[RMUX_INDEX][MIXED_RDATA_END:MIXED_RDATA_START]   = w_rdata[MAPPED_RDATA_END:MAPPED_RDATA_START];  
						end					
					end 					
							
					assign w_we[0] = ((we == WE_POLARITY) & wen_decode[WRSEL_INDEX] & (byteen[BYTEEN_INDEX] == BYTEEN_POLARITY) )? WE_POLARITY: !WE_POLARITY;
					if ( WEN_WIDTH_ROW >1)
					begin
						assign w_we[1] = ((we == WE_POLARITY) & wen_decode[WRSEL_INDEX] & (byteen[BYTEEN_INDEX] == BYTEEN_POLARITY) ) ? WE_POLARITY: !WE_POLARITY;
					end 		
					
					bram_primitive #(
						.FAMILY(FAMILY),	//0:Trion,  1:Titanium
						
						//Trion and Titanium parameters 
						.WRITE_WIDTH(WDATA_WIDTH_ROW),	
						.WCLK_POLARITY(WCLK_POLARITY), 	
						.WCLKE_POLARITY(WCLKE_POLARITY),
						.WE_POLARITY(WE_POLARITY), 		
						.WRITE_MODE(WRITE_MODE),		
														
						.READ_WIDTH(RDATA_WIDTH_ROW),  
						.RCLK_POLARITY(RCLK_POLARITY), 	
						.RE_POLARITY(RE_POLARITY), 		
						.OUTPUT_REG(OUTPUT_REG),		
						
						//Titanium extra paramters 
						.RST_POLARITY(RST_POLARITY),   	
						.RESET_RAM(RESET_RAM), 			
						.RESET_OUTREG(RESET_OUTREG), 	
						.WADDREN_POLARITY(WADDREN_POLARITY),
						.RADDREN_POLARITY(RADDREN_POLARITY),
						
						.WEN_WIDTH(WEN_WIDTH_ROW),
						
						.ini_index(DATA_MAP_INDEX)
								
					) bram (
						//Trion and Titanium ports
						.WCLK(wclk), 	// Write clock input
						.WCLKE(wclke),	// Write clock-enable input
						.WE(w_we), 		// Write-enable input
						.WADDR(w_waddr),  // Write address input
						.WDATA(w_wdata), // Write data input
						
						.RCLK(rclk), 	// Read clock input
						.RE(re), 		// Read-enable input
						.RADDR(w_raddr),  // Read address input
						.RDATA(w_rdata), // Read data output
					
						//Titanium extra ports
						.RST(reset), 	   // reset	
						.WADDREN(waddren), // write address enable
						.RADDREN(raddren)  // read address enable					
					);
				end
			end
			
		end
		else if (bram_table_loop_mode == 1 ) 
		begin:scan_row
			for (gen_y=0; gen_y<bram_table_size; gen_y =gen_y +1)
			begin:row
				localparam bram_mode_a = bram_decompose_table(gen_y,0); 
				localparam bram_mode_b = bram_decompose_table(gen_y,1); 
				localparam column_count = bram_decompose_table(gen_y,2);
			
				localparam WADDR_WIDTH_ROW = bram_feature_table(bram_mode_a,0);
				localparam WDATA_WIDTH_ROW = bram_feature_table(bram_mode_a,1); 
				localparam WEN_WIDTH_ROW   = bram_feature_table(bram_mode_a,2); 
				
				localparam RADDR_WIDTH_ROW = bram_feature_table(bram_mode_b,0);
				localparam RDATA_WIDTH_ROW = bram_feature_table(bram_mode_b,1); 
				
				localparam START_ROW_INDEX = get_current_row_index(gen_y);
				
										
				for (gen_x=0; gen_x<column_count; gen_x =gen_x +1)
				begin:column
					
					localparam DATA_MAP_INDEX = START_ROW_INDEX+gen_x;
										
					localparam WDATA_END     = bram_mapping_table(DATA_MAP_INDEX,2);					
					localparam WDATA_START   = bram_mapping_table(DATA_MAP_INDEX,3);
					localparam WDATA_REPART  = bram_mapping_table(DATA_MAP_INDEX,4);
					localparam WRSEL_INDEX   = bram_mapping_table(DATA_MAP_INDEX,6);
					localparam BYTEEN_INDEX  = bram_mapping_table(DATA_MAP_INDEX,8);
					
					localparam RDATA_END     = bram_mapping_table(DATA_MAP_INDEX,9);
					localparam RDATA_START   = bram_mapping_table(DATA_MAP_INDEX,10);
					localparam RDATA_REPART  = bram_mapping_table(DATA_MAP_INDEX,11);
					localparam RMUX_INDEX    = bram_mapping_table(DATA_MAP_INDEX,12);
					
					
					
					wire [WADDR_WIDTH_ROW-1:0] w_waddr;
					wire [WDATA_WIDTH_ROW-1:0] w_wdata;
					wire [WEN_WIDTH_ROW-1:0]   w_we;

					wire [RADDR_WIDTH_ROW-1:0] w_raddr;
					wire [RDATA_WIDTH_ROW-1:0] w_rdata;
					
					//assign w_waddr[WADDR_WIDTH_ROW-1:0] = w_waddr_map[WADDR_WIDTH_ROW-1:0];
					//assign w_raddr[RADDR_WIDTH_ROW-1:0] = w_raddr_map[RADDR_WIDTH_ROW-1:0];	
                    
					for(gen_z=0;gen_z<WADDR_WIDTH_ROW; gen_z=gen_z+1)
					begin
						if(gen_z< ADDR_WIDTH_A) 
							assign w_waddr[gen_z] = w_waddr_map[gen_z];
						else
							assign w_waddr[gen_z] = 1'b0;
					end
					
					for(gen_z=0;gen_z<RADDR_WIDTH_ROW; gen_z=gen_z+1)
					begin
						if(gen_z< ADDR_WIDTH_B) 
							assign w_raddr[gen_z] = w_raddr_map[gen_z];
						else
							assign w_raddr[gen_z] = 1'b0;			
					
					end
                    
                    
					
					if (WDATA_REPART == 0)
					begin
						assign w_wdata[WDATA_WIDTH_ROW-1:0] = w_wdata_map[WDATA_END:WDATA_START];
					end
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<WDATA_REPART; gen_z = gen_z+1)
						begin:MIXED_WIDTH_MAPPING
							localparam MIXED_WDATA_START =  WDATA_START + gen_z*column_count*(RDATA_END - RDATA_START+1); // RDATA_WIDTH_ROW;
							localparam MIXED_WDATA_END   =  WDATA_END   + gen_z*column_count*(RDATA_END - RDATA_START+1); //RDATA_WIDTH_ROW; 
							
							localparam MAPPED_WDATA_START =  RDATA_WIDTH_ROW* gen_z;
							localparam MAPPED_WDATA_END   =  RDATA_WIDTH_ROW*(gen_z+1) -1; 
							
							
							assign w_wdata[MAPPED_WDATA_END: MAPPED_WDATA_START]  =  w_wdata_map[MIXED_WDATA_END:MIXED_WDATA_START];
						end
					end 
	
					if (RDATA_REPART == 0)
					begin
						assign rMux[RMUX_INDEX][RDATA_END:RDATA_START]   = w_rdata[RDATA_WIDTH_ROW-1:0];
					end 
					else 
					begin
						//for Mixed Width Mode 
						for (gen_z=0; gen_z<RDATA_REPART; gen_z = gen_z+1)
						begin:MIXED_WIDTH_MAPPING
							localparam MIXED_RDATA_START =  RDATA_START + gen_z*column_count*(WDATA_END - WDATA_START+1); //WDATA_WIDTH_ROW;
							localparam MIXED_RDATA_END   =  RDATA_END   + gen_z*column_count*(WDATA_END - WDATA_START+1); //WDATA_WIDTH_ROW; 
							
							localparam MAPPED_RDATA_START =  WDATA_WIDTH_ROW* gen_z;
							localparam MAPPED_RDATA_END   =  WDATA_WIDTH_ROW*(gen_z+1) -1; 
							
							
							assign rMux[RMUX_INDEX][MIXED_RDATA_END:MIXED_RDATA_START]   = w_rdata[MAPPED_RDATA_END:MAPPED_RDATA_START];  
						end					
					end 					
					
					
					
                     
					assign w_we[0] = ((we == WE_POLARITY) & wen_decode[WRSEL_INDEX] & (byteen[BYTEEN_INDEX] == BYTEEN_POLARITY)) ? WE_POLARITY: !WE_POLARITY;;
					if ( WEN_WIDTH_ROW >1)
					begin
						assign w_we[1] = ((we == WE_POLARITY) & wen_decode[WRSEL_INDEX] & (byteen[BYTEEN_INDEX] == BYTEEN_POLARITY)) ? WE_POLARITY: !WE_POLARITY;;
					end 
									
					bram_primitive #(
						.FAMILY(FAMILY),	//0:Trion,  1:Titanium
						
						//Trion and Titanium parameters 
						.WRITE_WIDTH(WDATA_WIDTH_ROW),	
						.WCLK_POLARITY(WCLK_POLARITY), 	
						.WCLKE_POLARITY(WCLKE_POLARITY),
						.WE_POLARITY(WE_POLARITY), 		
						.WRITE_MODE(WRITE_MODE),		
														
						.READ_WIDTH(RDATA_WIDTH_ROW),  
						.RCLK_POLARITY(RCLK_POLARITY), 	
						.RE_POLARITY(RE_POLARITY), 		
						.OUTPUT_REG(OUTPUT_REG),		
						
						//Titanium extra paramters 
						.RST_POLARITY(RST_POLARITY),   	
						.RESET_RAM(RESET_RAM), 			
						.RESET_OUTREG(RESET_OUTREG), 	
						.WADDREN_POLARITY(WADDREN_POLARITY),
						.RADDREN_POLARITY(RADDREN_POLARITY),
						
						.WEN_WIDTH(WEN_WIDTH_ROW),
						
						.ini_index(DATA_MAP_INDEX)
								
					) bram (
						//Trion and Titanium ports
						.WCLK(wclk), 	// Write clock input
						.WCLKE(wclke),	// Write clock-enable input
						.WE(w_we), 		// Write-enable input
						.WADDR(w_waddr),  // Write address input
						.WDATA(w_wdata), // Write data input
						
						.RCLK(rclk), 	// Read clock input
						.RE(re), 		// Read-enable input
						.RADDR(w_raddr),  // Read address input
						.RDATA(w_rdata), // Read data output
					
						//Titanium extra ports
						.RST(reset), 	   // reset	
						.WADDREN(waddren), // write address enable
						.RADDREN(raddren)  // read address enable					
					);
				end
			end
 
		end 
    endgenerate 
 
 
endmodule