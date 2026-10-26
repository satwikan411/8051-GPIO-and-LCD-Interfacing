# 8051 2x16 LCD Interfacing (Bare-Metal Assembly)

## Project Overview
This project demonstrates low-level firmware development by interfacing a 16x2 Alphanumeric LCD (HD44780 controller) with an 8051 microcontroller. The firmware is written entirely in bare-metal Assembly and simulates the hardware environment using the MCU 8051 IDE. 

The program successfully initializes the display and prints the string "IIT BBSR".

## Hardware & Software Used
*   **Microcontroller:** 8051
*   **Display:** 16x2 LCD
*   **Language:** 8051 Assembly
*   **Environment:** MCU 8051 IDE (Virtual Hardware)

## Technical Implementation
This project demonstrates hardware-software synchronization and parallel communication protocols.

**Pin Mapping:**
*   **Port 1 (P1.0 - P1.7):** 8-bit Data Bus.
*   **P2.0 (RS):** Register Select (0 = Command, 1 = Data).
*   **P2.1 (R/W):** Read/Write control.
*   **P2.2 (E):** Enable signal (data is latched on the falling edge).

**Key Firmware Features:**
1.  **Initialization Sequence:** Sends the standard HD44780 configuration commands (`0x38`, `0x0E`, `0x01`, `0x06`, `0x80`) to set the display to 8-bit mode, turn on the cursor, and clear the screen.
2.  **Bit-Banging Control Lines:** Manually toggles the RS, R/W, and E pins to generate the precise timing pulses required by the LCD controller.
3.  **Busy Flag Polling (Crucial):** Instead of using arbitrary delay loops, the firmware includes a `READY` subroutine. It reads the busy flag (Bit 7 of the data bus) to check if the LCD is still processing the previous instruction before sending the next one. This ensures reliable communication and prevents data loss.

## Procedure & Execution
1. Load the `lcd_display.asm` code into the MCU 8051 IDE.
2. Ensure the virtual hardware is configured with the LCD connected to the correct ports.
3. Assemble and run the program.
4. The LCD will display the text "IIT BBSR".

## Result
*(Upload your screenshot from the PDF here. Create a folder named `images`, upload the picture, and then replace the link below)*
`![LCD Display Output](images/lcd_result.png)`

*The output shows the successful initialization of the 2x16 LCD and the correct rendering of the string.*
