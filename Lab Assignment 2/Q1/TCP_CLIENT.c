/** @file TCP_CLIENT.c
	@brief Create TCP socket.connect newly created client socket to server.
	@author Aman Jaiswal
	@date 01/08/2019
*/
#include <netdb.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <arpa/inet.h>
#include <string.h> 
#include <unistd.h>
#include <sys/socket.h> 
#define MAX 80 
#define PORT 8080 
#define SA struct sockaddr 
/**
*	Function designed for chat between client and server.
*	@author Aman Jaiswal
*	@param sockfd- socket file descriptor
*	@date 2/28/2009
*/

void func(int sockfd) 
{ 
	char buff[MAX]; 
	int n; 
	for (;;) { 
		bzero(buff, sizeof(buff)); 
		printf("Enter the string : "); 
		n = 0; 
		while ((buff[n++] = getchar()) != '\n') 
			; 
		write(sockfd, buff, sizeof(buff)); 
		bzero(buff, sizeof(buff)); 
		read(sockfd, buff, sizeof(buff)); 
		printf("From Server : %s", buff); 
		if ((strncmp(buff, "exit", 4)) == 0) { 
			printf("Client Exit...\n"); 
			break; 
		} 
	} 
} 
/**
	Driver function
	@author Aman Jaiswal
	@date 2/28/2009
*/
int main() 
{ 
	int sockfd, connfd; 
	struct sockaddr_in servaddr, cli; 

	//// socket create and varification 
	sockfd = socket(AF_INET, SOCK_STREAM, 0); 
	if (sockfd == -1) { 
		printf("socket creation failed...\n"); 
		exit(0); 
	} 
	else
		printf("Socket successfully created..\n"); 
	bzero(&servaddr, sizeof(servaddr)); 

	//// assign IP, PORT 
	servaddr.sin_family = AF_INET; 
	servaddr.sin_addr.s_addr = inet_addr("127.0.0.1"); 
	servaddr.sin_port = htons(PORT); 

	//// connect the client socket to server socket 
	if (connect(sockfd, (SA*)&servaddr, sizeof(servaddr)) != 0) { 
		printf("connection with the server failed...\n"); 
		exit(0); 
	} 
	else
		printf("connected to the server..\n"); 

	//// function for chat 
	func(sockfd); 

	//// close the socket 
	close(sockfd); 
} 
