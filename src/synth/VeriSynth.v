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
  input pin_vs_sclk,
  input pin_vs_fsk,
  input pin_vs_ask  
);

	wire [7:0] controlWord;
	wire [3:0] controlAddress;
	wire clk;
	wire controlReady;
	wire [11:0] amplitude;		
	wire [4:0] phase;
    reg [1:0] waveForm;
	reg [7:0] pWidth;
	reg [15:0] frequencyControlWordA;
	reg [15:0] frequencyControlWordB;
	reg [7:0] amplitudeControlWord;	
	reg [7:0] amplitudeControlWord;	
	
	OSCH #(
	.NOM_FREQ("2.08")
	) internal_oscillator_inst (
		.STDBY(1'b0),		
		.OSC(clk)
	);
		
	// The PDM encoder.			
	PDMEncoder #(
		.DATA_BITS(12)
	) pdm_encoder (
		.clock(clk),
		.amplitude(amplitude),
		.digital_out(pin_vs_dout)
	);
	
	// The SPI control interface.
	ControlInterface #(
	    .ADDR_BITS(4),
		.DATA_BITS(8)
	) control_interface (
		.controlWord(controlWord),
		.controlAddress(controlAddress),
		.controlReady(controlReady),
		.SCLK(pin_vs_ss),
		.MOSI(pin_vs_mosi),
		.SS(pin_vs_sclk) 
	);
	
	NCO #(
		.PA_SIZE(16), 
		.PH_SIZE(5)
	) nco (		
		.frequencyControlWord(pin_vs_fsk ? frequencyControlWordA : frequencyControlWordB),		
		.clock(clk),
		.phase(phase)
	);
	
	PAC pac (
		.phase(phase),
		.waveForm(waveForm),		
		.pWidth(pWidth),
		.amplitude(pin_vs_ask ? amplitudeControlWord[7:4] : amplitudeControlWord[3:0]),
		.out(amplitude)		
	);
	
	// Take action on controlReady according to the
	// control address. Just map for now the PDM Encoder 
	// to address 5.
	always @(posedge controlReady) begin
		case (controlAddress)			
			2: amplitudeControlWord <= controlWord;			
			3: pWidth <= controlWord;
			4: waveForm <= controlWord[1:0];
			5: frequencyControlWordA[15:8] <= controlWord;
			6: frequencyControlWordA[7:0] <= controlWord;
			7: frequencyControlWordB[15:8] <= controlWord;
			8: frequencyControlWordB[7:0] <= controlWord;
		endcase
	end
	
	// Just some blinking fun to see something is happening 
	// on the control interface.
	assign pin_vs_led = controlReady;
		
endmodule
