module trend_detector (
    input clk,
    input reset,
    input [11:0] current_in,
    output reg signed [12:0] delta_i,
    output reg [11:0] previous_current
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            previous_current <= 12'd0;
            delta_i <= 13'sd0;
        end
        else begin
            delta_i <= $signed({1'b0,current_in}) -
                       $signed({1'b0,previous_current});
            previous_current <= current_in;
        end
    end

endmodule
