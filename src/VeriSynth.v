/*
   VeriSynth.
   A sound synth in verilog.
   
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
module VeriSynth (
  output pin5,
  output pin6
);

	wire clk;
	  
	OSCH #(
	.NOM_FREQ("2.08")
	) internal_oscillator_inst (
		.STDBY(1'b0), 
		.OSC(clk)
	);

	reg [23:0] led_timer;		
	assign pin5 = led_timer[21];
	always @(posedge clk) begin
		led_timer <= led_timer + 1; 
	end

	
	PDMEncoder #(
		.DATA_BITS(8)
	) pdm_encoder (
		.clock(clk),
		.amplitude(led_timer[17:10]),
		.digital_out(pin6)
	);
	
endmodule
