/**
 	@file both.c

	@brief A C program to demonstrate Orphan and zombie Process. 

	@author Aman Jaiswal

	@date 01/08/2019
*/
// C program to execute zombie and 
// orphan process in a single program 
#include <stdio.h> 
#include <stdlib.h> 
#include <sys/types.h> 
#include <unistd.h> 
int main() 
{ 
    //// Create a child process
	int x; 
	x = fork(); 
    //// Note that pid is 0 in child process 
	//// and negative if fork() fails 
	if (x > 0) 
		printf("IN PARENT PROCESS \n MY PROCESS ID : %d\n", getpid()); 

	else if (x == 0) { 
		sleep(5); 
		x = fork(); 

		if (x > 0) { 
printf("IN CHILD PROCESS \n MY PROCESS ID :%d\n PARENT PROCESS ID : %d\n", getpid(), getppid()); 

while(1) 
	sleep(1); 

printf("IN CHILD PROCESS\nMY PARENT PROCESS ID : %d\n", getppid()); 
		} 

		else if (x == 0) 
			printf("IN CHILD'S CHILD PROCESS\n MY PARENT ID : %d\n", getppid()); 
	} 

	return 0; 
} 
