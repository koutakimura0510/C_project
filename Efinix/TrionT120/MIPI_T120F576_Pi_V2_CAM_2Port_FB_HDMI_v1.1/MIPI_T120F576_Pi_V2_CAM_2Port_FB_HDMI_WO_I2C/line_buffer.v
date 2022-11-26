module line_buffer
#(
	parameter	P_DEPTH			= 10,
	parameter	PW				= P_DEPTH*2,	
	parameter	X_CNT_WIDTH		= 13
)
(
	input	i_arstn,
	input	i_pclk,
	
	input	i_vsync,
	input	i_hsync,
	input	i_de,
	input	[PW-1:0]i_p,
	
	output	o_vsync,
	output	o_hsync,
	output	o_de,
	output	[PW-1:0]o_p_11,
	output	[PW-1:0]o_p_00,	
	output	[PW-1:0]o_p_01,
	
	output	[X_CNT_WIDTH-1:0]o_x
);

localparam	HOR_SYNC_POLARITY	= "POSITIVE";
localparam	VER_SYNC_POLARITY	= "POSITIVE";
wire	c_act_vs_por;
wire	c_ina_vs_por;
wire	c_act_hs_por;
wire	c_ina_hs_por;
wire	c_act_de_por;
wire	c_ina_de_por;

reg		r_vsync_1P;
reg		r_hsync1_1P;
reg		r_hsync2_1P;
reg		r_de_1P;
reg		[X_CNT_WIDTH-1:0]r_addr1;
reg		r_addr1_sel;
reg		[X_CNT_WIDTH-1:0]r_addr2;
reg		r_addr2_sel;
reg		r_vsync_2P;
reg		r_hsync1_2P;
reg		r_hsync2_2P;
reg		r_de_2P;
reg		[X_CNT_WIDTH-1:0]r_addr2_2P;
reg		r_vsync_3P;
reg		r_hsync2_3P;
reg		r_de_3P;
reg		r_vsync_4P;
reg		r_hsync2_4P;
reg		r_de_4P;

reg		[PW-1:0]r_p_01_0P;
reg		[PW-1:0]r_p_01_1P;
reg		[PW-1:0]r_p_01_2P;
reg		[PW-1:0]r_p_01_3P;
wire	[PW-1:0]w_p_11_1P;
wire	[PW-1:0]w_p_00_1P;
reg		[PW-1:0]r_p_00_2P;
reg		[PW-1:0]r_p_00_3P;

generate
	if (HOR_SYNC_POLARITY == "NEGATIVE")
	begin
		assign	c_act_hs_por	= 1'b0;
		assign	c_ina_hs_por	= 1'b1;
	end
	else
	begin
		assign	c_act_hs_por	= 1'b1;
		assign	c_ina_hs_por	= 1'b0;
	end
	
	if (VER_SYNC_POLARITY == "NEGATIVE")
	begin
		assign	c_act_vs_por	= 1'b0;
		assign	c_ina_vs_por	= 1'b1;
	end
	else
	begin
		assign	c_act_vs_por	= 1'b1;
		assign	c_ina_vs_por	= 1'b0;
	end
endgenerate

assign	c_act_de_por	= 1'b1;
assign	c_ina_de_por	= 1'b0;

/* Dual port RAM for 2 lines buffer */
true_dual_port_ram
#(
	.DATA_WIDTH(PW),
	.ADDR_WIDTH(X_CNT_WIDTH + 1),
	.WRITE_MODE_1("READ_FIRST"),
	.WRITE_MODE_2("READ_FIRST"),
	.OUTPUT_REG_1("FALSE"),
	.OUTPUT_REG_2("FALSE"),
	.RAM_INIT_FILE("")
)
inst_y_buffer
(
	.we1	(1'b1					),
	.clka	(i_pclk					),
	.din1	(r_p_01_0P				),
	.addr1	({r_addr1_sel, r_addr1}	),
	.dout1	(w_p_11_1P				),
	
	.we2	(1'b0					),
	.clkb	(i_pclk					),
	.din2	(r_p_01_0P				),
	.addr2	({r_addr2_sel, r_addr2}	),
	.dout2	(w_p_00_1P				)
);

/* Resync data count and insert sync delay */
always@(posedge i_pclk)
begin
	if (~i_arstn)
	begin
		r_vsync_1P		<= c_ina_vs_por;
		r_hsync1_1P		<= c_ina_hs_por;
		r_hsync2_1P		<= c_ina_hs_por;
		r_de_1P			<= c_ina_de_por;
		r_p_01_0P		<= {PW{1'b0}};
		r_addr1		<= {X_CNT_WIDTH{1'b0}};
		r_addr1_sel	<= 1'b0;
		r_addr2		<= {X_CNT_WIDTH{1'b0}};
		r_addr2_sel	<= 1'b1;
		
		r_vsync_2P		<= c_ina_vs_por;
		r_hsync1_2P		<= c_ina_hs_por;
		r_hsync2_2P		<= c_ina_hs_por;
		r_de_2P			<= c_ina_de_por;
		r_p_01_1P		<= {PW{1'b0}};
	end
	else
	begin
		r_vsync_1P		<= i_vsync;
		r_hsync1_1P		<= i_hsync;
		r_hsync2_1P		<= i_hsync;
		r_de_1P			<= i_de;
		r_p_01_0P		<= i_p;
		
		if (i_de)
		begin
			r_addr1		<= r_addr1+1'b1;
			r_addr2		<= r_addr2+1'b1;	
		end
		else
		begin
			r_addr1		<= {X_CNT_WIDTH{1'b0}};
			r_addr2		<= {X_CNT_WIDTH{1'b0}};
		end
						
		if (!r_de_1P && r_de_2P)
		begin
			r_addr1_sel	<= ~r_addr1_sel;
			r_addr2_sel	<= ~r_addr2_sel;
		end
		
		if (r_vsync_2P && !r_vsync_1P)
		begin
			r_p_01_0P		<= {PW{1'b0}};
			r_addr1		<= {X_CNT_WIDTH{1'b0}};
			r_addr1_sel	<= 1'b0;
			r_addr2		<= {X_CNT_WIDTH{1'b0}};
			r_addr2_sel	<= 1'b1;
		end
		
		r_vsync_2P		<= r_vsync_1P;
		r_hsync1_2P		<= r_hsync1_1P;
		r_hsync2_2P		<= r_hsync2_1P;
		r_de_2P			<= r_de_1P;
		r_p_01_1P		<= r_p_01_0P;
		r_p_01_2P		<= r_p_01_1P;
		r_p_01_3P		<= r_p_01_2P;
		
		r_p_00_2P		<= w_p_00_1P;
		r_p_00_3P		<= r_p_00_2P;
		
		r_addr2_2P		<= r_addr2;
		
		r_vsync_3P		<= r_vsync_2P;
		r_de_3P			<= r_de_2P;
		r_hsync2_3P		<= r_hsync2_2P;
		r_vsync_4P		<= r_vsync_3P;
		r_de_4P			<= r_de_3P;
		r_hsync2_4P		<= r_hsync2_3P;
	end
end

assign	o_vsync	= r_vsync_2P;
assign	o_hsync	= r_hsync1_2P;
assign	o_de	= r_de_2P;
assign	o_p_11	= w_p_11_1P[PW-1:0];
assign	o_p_00	= w_p_00_1P[PW-1:0];
assign	o_p_01	= r_p_01_1P[PW-1:0];
assign	o_x		= {r_addr2_2P};

endmodule
