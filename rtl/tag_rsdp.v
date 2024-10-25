module tag (u,b,a,y,x,e,clk,ldb, lda, ldx, ldy, lde, innerprod);

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


   reg [6:0] 	    accin;


   reg [6:0] 	    accout, accinv;

   reg [6:0] 	    accunsign;

   wire [7:0] 	    acctmp;


   assign acctmp = {1'b0,accinv} + {1'b0,u};


   always @ (*) begin
          case  (sec[2:0])
	    6: accin <= {ch[0],ch[6:1]};

	    5: accin <= {ch[1:0],ch[6:2]};

	    4: accin <= {ch[2:0],ch[6:3]};

	    3: accin <= {ch[3:0],ch[6:4]};

	    2: accin <= {ch[4:0],ch[6:5]};

	    1: accin <= {ch[5:0],ch[6]};

	    default: accin <= ch[6:0];

	  endcase // case (sec[2:0])

          if (acctmp[7] == 1) begin
	     accout <= acctmp + 1;

	             // -127 in two's complement
	  end
          else begin
	     accout <= acctmp;

	  end

          if (sec[3]) begin
	     accinv <= ~(accin);

	  end
          else begin
	     accinv <= accin;

	  end
   end // always @ (*)

   always @ (posedge clk) begin
          if (lde) begin
	     u <= e;

	  end
          else if (innerprod) begin
	     u <= accout;

	  end

          if (ldb) begin
	     ch <= b;

	  end
          else if (lda) begin
	     ch <= a;

	  end
          else if (innerprod) begin
	     ch <= {ch[6:0],ch[237:7]};

	  end

          if (ldx) begin
	     sec <= x;

	  end
          else if (ldy) begin
	     sec <= y;

	  end
          else if (innerprod) begin
	     sec <= {sec[3:0],sec[135:4]};

	  end
   end // always @ (posedge clk)



   endmodule
