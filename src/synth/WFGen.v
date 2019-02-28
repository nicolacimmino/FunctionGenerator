/*
   WaveForm Generator.
      
   You can calculate the LUT for instance in Octave with:
   
    sineLut=floor((127*sin(0:2*pi/32:2*pi))+127);
	
   This will give you 33 values	of which the last one is to be discarded
   as it's a repetion of the first and would introduce distortion in the sine.
   
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
module WFGen (
  input [4:0] phase,  
  output [7:0] out
);
	reg [7:0] sineLut[0:31];
	
	initial begin
		sineLut[0] = 128;
		sineLut[1] = 152;	
		sineLut[2] = 176;	
		sineLut[3] = 199;	
		sineLut[4] = 218;	
		sineLut[5] = 234;	
		sineLut[6] = 246;	
		sineLut[7] = 253;	
		sineLut[8] = 255;	
		sineLut[9] = 253;	
		sineLut[10] = 246;	
		sineLut[11] = 234;	
		sineLut[12] = 218;	
		sineLut[13] = 199;	
		sineLut[14] = 176;	
		sineLut[15] = 152;	
		sineLut[16] = 128;	
		sineLut[17] = 103;	
		sineLut[18] = 79;
		sineLut[19] = 56;	
		sineLut[20] = 37;	
		sineLut[21] = 21;	
		sineLut[22] = 9;
		sineLut[23] = 2;	
		sineLut[24] = 0;	
		sineLut[25] = 2;
		sineLut[26] = 9;
		sineLut[27] = 21;	
		sineLut[28] = 37;	
		sineLut[29] = 56;	
		sineLut[30] = 79;	
		sineLut[31] = 103;	
	end

	assign out = sineLut[phase];

endmodule

