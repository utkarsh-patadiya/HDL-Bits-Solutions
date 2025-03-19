module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
); 
    reg [17:0] grid[17:0];
    integer i;
    integer m;
    integer n;
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i+1][16:1] <= data[(i*16) +: 16]; 
            end
        end
        else begin 
            for (m = 1; m < 17; m = m + 1) begin
                for (n = 1; n < 17; n = n + 1) begin
                    case(grid[m+1][n+1]+grid[m+1][n]+grid[m+1][n-1]+grid[m][n+1]+grid[m][n-1]+grid[m-1][n+1]+grid[m-1][n]+grid[m-1][n-1])
                        4'h3:grid[m][n]<=1;
                        4'h2:grid[m][n]<=grid[m][n];
                        default:grid[m][n]<=0;
                    endcase
                end
            end
        end
    end

    integer k;
    always @(*) begin 
        grid[17]<={grid[1][1],grid[1][16:1],grid[1][16]};
        grid[0]<={grid[16][1],grid[16][16:1],grid[16][16]};
        for (k = 1; k < 17; k = k + 1) begin 
            grid[k][17] <= grid[k][1];
            grid[k][0] <= grid[k][16]; 
        end
    end

    assign q = {grid[16][16:1], grid[15][16:1], grid[14][16:1], grid[13][16:1], grid[12][16:1], grid[11][16:1], grid[10][16:1],
                grid[9][16:1], grid[8][16:1], grid[7][16:1], grid[6][16:1], grid[5][16:1], grid[4][16:1],
                grid[3][16:1], grid[2][16:1], grid[1][16:1]};  
endmodule
ECHO is on.
