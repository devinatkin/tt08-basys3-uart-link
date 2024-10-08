module circular_shift_register #(
    parameter WIDTH = 8,        // Width of each register
    parameter SIZE = 16         // Number of registers
) (
    input logic clk,            // Clock input
    input logic rst_n,          // Active low reset input
    output logic [WIDTH*SIZE-1:0] reg_out // Output register array
);

    logic [WIDTH-1:0] circ_reg [SIZE-1:0]; // Register array definition


    // Always block triggered by a positive edge of the clock
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the register array to the initial state
            circ_reg[0]  <= 8'h00;
            circ_reg[1]  <= 8'h00;
            circ_reg[2]  <= 8'h00;
            circ_reg[3]  <= 8'h00;
            circ_reg[4]  <= 8'h10;
            circ_reg[5]  <= 8'h20;
            circ_reg[6]  <= 8'h40;
            circ_reg[7]  <= 8'hFF;
            circ_reg[8]  <= 8'hFF;
            circ_reg[9]  <= 8'h40;
            circ_reg[10] <= 8'h20;
            circ_reg[11] <= 8'h10;
            circ_reg[12] <= 8'h00;
            circ_reg[13] <= 8'h00;
            circ_reg[14] <= 8'h00;
            circ_reg[15] <= 8'h00;

        end else begin
            // Circularly shift the register array
            for (int i = 0; i < SIZE-1; i++) begin
                circ_reg[i+1] <= circ_reg[i];

            end
            circ_reg[0] <= circ_reg[SIZE-1]; // Wrap around the last element
        end
    end

genvar i;
        generate
            for (i = 0; i < SIZE; i++) begin
                assign reg_out[WIDTH*i +: WIDTH] = circ_reg[i];
            end
        endgenerate

    
endmodule
