// Copyright (c) 2020 University of Florida
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Greg Stitt
// University of Florida
//
// This example demonstrates how to use the AFU OPAE wrapper class to 
// communicate with a simple AFU that calculates Fibonacci numbers.

#include <cstdlib>
#include <iostream>

#include <opae/utils.h>

#include "AFU.h"

using namespace std;

// Auto-generated by OPAE's afu_json_mgr script
#include "afu_json_info.h"

//=========================================================
// Define the addresses of the memory-mapped registers according the addresses
// that were used in the RTL code.
//
// NOTE: Ideally this could be generated with a .json file just like the
// AFU_ACCEL_UUID. Without auto-generation, you must manually ensure that
// the addresses match between the RTL code and software code.
//=========================================================
#define GO_ADDR 0x0020
#define N_ADDR 0x0022
#define RESULT_ADDR 0x0024
#define DONE_ADDR 0x0026

#define NUM_TESTS 50

// Software solution to compute nth Fibonacci number for comparison with hw
unsigned fib(unsigned n) {

  unsigned x = 0;
  unsigned y = 1;

  if (n == 0)
    return 0;

  for (unsigned i=2; i <= n; i++) {    
    unsigned temp = x+y;
    x = y;
    y = temp;
  }  

  return y;
}


int main(int argc, char *argv[]) {

  try {
    AFU afu(AFU_ACCEL_UUID);
    
    unsigned errors = 0;
    for (uint64_t i=0; i < NUM_TESTS; i++) {
            
      // Give the AFU a value for the n input
      afu.write(N_ADDR, i);

      // Tell the AFU to go. The go signal is cleared automatically by the 
      // AFU, so that software does not have to explicitly write a 0.
      afu.write(GO_ADDR, 1);

      // Wait until the AFU is done.
      // NOTE: An interrupt would be a more efficiently implementation that
      // prevents the CPU from constantly polling the done register.
      while(!afu.read(DONE_ADDR));
    
      // Read the AFU result and compare with software.
      uint64_t afu_result = afu.read(RESULT_ADDR);
      uint64_t sw_result  = fib(i);

      if (afu_result != sw_result) {
	cerr << "ERROR: AFU returned " << afu_result
	     << " instead of " << sw_result
	     << " for an input of " << i << endl;
	errors ++;
      }
    }

    if (errors == 0) {
      cout << "All tests succeeded." << endl;
      return EXIT_SUCCESS;
    }
    else {
      cout << errors << " tests failed." << endl;
      return EXIT_FAILURE;
    }
  }
  // Exception handling for all the runtime errors that can occur within 
  // the AFU wrapper class.
  catch (const fpga_result& e) {    
    
    // Provide more meaningful error messages for each exception.
    if (e == FPGA_BUSY) {
      cerr << "ERROR: All FPGAs busy." << endl;
    }
    else if (e == FPGA_NOT_FOUND) { 
      cerr << "ERROR: FPGA with accelerator " << AFU_ACCEL_UUID 
	   << " not found." << endl;
    }
    else {
      // Print the default error string for the remaining fpga_result types.
      cerr << "ERROR: " << fpgaErrStr(e) << endl;    
    }
  }
  catch (const runtime_error& e) {    
    cerr << e.what() << endl;
  }
  catch (const opae::fpga::types::no_driver& e) {
    cerr << "ERROR: No FPGA driver found." << endl;
  }

  return EXIT_FAILURE;
}
