// Predictive 5-level risk classifier
// Verilog-2001 compatible
module risk_classifier #(
    parameter WARNING_LIMIT  = 12'd1800,
    parameter DANGER_LIMIT   = 12'd2400,
    parameter CRITICAL_LIMIT = 12'd3000,
    parameter FAULT_LIMIT    = 12'd3600
) (
    input [11:0] current_in,
    input [11:0] predicted_current,
    input signed [12:0] delta_i,
    output reg [2:0] risk_level
);

    localparam SAFE     = 3'd0;
    localparam WARNING  = 3'd1;
    localparam DANGER   = 3'd2;
    localparam CRITICAL = 3'd3;
    localparam FAULT    = 3'd4;

    reg [11:0] effective_current;

    always @(*) begin
        // Use the larger of present and predicted current so that
        // a rising trend can increase risk before the hard threshold.
        if (predicted_current > current_in)
            effective_current = predicted_current;
        else
            effective_current = current_in;

        if (current_in >= FAULT_LIMIT || predicted_current >= FAULT_LIMIT)
            risk_level = FAULT;
        else if (current_in >= CRITICAL_LIMIT || predicted_current >= CRITICAL_LIMIT)
            risk_level = CRITICAL;
        else if (current_in >= DANGER_LIMIT || predicted_current >= DANGER_LIMIT)
            risk_level = DANGER;
        else if (effective_current >= WARNING_LIMIT)
            risk_level = WARNING;
        else
            risk_level = SAFE;
    end

endmodule
