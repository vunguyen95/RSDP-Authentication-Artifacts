module tag_rsdp_unroll (u,b,y,clk,innerprod,ldb,ldy);

   output reg [6:0] u;
   
   input [237:0]    b;
   input [135:0]    y;

   input 	    clk, innerprod, ldb, ldy;

   reg [237:0] 	    rot, inv;

   reg [7:0] 	    accl1 [17:0];
   reg [7:0] 	    accl2 [8:0];
   reg [7:0] 	    accl3 [4:0];
   reg [7:0] 	    accl4 [2:0];
   reg [7:0] 	    accl5 [1:0];
   reg [7:0] 	    accl6;

   reg [6:0] 	    modl0 [33:0];
   reg [6:0] 	    modl1 [17:0];
   reg [6:0] 	    modl2 [8:0];
   reg [6:0] 	    modl3 [4:0];
   reg [6:0] 	    modl4 [2:0];
   reg [6:0] 	    modl5 [1:0];
   reg [6:0] 	    modl6;

   reg [135:0] 	    sec;
   reg [237:0] 	    ch;

   genvar 	    i;

   generate
      for (i = 0; i < 34; i = i + 1) begin:product_loop
	 always @ (*) begin

	    case (sec[2+4*i:4*i]) 
	      6: begin
		 rot[7*i+6:7*i] <= {ch[4*i],ch[6+4*i:1+4*i]};
	      end
	      5: begin
		 rot[7*i+6:7*i] <= {ch[1+4*i:4*i],ch[6+4*i:2+4*i]};
	      end
	      4: begin
		 rot[7*i+6:7*i] <= {ch[2+4*i:4*i],ch[6+4*i:3+4*i]};
	      end
	      3: begin
		 rot[7*i+6:7*i] <= {ch[3+4*i:4*i],ch[6+4*i:4+4*i]};
	      end
	      2: begin
		 rot[7*i+6:7*i] <= {ch[4+4*i:4*i],ch[6+4*i:5+4*i]};
	      end
	      1: begin
		 rot[7*i+6:7*i] <= {ch[5+4*i:4*i],ch[6+4*i]};
	      end
	      default: begin
		 rot[7*i+6:7*i] <= ch[6+4*i:4*i];
	      end
	    endcase // case (sec[2+4*i:4*i])
	    if (sec[3+4*i]) begin
	       inv[7*i+6:7*i] <= ~rot[7*i+6:7*i];
	    end
	    else begin
	       inv[7*i+6:7*i] <= rot[7*i+6:7*i];
	    end

	    modl0[i] <= inv[7*i+6:7*i];
	 end // always @ begin
	 
      end // block: product_loop
      
      for (i = 0; i < 18; i = i + 1) begin:l1_loop
	 always @ (*) begin
	    accl1[i] <= {1'b0,modl0[2*i]}+{1'b0,modl0[2*i+1]};
	    modl1[i] <= accl1[i][7] ? accl1[i][6:0]+1 : accl1[i];
	 end
      end

      for (i = 0; i < 8; i = i + 1) begin:l2_loop
	 always @ (*) begin
	    accl2[i] <= {1'b0,modl1[2*i]}+{1'b0,modl1[2*i+1]};
	    modl2[i] <= accl2[i][7] ? accl2[i][6:0]+1 : accl2[i];
	 end
      end
      always @ (*) begin
	 modl2[8] <= modl1[17];
      end

      for (i = 0; i < 4; i = i + 1) begin:l3_loop
	 always @ (*) begin
	    accl3[i] <= {1'b0,modl2[2*i]}+{1'b0,modl2[2*i+1]};
	    modl3[i] <= accl3[i][7] ? accl3[i][6:0]+1 : accl3[i];
	 end
      end
      always @ (*) begin
	 modl3[4] <= modl2[8];
      end

      for (i = 0; i < 2; i = i + 1) begin:l4_loop
	 always @ (*) begin
	    accl4[i] <= {1'b0,modl3[2*i]}+{1'b0,modl3[2*i+1]};
	    modl4[i] <= accl4[i][7] ? accl4[i][6:0]+1 : accl4[i];
	 end
      end
      always @ (*) begin
	 modl4[2] <= modl3[4];
      end

      always @ (*) begin
	 accl5[0] <= {1'b0,modl4[0]}+{1'b0,modl4[1]};
	 modl5[0] <= accl5[0][7] ? accl5[0][6:0]+1 : accl5[0];
	 modl5[1] <= modl4[2];
	 
	 accl6 <= {1'b0,modl5[0]}+{1'b0,modl5[1]};
	 modl6 <= accl6[7] ? accl6[6:0]+1 : accl6;
      end
      
   endgenerate

   always @ (posedge clk) begin
      if (innerprod) begin
	 u <= modl6;
      end

      if (ldb) begin
	 ch <= b;
      end
      
      if (ldy) begin
	 sec <= y;
      end

   end // always @ (posedge clk)
   
endmodule
