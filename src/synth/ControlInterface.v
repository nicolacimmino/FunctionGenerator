/*
   Control Interface.
   Provides a SPI interface. 
   
   Copyright (C) 2019 Nicola Cimmino

   This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

   This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/.

 */
module ControlInterface  #(parameter DATA_BITS = 8)(
  output [DATA_BITS-1:0] controlWord,
  output wire controlWordReady,
  input wire SCLK,
  input wire MOSI,
  input wire SS   
);

	reg [DATA_BITS-1:0] shiftRegister;
	reg [DATA_BITS-1:0] outputRegister;
		
	always @(posedge SCLK) begin
		if (SS == 1) begin			
			shiftRegister <= (shiftRegister << 1 | MOSI);
		end
	end

	always @(negedge SS) begin
	  outputRegister <= shiftRegister;	  
	end

	assign controlWordReady = SS;
	assign controlWord = outputRegister;
	
endmodule
