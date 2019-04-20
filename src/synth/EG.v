/*
   Envelope Generator.
         
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
module EG #(parameter CLOCK_FREQ = 2080000) (
  input clock,	
  input gate,
  input ask,  
  input [7:0] ad,  
  input [7:0] sr,  
  input [7:0] askab,  
  output [3:0] out
);
	reg [7:0] adLut[0:31];
    reg [7:0] rLut[0:31];
	
    `define clockCyclesForDelay(delaymS) $rtoi((1000 * delaymS) / CLOCK_FREQ)
  
	initial begin
		adLut[0] = `clockCyclesForDelay(2);
		adLut[1] = `clockCyclesForDelay(8);
		adLut[2] = `clockCyclesForDelay(16);
		adLut[3] = `clockCyclesForDelay(24);
		adLut[4] = `clockCyclesForDelay(38);
		adLut[5] = `clockCyclesForDelay(56);
		adLut[6] = `clockCyclesForDelay(68);
		adLut[7] = `clockCyclesForDelay(80);
		adLut[8] = `clockCyclesForDelay(100);
		adLut[9] = `clockCyclesForDelay(250);
		adLut[10] = `clockCyclesForDelay(500);
		adLut[11] = `clockCyclesForDelay(800);
		adLut[12] = `clockCyclesForDelay(1000);
		adLut[13] = `clockCyclesForDelay(3000);
		adLut[14] = `clockCyclesForDelay(5000);
		adLut[15] = `clockCyclesForDelay(8000);	
	end
	initial begin
		rLut[0] = `clockCyclesForDelay(6);
		rLut[1] = `clockCyclesForDelay(24);
		rLut[2] = `clockCyclesForDelay(48);
		rLut[3] = `clockCyclesForDelay(72);
		rLut[4] = `clockCyclesForDelay(114);
		rLut[5] = `clockCyclesForDelay(168);
		rLut[6] = `clockCyclesForDelay(204);
		rLut[7] = `clockCyclesForDelay(240);
		rLut[8] = `clockCyclesForDelay(300);
		rLut[9] = `clockCyclesForDelay(750);
		rLut[10] = `clockCyclesForDelay(1500);
		rLut[11] = `clockCyclesForDelay(2400);
		rLut[12] = `clockCyclesForDelay(3000);
		rLut[13] = `clockCyclesForDelay(9000);
		rLut[14] = `clockCyclesForDelay(15000);
		rLut[15] = `clockCyclesForDelay(24000);
	end
				
endmodule

