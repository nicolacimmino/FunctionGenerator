/*
   Pulse Desnsity Modulator.
   Outputs a series of pulses the density of which is proportional to the input "amplitude" value. 
   
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
module PDMEncoder  #(parameter DATA_BITS = 10)(
  input [DATA_BITS-1:0] amplitude,
  input wire clock,
  output wire digital_out
);

	reg [DATA_BITS:0] accumulator;
	
	always @(posedge clock) begin
	  accumulator <= (accumulator[DATA_BITS-1 : 0] + amplitude);
	end

	assign digital_out = accumulator[DATA_BITS];

endmodule
