module tagby2 (u,b,a,y,x,e,clk,ldb, lda, ldx, ldy, lde, innerprod);

   output reg [6:0] u;

   input [237:0]    b;

   input [237:0]    a;

   input [135:0]    y;

   input [135:0]    x;

   input [6:0] 	    e;

   input 	    clk, ldb, lda, ldx, ldy, lde, innerprod;


   reg [237:0] 	    ch;

   reg [135:0] 	    sec;

   reg [6:0] 	    er;

   reg [6:0] 	    u;


   reg [6:0] 	    accin [1:0];


   reg [6:0] 	    accout[1:0], accinv[1:0];

   reg [6:0] 	    accunsign;

   wire [7:0] 	    acctmp[1:0];


   assign acctmp[0] = {1'b0,accinv[0]} + {1'b0,u};
   assign acctmp[1] = {1'b0,accinv[1]} + {1'b0,accout[0]};


   always @ (*) begin
      case  (sec[2:0])
	6: accin[0] <= {ch[0],ch[6:1]};

	5: accin[0] <= {ch[1:0],ch[6:2]};

	4: accin[0] <= {ch[2:0],ch[6:3]};

	3: accin[0] <= {ch[3:0],ch[6:4]};

	2: accin[0] <= {ch[4:0],ch[6:5]};

	1: accin[0] <= {ch[5:0],ch[6]};

	default: accin[0] <= ch[6:0];

      endcase // case (sec[2:0])

      case  (sec[6:4])
	6: accin[1] <= {ch[0+7],ch[6+7:1+7]};


	5: accin[1] <= {ch[1+7:0+7],ch[6+7:2+7]};


	4: accin[1] <= {ch[2+7:0+7],ch[6+7:3+7]};


	3: accin[1] <= {ch[3+7:0+7],ch[6+7:4+7]};


	2: accin[1] <= {ch[4+7:0+7],ch[6+7:5+7]};


	1: accin[1] <= {ch[5+7:0+7],ch[6+7]};


	default: accin[1] <= ch[6+7:0+7];


      endcase // case (sec[2:0])~

      if (acctmp[0][7] == 1) begin
	 accout[0] <= acctmp[0] + 1;

	 // -127 in two's complement
      end
      else begin
	 accout[0] <= acctmp[0];

      end

      if (acctmp[1][7] == 1) begin
	 accout[1] <= acctmp[1] + 1;
	 // -127 in two's complement
      end
      else begin
	 accout[1] <= acctmp[1];
      end

      if (sec[3]) begin
	 accinv[0] <= ~(accin[0]);

      end
      else begin
	 accinv[0] <= accin[0];

      end
      if (sec[7]) begin
	 accinv[1] <= ~(accin[1]);
      end
      else begin
	 accinv[1] <= accin[1];
      end
   end // always @ (*)

   always @ (posedge clk) begin
      if (lde) begin
	 u <= e;

      end
      else if (innerprod) begin
	 u <= accout[1];
      end

      if (ldb) begin
	 ch <= b;

      end
      else if (lda) begin
	 ch <= a;

      end
      else if (innerprod) begin
	 ch <= {ch[13:0],ch[237:14]};

      end

      if (ldx) begin
	 sec <= x;

      end
      else if (ldy) begin
	 sec <= y;

      end
      else if (innerprod) begin
	 sec <= {sec[7:0],sec[135:8]};

      end
   end // always @ (posedge clk)



endmodule
