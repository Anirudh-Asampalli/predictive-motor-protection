module fault_classifier (
    input emergency_current_fault,
    input thermal_fault,
    input voltage_fault,
    input sensor_fault,
    input stall_fault,
    input persistent_fault,

    output reg fault,
    output reg [3:0] fault_code
);

    // Fixed Priority Allocations to match specifications exactly:
    // 1 sensor -> Code 1
    // 2 emergency current -> Code 2
    // 3 thermal -> Code 3
    // 4 stall -> Code 4
    // 5 voltage -> Code 5
    // 6 persistent overload -> Code 6
    always @(*) begin
        fault      = 1'b0;
        fault_code = 4'd0;

        if (sensor_fault) begin
            fault      = 1'b1;
            fault_code = 4'd1; // FIX: Aligned numerical assignments with system maps
        end
        else if (emergency_current_fault) begin
            fault      = 1'b1;
            fault_code = 4'd2; // FIX
        end
        else if (thermal_fault) begin
            fault      = 1'b1;
            fault_code = 4'd3; // FIX
        end
        else if (stall_fault) begin
            fault      = 1'b1;
            fault_code = 4'd4; // FIX
        end
        else if (voltage_fault) begin
            fault      = 1'b1;
            fault_code = 4'd5; // FIX
        end
        else if (persistent_fault) begin
            fault      = 1'b1;
            fault_code = 4'd6; // FIX
        end
    end

endmodule
