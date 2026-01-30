module parameterized_fifo  (clk, reset, din, write_en, read_en , dout, full, empty);
    //initializing width and depth of the fifo buffer
    parameter width = 8;
    parameter depth = 16;
    parameter addr_width = $clog2(depth);
    //port declaration
    input [width-1:0]din;
    input clk, reset, write_en, read_en;
    output full, empty;
    output [width-1:0]dout;

    //storage array initialization
    reg [width-1:0] fifo_mem[0:depth-1];
    reg [addr_width:0] w_ptr; //wptr and rptr is log2(16) = 4; 1 bit extra to adress full condition
    reg [addr_width:0] r_ptr;

    always @(posedge clk or posedge reset)
    begin
        if  (reset)
            w_ptr <= 0; //using non-blocking assignment as sequential logic
        else if (write_en && !full)
            begin
            fifo_mem[w_ptr[addr_width-1:0]] <= din;
            w_ptr <= w_ptr+1;
        end
    end     

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            r_ptr <= 0;
        else if (read_en && !empty)
        begin 
            r_ptr <= r_ptr+1;
        end
    end

    assign dout = fifo_mem[r_ptr[addr_width-1:0]];
    assign empty = r_ptr == w_ptr;
    assign full = (~w_ptr[addr_width] == r_ptr[addr_width] && w_ptr[addr_width-1:0] == r_ptr[addr_width-1:0]);
endmodule