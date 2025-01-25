`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2025 06:04:50 PM
// Design Name: 
// Module Name: testbench_longmessage
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


module testbench_longmessage;
  parameter MSG_LEN = 23; // Length of the message to decryp

  logic [7:0] plaintext [0:MSG_LEN-1];
  logic [7:0] encrypted_text [0:MSG_LEN-1];
  logic [7:0] decrypted_text [0:MSG_LEN-1];
  
  encrypt #(
    .MSG_LEN(MSG_LEN)
  ) enc_longmessage (
    .text_in(plaintext),
    .text_out(encrypted_text)
  );
  
  decrypt #(
    .MSG_LEN(MSG_LEN)
  ) dec_longmessage (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );
  
  initial begin
    plaintext[0] = "H"; plaintext[1] = "E"; plaintext[2] = "L"; plaintext[3] = "L";
    plaintext[4] = "O"; plaintext[5] = "W"; plaintext[6] = "O"; plaintext[7] = "R";
    plaintext[8] = "L"; plaintext[9] = "D"; plaintext[10] = "F"; plaintext[11] = "R";
    plaintext[12] = "O"; plaintext[13] = "M"; plaintext[14] = "V"; plaintext[15] = "I";
    plaintext[16] = "V"; plaintext[17] = "A"; plaintext[18] = "D"; plaintext[19] = "O";
    plaintext[20] = "A"; plaintext[21] = "P"; plaintext[22] = "P";      
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
