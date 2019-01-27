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
  output pin_vs_led,
  output pin_vs_dout,
  input pin_vs_ss,
  input pin_vs_mosi,
  input pin_vs_cs  
);

	wire [7:0] controlWord;
	wire clk;
	wire controlInterfaceReady;
	reg [7:0] amplitude;		

	OSCH #(
	.NOM_FREQ("2.08")
	) internal_oscillator_inst (
		.STDBY(1'b0),		
		.OSC(clk)
	);
		
	PDMEncoder #(
		.DATA_BITS(8)
	) pdm_encoder (
		.clock(clk),
		.amplitude(amplitude),
		.digital_out(pin_vs_dout)
	);
	
	ControlInterface #(
		.DATA_BITS(8)
	) control_interface (
		.controlWord(controlWord),
		.controlWordReady(controlInterfaceReady),
		.SCLK(pin_vs_ss),
		.MOSI(pin_vs_mosi),
		.SS(pin_vs_cs) 
	);
	
	always @(posedge controlInterfaceReady) begin		amplitude <= controlWord;
	end
	
	assign pin_vs_led = controlInterfaceReady;
		
endmodule
