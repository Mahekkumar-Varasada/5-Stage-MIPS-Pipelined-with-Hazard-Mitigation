module mux3x1#(parameter width= 32)
(input [(width-1):0]d0,
 input [(width-1):0]d1,
 input [(width-1):0]d2,
 input [1:0]s,
 output [(width-1):0]y);
 
 assign y = ((s==2'b00)? d0:
            (s==2'b01)? d1:
				(d2)); 
 
 endmodule
 