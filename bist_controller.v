module bist_controller #(
    parameter BIST_CYCLES = 4
) (
    input clk,
    input reset,
    input sensor_valid,

    output reg bist_done,
    output reg bist_fail,
    output reg bist_active
);

    reg [3:0] count;

   always @(posedge clk or posedge reset) begin

        if (reset) begin
            count       <= 4'd0;
            bist_done   <= 1'b0;
            bist_fail   <= 1'b0;
            bist_active <= 1'b1;
        end
        else if (bist_active) begin
            if (count != 0) begin
                if (!sensor_valid)
                    bist_fail <= 1'b1;
            end

            if (count < BIST_CYCLES) begin
                count <= count + 1'b1;
            end
            else begin
                // FIX: Permanently lock counter values at expiration boundaries to prevent wrap-around bugs
                count       <= count; 
                bist_active <= 1'b0;
                bist_done   <= 1'b1;
            end
        end
    end

endmodule
