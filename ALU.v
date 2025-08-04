module ALU #(parameter width = 4)
(
    input [width : 0] A , B ,
    input Cin , red_A , red_B , bypass_A , bypass_B ,
    input [2:0] opcode ,
    input full_adder ,
    output reg [width*2 : 0] out ,
    output reg odd_parity , invalid
);


always @ (*)
begin

    if (bypass_A)
    begin
        out = A;
        invalid = 0;
        odd_parity = 0;
    end

    else if (bypass_B)
    begin
        out = B;
        invalid = 0;
        odd_parity = 0;
    end

    else
    begin
        
        case (opcode)
        
            3'b000:
            begin
                if (red_A)
                begin
                    out = &A;
                    invalid = 0;
                    odd_parity = 0;
                end

                else if (red_B)
                begin
                    out = &B;
                    invalid = 0;
                    odd_parity = 0;            
                end

                else
                begin
                    out = A&B;
                    invalid = 0;
                    odd_parity = 0;
                end
            end

            3'b001:
            begin
                if (red_A)
                begin
                    out = ^A;
                    invalid = 0;
                    odd_parity = 0;
                end

                else if (red_B)
                begin
                    out = ^B;
                    invalid = 0;
                    odd_parity = 0;
                end

                else
                begin
                    out = A^B;
                    invalid = 0;
                    odd_parity = 0;
                end
            end

            3'b010:
            begin
                if (full_adder == 1'b1)
                begin
                    out = A+B+Cin;
                    invalid = 0;
                    odd_parity = ~(^out);
                end

                else
                begin
                    out = A+B;
                    invalid = 0;
                    odd_parity = ~(^out);
                end
                
                if (red_A || red_B) 
                begin
                    out = out;
                    invalid = 1;
                    odd_parity = odd_parity;
                end

                else
                begin
                    out = out;
                    invalid = invalid;
                    odd_parity = odd_parity;
                end
            end

            3'b011:
            begin
                if (red_A || red_B) 
                begin
                    out = A*B;
                    invalid = 1;
                    odd_parity = ~(^out);
                end
                else
                begin
                    out = A*B;
                    invalid = 0;
                    odd_parity = ~(^out);
                end
            end

            3'b100:
            begin
                
                if (A>B)
                begin
                    out = A-B;
                    invalid = 0;
                    odd_parity = ~(^out);
                end
            
                else
                begin
                    invalid = 0;
                    out = B-A;
                    odd_parity = ~(^out);
                end

                if (red_A || red_B) 
                begin
                    invalid = 1;
                    out = out;
                    odd_parity = odd_parity;
                end

                else
                begin
                    invalid = invalid;
                    out = out;
                    odd_parity = odd_parity;
                end

            end
        
            3'b101:
            begin
                
                if (A != 0 && B != 0)
                begin
                    invalid = 0;
                    out = A/B;
                    odd_parity = ~(^out);
                end
            
                else if (A == 0)
                begin
                    invalid = 1;
                    out = B;
                    odd_parity = ~(^out);
                end

                else if (B == 0)
                begin
                    invalid = 1;
                    out = A;
                    odd_parity = ~(^out);
                end

                else 
                begin
                    invalid = 1;
                    out = 0;
                    odd_parity = 0;
                end

                if (red_A || red_B) 
                begin
                    invalid = 1;
                    out = out;
                    odd_parity = odd_parity;
                end

                else 
                begin
                    invalid = invalid;
                    out = out;
                    odd_parity = odd_parity;
                end
            end

            default:
            begin
                invalid = 1;
                out = 0;
                odd_parity = 0;
            end

        endcase
    end

end

endmodule