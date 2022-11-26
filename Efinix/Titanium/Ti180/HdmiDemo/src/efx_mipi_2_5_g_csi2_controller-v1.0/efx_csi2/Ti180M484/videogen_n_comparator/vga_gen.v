module vga_gen
#(
	parameter H_SyncPulse	= 96,           
	parameter H_BackPorch	= 48,  	          
	parameter H_ActivePix	= 640,	           
	parameter H_FrontPorch	= 16,
	parameter V_SyncPulse	= 2,
	parameter V_BackPorch	= 33,
	parameter V_ActivePix	= 480,
	parameter V_FrontPorch	= 10,
	parameter FIFO_WIDTH	= 11,
	parameter P_Cnt			= 1
)
(
	input	in_pclk,
	input	in_rstn,
	
	output 	[FIFO_WIDTH-1:0]	out_x,
	output 	[FIFO_WIDTH-1:0]	out_y,
	output 			            out_valid,
	output 			            out_de,
	output 			            out_hs,
	output 			            out_vs
);

wire [FIFO_WIDTH-1:0] LinePeriod	= H_SyncPulse + H_BackPorch + H_ActivePix +	H_FrontPorch;
wire [FIFO_WIDTH-1:0] Hde_Start		= H_SyncPulse + H_BackPorch;
wire [FIFO_WIDTH-1:0] Hde_End		= H_SyncPulse + H_BackPorch + H_ActivePix;
wire [FIFO_WIDTH-1:0] FramePeriod	= V_SyncPulse + V_BackPorch + V_ActivePix +	V_FrontPorch;
wire [FIFO_WIDTH-1:0] Vde_Start		= V_SyncPulse + V_BackPorch;
wire [FIFO_WIDTH-1:0] Vde_End		= V_SyncPulse + V_BackPorch + V_ActivePix;

/* VGA counter for the output display sync signals generator */
reg [FIFO_WIDTH-1:0] r_x_cnt;
reg [FIFO_WIDTH-1:0] r_y_cnt;
reg [FIFO_WIDTH-1:0] r_x_active_1P;
reg [FIFO_WIDTH-1:0] r_y_active_1P;
reg [FIFO_WIDTH-1:0] r_x_active_2P;
reg [FIFO_WIDTH-1:0] r_y_active_2P;
reg [2:0] 	r_p_cnt;
reg			r_de_vs;
reg			r_vs;
reg			r_de;
reg			r_hs;
reg			r_de_1P;
reg			r_hs_1P;
reg			r_vs_1P;
reg			r_valid_1P;
reg			r_de_2P;
reg			r_hs_2P;
reg			r_vs_2P;
reg			r_valid_2P;

/* VGA counter for the output display sync signals generator */
/* r_x_cnt for HSYNC and DEN */  
always @ (posedge in_pclk)
begin
	if(~in_rstn)
	begin    
		r_x_cnt			<= {FIFO_WIDTH{1'b0}};
		r_x_active_1P	<= {FIFO_WIDTH{1'b0}};
		r_y_active_1P	<= {FIFO_WIDTH{1'b0}};
		r_x_active_2P	<= {FIFO_WIDTH{1'b0}};
		r_y_active_2P	<= {FIFO_WIDTH{1'b0}};
		r_p_cnt			<= 3'd1;
		r_de			<= 1'b0;
		r_hs			<= 1'b0;
		r_de_1P			<= 1'b0;
		r_hs_1P			<= 1'b0;
		r_valid_1P		<= 1'b0;
		r_vs_1P			<= 1'b0;
		r_de_2P			<= 1'b0;
		r_hs_2P			<= 1'b0;
		r_valid_2P		<= 1'b0;
		r_vs_2P			<= 1'b0;
	end	
	else
	begin
		r_de_1P			<= r_de;
	    r_hs_1P			<= r_hs;
		r_vs_1P			<= r_vs;
		r_de_2P			<= r_de_1P;
	    r_hs_2P			<= r_hs_1P;
		r_vs_2P			<= r_vs_1P;
		r_valid_2P		<= r_valid_1P;
		r_x_active_2P	<= r_x_active_1P;
		
		if (r_de_1P)
			r_y_active_2P	<= r_y_active_1P;
		else
			r_y_active_2P	<= {FIFO_WIDTH{1'b0}};
			
		if(r_x_cnt == LinePeriod - 1'b1)
		begin
			r_x_cnt		<= {FIFO_WIDTH{1'b0}};
			r_hs 	<= 1'b0;
		end
		else
			r_x_cnt <= r_x_cnt + 1'b1;
		
		if (r_x_cnt == H_SyncPulse - 1'b1) 
            r_hs <= 1'b1;
		
		if (r_de_vs)
		begin
			if(r_x_cnt == (Hde_End - 1'b1))
				r_de	<= 1'b0;
			else if(r_x_cnt == Hde_Start - 1'b1)
				r_de	<= 1'b1;
		end
		else
			r_de 			<= 1'b0;
			
		if (r_de)
		begin
			if (r_p_cnt == P_Cnt)
			begin
				r_valid_1P		<= 1'b1;
				r_p_cnt			<= 3'd1;
			end
			else
			begin
				r_valid_1P	<= 1'b0;
				r_p_cnt		<= r_p_cnt + 1'b1;
			end
		end
		else
		begin
			r_valid_1P	<= 1'b0;
			r_p_cnt		<= 3'd1;
		end
		
		if	(r_valid_1P)
			r_x_active_1P	<= r_x_active_1P + 1'b1;
			
		if (~r_de)
			r_x_active_1P	<= {FIFO_WIDTH{1'b0}};
		
		if (!r_de && r_de_1P)
		begin
			if (r_y_active_1P == V_ActivePix - 1'b1)		
				r_y_active_1P	<= {FIFO_WIDTH{1'b0}};
			else
				r_y_active_1P	<= r_y_active_1P + 1'b1;
		end
	end
end
   
/* r_y_cnt for VSYNC */  
always @ (posedge in_pclk) 
begin
	if(~in_rstn)
	begin
        r_y_cnt <= {FIFO_WIDTH{1'b0}};
		r_vs 	<= 1'b0;
	end
    else
	begin
		if(r_x_cnt == LinePeriod - 1'b1) 
		begin
			if (r_y_cnt == FramePeriod - 1'b1)
			begin
				r_y_cnt <= {FIFO_WIDTH{1'b0}};
				r_vs <= 1'b0;
			end
			else
				r_y_cnt <= r_y_cnt + 1'b1;		
		end
		
		if((r_y_cnt == V_SyncPulse - 1'b1) && (r_x_cnt == LinePeriod - 1'b1))
			r_vs <= 1'b1;
	end
end
      
always @ (posedge in_pclk)
begin
	if(~in_rstn) 
	begin
		r_de_vs <= 1'b0;		
	end
	else 
	begin		
		if(r_y_cnt == Vde_Start)
			r_de_vs <= 1'b1;  	
		else if(r_y_cnt == Vde_End)
			r_de_vs <= 1'b0;
	end
end

assign	out_x		= r_x_active_2P;
assign	out_y		= r_y_active_2P;
assign	out_valid	= r_valid_2P;
assign	out_de		= r_de_2P;
assign	out_hs		= r_hs_2P;
assign	out_vs		= r_vs_2P;
endmodule
