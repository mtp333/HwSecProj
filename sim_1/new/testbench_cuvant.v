`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2025 05:08:36 PM
// Design Name: 
// Module Name: testbench_cuvant
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

module testbench_cuvant;
    
  parameter MSG_LEN = 9; // Length of the message to decryp

  logic [7:0] plaintext [0:MSG_LEN-1];
  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];
  
  encrypt #(
    .MSG_LEN(MSG_LEN)
  ) enc_cuvant (
    .text_in(plaintext),
    .text_out(encrypted_text)
  );
  
  decrypt #(
    .MSG_LEN(MSG_LEN)
  ) dec_cuvant (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );
  
  initial begin
    plaintext[0] = "S"; plaintext[1] = "U"; plaintext[2] = "P"; plaintext[3] = "E";
    plaintext[4] = "R"; plaintext[5] = "U"; plaintext[6] = "S"; plaintext[7] = "E";
    plaintext[8] = "R";
      
    #10;

    // Display the encrypted message
    $display("Encrypted message:");
    foreach (encrypted_text[i]) begin
      $write("%0d ", encrypted_text[i]); // Print encrypted numeric values
    end
    $display("");

    #10;

    // Display the decrypted message
    $display("Decrypted message:");
    foreach (decrypted_text[i]) begin
      $write("%c", decrypted_text[i]); // Print decrypted characters
    end
    $display(""); // Move to the next line

    $stop;
  end
    
endmodule