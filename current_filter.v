module current_filter (
    input        clk,
    input        reset,
    input [11:0] current_in,
    output reg [11:0] filtered_current
);

    reg [11:0] s0, s1, s2, s3;
    wire [13:0] sample_sum;

    assign sample_sum = {2'b00, s0} + {2'b00, s1} +
                        {2'b00, s2} + {2'b00, s3};

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            s0               <= 12'd0;
            s1               <= 12'd0;
            s2               <= 12'd0;
            s3               <= 12'd0;
            filtered_current <= 12'd0;
        end
        else begin
            s3 <= s2;
            s2 <= s1;
            s1 <= s0;
            s0 <= current_in;

            filtered_current <= sample_sum[13:2];
        end
    end

endmodule
