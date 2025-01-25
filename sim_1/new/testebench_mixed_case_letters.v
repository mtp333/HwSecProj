`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 20:15:18
// Design Name: 
// Module Name: testebench_mixed_case_letters
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module testebench_mixed_case_letters;

    parameter MSG_LEN = 13; // Length of the message to decryp

  logic [7:0] plaintext [0:MSG_LEN-1];
  logic case_map[0:MSG_LEN-1];
  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];
  logic [7:0] final_decrypted_text[0:MSG_LEN-1];
  
  encrypt #(
    .MSG_LEN(MSG_LEN)
  ) enc_mixed_case_letters (
    .text_in(plaintext),
    .text_out(encrypted_text)
  );
  
  decrypt #(
    .MSG_LEN(MSG_LEN)
  ) dec_mixed_case_letters (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );
  
   function [7:0] to_uppercase(input [7:0] char_in);
        begin
            if (char_in >= "a" && char_in <= "z") begin
                to_uppercase = char_in - 8'd32; // Convert to uppercase
            end else begin
                to_uppercase = char_in; // No change for uppercase or non-alphabet
            end
        end
    endfunction
  
  initial begin
    integer i;
  
    plaintext[0] = "C"; 
    plaintext[1] = "y"; 
    plaintext[2] = "b"; 
    plaintext[3] = "e";
    plaintext[4] = "R"; 
    plaintext[5] = "S"; 
    plaintext[6] = "e"; 
    plaintext[7] = "C";
    plaintext[8] = "U";
    plaintext[9] = "R";
    plaintext[10] = "I";
    plaintext[11] = "T";
    plaintext[12] = "y";
    
     for (i = 0; i < MSG_LEN; i = i + 1) begin
            case_map[i] = (plaintext[i] >= "A" && plaintext[i] <= "Z") ? 1 : 0; // 1 if uppercase
            plaintext[i] = to_uppercase(plaintext[i]);
        end
      
    #10;
    
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            final_decrypted_text[i] = decrypted_text[i]; // Copy decrypted value
            if (!case_map[i]) begin
                final_decrypted_text[i] = final_decrypted_text[i] + 8'd32; // Convert back to lowercase
            end
        end

    // Display the encrypted message
    $display("Encrypted message:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]); // Print encrypted numeric values
    end
    $display("");

    #10;

    // Display the decrypted message
    $display("Decrypted message:");
    foreach (final_decrypted_text[i]) begin
      $write("%c", final_decrypted_text[i]); // Print decrypted characters
    end
    $display(""); // Move to the next line

    $stop;
  end
    
endmodule