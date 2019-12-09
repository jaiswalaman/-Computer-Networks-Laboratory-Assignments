// A C program to demonstrate Zombie Process. 
// Child becomes Zombie as parent is sleeping 
// when child process exits. 


/** @file zombie.c

	@brief @brief A C program to demonstrate Zombie Process.Child becomes Zombie as parent is sleeping when child process exits.
	
	@author Aman Jaiswal
	
	@date 01/08/2019
*/


#include <stdio.h> 
#include <stdlib.h> 
#include <sys/types.h> 
#include <unistd.h> 
int main() 
{
  //char* cmd="ps -e -o pid,stat,cmd"; 
	//// Fork returns process id 
	//// in parent process 
	pid_t childPid = fork(); 
     
	//// Parent process 
	if (childPid > 0) {
		printf("This is  parent process - %d\n",getpid()); 
		
		sleep(50); 
		
 
	}

	//// Child process 
	else{
		
      //system(cmd);
	  printf("This is  child process- %d\n",getppid()); 
		exit(0); 

 }
	return 0; 
} 
