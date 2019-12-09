/** @file Orphan.c
	@brief A C program to demonstrate Orphan Process.Parent process finishes execution while the child process is running. The child process becomes orphan. 
	@author Aman Jaiswal
	@date 01/08/2019
*/

// A C program to demonstrate Orphan Process. 
// Parent process finishes execution while the 
// child process is running. The child process 
// becomes orphan. 
#include<stdio.h> 
#include <sys/types.h> 
#include <unistd.h> 

int main() 
{ 
	//// Create a child process	 
	int childPid = fork(); 

	if (childPid > 0) 
		printf("This is  parent process - %d\n",getpid()); 

	//// Note that pid is 0 in child process 
	//// and negative if fork() fails 
	else if (childPid == 0) 
	{ 
		sleep(30); 
		printf("This is  child process- %d\n",getppid()); 
	} 

	return 0; 
} 
