module ALU_TB ();
     
parameter width = 4;

reg full_adder;
reg [width : 0] A , B;
reg Cin , red_A , red_B , bypass_A , bypass_B;
reg [2:0] opcode;
wire [width*2 : 0] out;
wire odd_parity , invalid;

reg [width*2 : 0] out_exp;
reg invalid_exp;
reg odd_parity_exp;

ALU #(.width(width)) DUT ( .full_adder(full_adder) , .A(A) , .B(B) , .Cin(Cin) , .red_A(red_A) , .red_B(red_B) ,
.bypass_A(bypass_A) , .bypass_B(bypass_B) , .opcode(opcode) , .out(out) ,
.odd_parity(odd_parity) , .invalid(invalid));

integer i;

initial 
begin

for (i = 0 ; i<15 ; i = i+1)
begin
    
#15

// block 1.1
opcode = $random;
bypass_A = 1;
bypass_B = 0;
A = $random;
B = $random;
out_exp = A;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 1.1");
if (out_exp != out) $display ("out error at block number 1.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 1.1");

#15

// block 1.2
opcode = $random;
bypass_A = 0;
bypass_B = 1;
A = $random;
B = $random;
out_exp = B;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 1.2");
if (out_exp != out) $display ("out error at block number 1.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 1.2");

#15

// block 1.3
opcode = $random;
bypass_A = 1;
bypass_B = 1;
A = $random;
B = $random;
out_exp = A;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 1.3");
if (out_exp != out) $display ("out error at block number 1.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 1.3");

end

bypass_A = 0;
bypass_B = 0;
#5
/////////////////////////AND
opcode = 3'b000;
for (i = 0 ; i<15 ; i = i+1)
begin

#15

// block 2.1
A = $random;
B = $random;
red_A = 1;
red_B = 0;
out_exp = &A;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 2.1");
if (out_exp != out) $display ("out error at block number 2.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 2.1");

#15

// block 2.2
A = $random;
B = $random;
red_A = 0;
red_B = 1;
out_exp = &B;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 2.2");
if (out_exp != out) $display ("out error at block number 2.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 2.2");

#15

// block 2.3
A = $random;
B = $random;
red_A = 1;
red_B = 1;
out_exp = &A;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 2.3");
if (out_exp != out) $display ("out error at block number 2.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 2.3");

#15

//block 2.4
A = $random;
B = $random;
red_A = 0;
red_B = 0;
out_exp = A&B;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 2.4");
if (out_exp != out) $display ("out error at block number 2.4");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 2.4");

end

#15

/////////////////////////XOR
opcode = 3'b001;
for (i = 0 ; i<15 ; i = i+1)
begin

#15
//block 3.1
A = $random;
B = $random;
red_A = 1;
red_B = 0;
out_exp = ^A;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 3.1");
if (out_exp != out) $display ("out error at block number 3.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 3.1");

#15

//block 3.2
A = $random;
B = $random;
red_A = 0;
red_B = 1;
out_exp = ^B;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 3.2");
if (out_exp != out) $display ("out error at block number 3.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 3.2");

#15

//block 3.3
A = $random;
B = $random;
red_A = 1;
red_B = 1;
out_exp = ^A;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 3.3");
if (out_exp != out) $display ("out error at block number 3.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 3.3");

#15

//block 3.4
A = $random;
B = $random;
red_A = 0;
red_B = 0;
out_exp = A^B;
odd_parity_exp = 0;
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 3.4");
if (out_exp != out) $display ("out error at block number 3.4");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 3.4");

end

#15


//////////////////////Addition with fill_adder = "ON"
opcode = 3'b010;
for (i = 0 ; i<15 ; i = i+1)
begin

#15

full_adder = 1'b1;
//block 4.1
A = $random;
B = $random;
Cin = $random;
red_A = 1;
red_B = 0;
out_exp = A+B+Cin;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 4.1");
if (out_exp != out) $display ("out error at block number 4.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 4.1");

#15

//block 4.2
A = $random;
B = $random;
Cin = $random;
red_A = 0;
red_B = 1;
out_exp = A+B+Cin;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 4.2");
if (out_exp != out) $display ("out error at block number 4.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 4.2");

#15

//block 4.3
A = $random;
B = $random;
Cin = $random;
red_A = 1;
red_B = 1;
out_exp = A+B+Cin;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 4.3");
if (out_exp != out) $display ("out error at block number 4.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 4.3");

#15

//block 4.4
A = $random;
B = $random;
Cin = $random;
red_A = 0;
red_B = 0;
out_exp = A+B+Cin;
odd_parity_exp = ~(^out_exp);
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 4.4");
if (out_exp != out) $display ("out error at block number 4.4");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 4.4");


end

#15
//////////////////////Addition with fill_adder = "OFF"
opcode = 3'b010;
for (i = 0 ; i<15 ; i = i+1)
begin

#15

full_adder = 0;
//block 5.1
A = $random;
B = $random;
Cin = $random;
red_A = 1;
red_B = 0;
out_exp = A+B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 5.1");
if (out_exp != out) $display ("out error at block number 5.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 5.1");

#15

//block 5.2
A = $random;
B = $random;
Cin = $random;
red_A = 0;
red_B = 1;
out_exp = A+B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 5.2");
if (out_exp != out) $display ("out error at block number 5.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 5.2");

#15

//block 5.3
A = $random;
B = $random;
Cin = $random;
red_A = 1;
red_B = 1;
out_exp = A+B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 5.3");
if (out_exp != out) $display ("out error at block number 5.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 5.3");

#15

//block 5.4
A = $random;
B = $random;
Cin = $random;
red_A = 0;
red_B = 0;
out_exp = A+B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 5.4");
if (out_exp != out) $display ("out error at block number 5.4");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 5.4");

end

#15

//////////////////////Multiplication
opcode = 3'b011;
for (i = 0 ; i<15 ; i = i+1)
begin

#15

//block 6.1
A = $random;
B = $random;
red_A = 1;
red_B = 0;
out_exp = A*B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 6.1");
if (out_exp != out) $display ("out error at block number 6.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 6.1");

#15

//block 6.2
A = $random;
B = $random;
red_A = 0;
red_B = 1;
out_exp = A*B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 6.2");
if (out_exp != out) $display ("out error at block number 6.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 6.2");

#15

//block 6.3

A = $random;
B = $random;
red_A = 1;
red_B = 1;
out_exp = A*B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 6.3");
if (out_exp != out) $display ("out error at block number 6.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 6.3");

#15

//block 6.4

A = $random;
B = $random;
red_A = 0;
red_B = 0;
out_exp = A*B;
odd_parity_exp = ~(^out_exp);
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 6.3");
if (out_exp != out) $display ("out error at block number 6.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 6.3");


end

#15

//////////////////////subtraction
opcode = 3'b100;
for (i=0 ; i<15 ; i = i+1)
begin

#15

//block 7.1
A = $random;
B = $random;
if (A > B) out_exp = A-B;
else out_exp = B-A;
red_A = 1;
red_B = 0;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 7.1");
if (out_exp != out) $display ("out error at block number 7.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 7.1");

#15

//block 7.2
A = $random;
B = $random;
if (A > B) out_exp = A-B;
else out_exp = B-A;
red_A = 0;
red_B = 1;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 7.2");
if (out_exp != out) $display ("out error at block number 7.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 7.2");

#15

//block 7.3
A = $random;
B = $random;
if (A > B) out_exp = A-B;
else out_exp = B-A;
red_A = 1;
red_B = 1;
odd_parity_exp = ~(^out_exp);
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 7.3");
if (out_exp != out) $display ("out error at block number 7.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 7.3");

#15

//block 7.4
A = $random;
B = $random;
if (A > B) out_exp = A-B;
else out_exp = B-A;
red_A = 0;
red_B = 0;
odd_parity_exp = ~(^out_exp);
invalid_exp = 0;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 7.4");
if (out_exp != out) $display ("out error at block number 7.4");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 7.4");

end

#15

//////////////////////Division
opcode = 3'b101;
for (i=0 ; i<15 ; i = i+1)
begin

#15

//block 8.1
A = $random;
B = $random;
red_A = 1;
red_B = 0;
if (A != 0 && B != 0 ) begin out_exp = A/B; invalid_exp = 1; end
else if (A == 0) begin out_exp = B; invalid_exp = 1; end
else if (B == 0) begin out_exp = B; invalid_exp = 1; end
else begin out_exp = 0; invalid_exp = 1; end
odd_parity_exp = ~(^out_exp);
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 8.1");
if (out_exp != out) $display ("out error at block number 8.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 8.1");

#15

//block 8.2
A = $random;
B = $random;
red_A = 0;
red_B = 1;
if (A != 0 && B != 0 ) begin out_exp = A/B; invalid_exp = 1; end
else if (A == 0) begin out_exp = B; invalid_exp = 1; end
else if (B == 0) begin out_exp = B; invalid_exp = 1; end
else begin out_exp = 0; invalid_exp = 1; end
odd_parity_exp = ~(^out_exp);
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 8.2");
if (out_exp != out) $display ("out error at block number 8.2");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 8.2");

#15

//block 8.3
A = $random;
B = $random;
red_A = 1;
red_B = 1;
if (A != 0 && B != 0 ) begin out_exp = A/B; invalid_exp = 1; end
else if (A == 0) begin out_exp = B; invalid_exp = 1; end
else if (B == 0) begin out_exp = A; invalid_exp = 1; end
else begin out_exp = 0; invalid_exp = 1; end
odd_parity_exp = ~(^out_exp);
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 8.3");
if (out_exp != out) $display ("out error at block number 8.3");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 8.3");

#15

//block 8.4
A = $random;
B = $random;
red_A = 0;
red_B = 0;
if (A != 0 && B != 0 ) begin out_exp = A/B; invalid_exp = 0; end
else if (A == 0) begin out_exp = B; invalid_exp = 1; end
else if (B == 0) begin out_exp = A; invalid_exp = 1; end
else begin out_exp = 0; invalid_exp = 1; end
odd_parity_exp = ~(^out_exp);
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 8.4");
if (out_exp != out) $display ("out error at block number 8.4");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 8.4");


end

#15

for (i=0 ; i<15 ; i = i+1)
begin

#15

//block 9.1
opcode = 3'b110;
A = $random;
B = $random;
red_A = $random;
red_B = $random;
Cin = $random;
out_exp = 0;
odd_parity_exp = 0;
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 9.1");
if (out_exp != out) $display ("out error at block number 9.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 9.1");

#15

//block 9.2
opcode = 3'b111;
A = $random;
B = $random;
red_A = $random;
red_B = $random;
Cin = $random;
out_exp = 0;
odd_parity_exp = 0;
invalid_exp = 1;
#15
if (invalid_exp != invalid) $display ("Invalid error at block number 9.1");
if (out_exp != out) $display ("out error at block number 9.1");
if (odd_parity_exp != odd_parity) $display ("odd_parity error at block number 9.1");

end

end

endmodule