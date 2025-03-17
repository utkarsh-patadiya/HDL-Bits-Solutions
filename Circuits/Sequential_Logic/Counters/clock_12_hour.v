module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    reg [23:0] q;
    assign hh=q[23:16];
    assign mm=q[15:8];
    assign ss=q[7:0];
    always @(posedge clk) begin 
        if (reset) {pm,q}={1'b0,24'h120000};
        //  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _
        //  h  h  h  h  h  h  h  h  m  m  m  m  m  m  m  m  s  s  s  s  s  s  s  s
        // 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0

// Method One
        else begin 
            if (ena) begin 
            if(q==24'h115959) pm=~pm;
	    	    q=q+1;
            end
            if (q[3]&q[1]) q=q+4'h6;
            if (q[6]&q[5]) q=q+8'ha0;
            if (q[11]&q[9]) q=q+11'h600;
            if (q[14]&q[13]) q=q+16'ha000;
            if (q[19]&q[17]) q=q+19'h60000;
            if (q[20]&q[17]&q[16]) q=q+24'hee0000;     
        end

// Method Two
        // else begin 
        //     if (ena) begin 
        //         if(q==24'h115959) pm=~pm;
	    //         q=q+1;
        //     end
        //     if (q==24'h12595a) q=24'h010000;
        //     if (q[19:0]==20'h9595a) q=24'h100000;    
        //     if (q[15:0]==16'h595a) q={q[23:16]+1'b1,16'h0000};  
        //     if (q[11:0]==12'h95a) q={q[23:12]+1'b1,12'h000};  
        //     if (q[7:0]==8'h5a) q={q[23:8]+1'b1,8'h00};  
        //     if (q[3:0]==4'ha) q={q[23:4]+1'b1,4'h0};  
        // end
	end
endmodule
