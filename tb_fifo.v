module tb_parameterized_fifo;

reg clk, reset;
reg [7:0] din;
reg read_en, write_en;
wire full, empty;
wire [7:0] dout;

parameterized_fifo m1 (
    clk, 
    reset, 
    din, 
    write_en, 
    read_en , 
    dout,
    full,
    empty
);


initial clk = 0;
always #5 clk = ~clk;

initial
begin
    $display("STARTING SIMULATION");
    reset = 1; #20;
    reset = 0; #20;
    @(posedge clk)
    write_en = 1;
    din = 8'h0; $display("write value: %b", din);
    @(posedge clk)
    din = 8'h1; $display("write value: %b", din);
    @(posedge clk)
    din = 8'h2; $display("write value: %b", din);
    @(posedge clk)
    din = 8'h3; $display("write value: %b", din);
    @(posedge clk)
    din = 8'h4; $display("write value: %b", din);
    @(posedge clk)
    din = 8'h5; $display("write value: %b", din);
    @(posedge clk)
    din = 8'h6; $display("write value: %b", din);
    @(posedge clk)
    write_en = 0;
    

    read_en = 1;   
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    @(posedge clk)
    $display("output: %b \t full: %b \t empty: %b", dout, full, empty);
    $display("SIMULATION FINISHED");
    $finish;
end

endmodule