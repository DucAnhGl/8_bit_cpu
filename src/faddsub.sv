module faddsub(
input logic [8:0] a_9,b_9,
input logic sel,
output logic [8:0] result_9,
output logic z
);
logic [3:0] exp_diff;
logic [4:0] fraction;
logic [2:0] final_exp;
logic [3:0] bigger_fract, smaller_fract;
logic [5:0] temp_fract, shift_smaller_fract;
int i;

logic [7:0] a;
logic [7:0] b;
logic [7:0] result; 

assign a = a_9[7:0];
assign b = b_9[7:0];
assign result_9 = {1'b0, result};

always_comb begin
exp_diff = a[6:4] - b[6:4];
fraction = a[3:0] - b[3:0];
// Get smaller number, fraction
if(!exp_diff) begin
final_exp = b[6:4];
if(fraction[4]) begin // fract b > fract a
bigger_fract = b[3:0];
smaller_fract = a[3:0];
if(!sel)
result[7] = b[7];
else
result[7] = ~b[7];
end
else begin
bigger_fract = a[3:0]; //fract a > fract b
smaller_fract = b[3:0];
result[7] = a[7];
end
end
else begin
if(exp_diff[3]) begin //fract b > fract a
final_exp = b[6:4];
exp_diff = -exp_diff;
bigger_fract = b[3:0];
smaller_fract = a[3:0];
if(!sel)
result[7] = b[7];
else
result[7] = ~b[7];
end
else begin //fract a > b
final_exp = a[6:4];
bigger_fract = a[3:0];
smaller_fract = b[3:0];
result[7] = a[7];
end
end
//shift number that smaller
shift_smaller_fract = {1'b1, smaller_fract} >> exp_diff;
//calculate fraction
if(sel)
temp_fract = {1'b1,bigger_fract} + ((a[7] ^ b[7])? shift_smaller_fract: (- shift_smaller_fract));
else
temp_fract = {1'b1,bigger_fract} + ((a[7] ^ b[7])? (-shift_smaller_fract): shift_smaller_fract);
//shift back to result
for(i = 5; i >= 0; i--) begin
if(temp_fract[i]) begin
break;
end
end
if(i == 5 && temp_fract[5]) begin
result[3:0] = temp_fract[4:1];
final_exp += 3'b1;
end
else if(i < 5 && temp_fract != 0) begin
temp_fract <<= (4 - i);
final_exp -= (4 - i);
result[3:0] = temp_fract[3:0];
end
else begin
result[3:0] = temp_fract[3:0];
final_exp = 3'b0;
end
result[6:4] = final_exp;
z = (!result[6:0])? 1'b1:1'b0;
end
endmodule : faddsub
