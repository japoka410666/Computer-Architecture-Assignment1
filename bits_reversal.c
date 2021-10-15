/*
//Explanation:
//
//In the fuction 'reverse', it reverse the input uint32_t n bit-by-bit from LSB to MSB.
//                                                                                
//Step1: Mask n by 1, leaving only the LSB .                                      
//Step2: Dicide the shift amount by (31 - i), where i is the actual position of   
//	 the current reversing bit.                                        
//	 For example: b0 need to move to b31 as reversal. (31 = 31 - 0)    
//	 	      b1 need to move to b30 as reversal. (30 = 31 - 1)    
//	 	      and so on ...                                        
//Step3: Use += to save the result bit-by-bit from MSB to LSB.             
//Step4: To set the new 'LSB', so we can reuse the mask at step1.
//
//The reulut is initialize to 0 at first, which imply if n is become 0 in advance,
//we can directly break the loop, because the remaining un-reversed bits are all 0. 
*/

#include<stdio.h>
#include<stdint.h>

uint32_t reverse(uint32_t n);

int main(void){

	//initialize and decide the input
	uint32_t num = 0b11111111111111111111111111111101;
	uint32_t result = 0;

	result = reverse(num);
	printf("%u is reverse to %u\n",num,result);
	return 0;
}
uint32_t reverse(uint32_t n){

	uint32_t res = 0;
	
	//The for loop will check if it's all done
	//or if the remaining bits are all 0
	for(int i = 0; i < 32 && n; i++){
                res += (n & 1) << (31 - i);
		n = n >> 1;
        }
	return res;

}
