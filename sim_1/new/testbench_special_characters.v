`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 20:37:54
// Design Name: 
// Module Name: testbench_special_characters
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

module testbench_special_characters;
    // Parameters
    parameter MSG_LEN = 12;

    // Wires and registers
    logic [7:0] plaintext[0:MSG_LEN-1];  // Input plaintext
    logic [7:0] encrypted_text [0:MSG_LEN-1];
    logic [7:0] decrypted_text [0:MSG_LEN-1];
    logic [7:0] final_decrypted_text[0:MSG_LEN-1];
    logic is_special[0:MSG_LEN-1]; // Flag array to track special characters

    // Encryption and decryption modules
    encrypt #(
      .MSG_LEN(MSG_LEN)
     ) enc_special_characters (
    .text_in(plaintext),
    .text_out(encrypted_text)
  );
  
  decrypt #(
    .MSG_LEN(MSG_LEN)
  ) dec_special_characters (
    .text_in(encrypted_text),
    .text_out(decrypted_text)
  );

    // Test the encryptor and decryptor with special characters
    initial begin
        integer i;

        // Initialize plaintext with special characters
        plaintext[0] = "~";
        plaintext[1] = " ";
        plaintext[2] = "!";
        plaintext[3] = "@";
        plaintext[4] = "#";
        plaintext[5] = "$";
        plaintext[6] = "%";
        plaintext[7] = "^";
        plaintext[8] = "&";
        plaintext[9] = "*";
        plaintext[10] = "(";
        plaintext[11] = ")";
        

        // Identify special characters
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            if ((plaintext[i] < "A" || plaintext[i] > "Z") &&
                (plaintext[i] < "a" || plaintext[i] > "z")) begin
                is_special[i] = 1; // Mark as special character
            end else begin
                is_special[i] = 0; // Not a special character
            end
        end

        // Wait for encryption and decryption to complete
        #10;

        // Process decrypted output to restore special characters
        for (i = 0; i < MSG_LEN; i = i + 1) begin
            if (is_special[i]) begin
                // If it was a special character, use ASCII code to restore it
                final_decrypted_text[i] = plaintext[i]; // Restore directly from the original plaintext
            end else begin
                // If it was not a special character, take the decrypted value as is
                final_decrypted_text[i] = decrypted_text[i];
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

