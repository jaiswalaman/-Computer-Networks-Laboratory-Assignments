// Enrollment Number : 17114008


#include <iostream>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <net/if.h>
#include <unistd.h>

using namespace std;

int main ()
{
	//function to find mac address is IOCTL
   	int fd;
	
	struct ifreq ifr;
	char const *iface = "eno1"; 
	char *mac;
	//socket discriptor 
	fd = socket(AF_INET, SOCK_DGRAM, 0);

	ifr.ifr_addr.sa_family = AF_INET;
	strncpy((char *)ifr.ifr_name , (const char *)iface , IFNAMSIZ-1);

	ioctl(fd, SIOCGIFHWADDR, &ifr);

	close(fd);
	//socket connection closed
	mac = (char *)ifr.ifr_hwaddr.sa_data;

   
	int a = mac[0];
    int b = mac[1];
    int c = mac[2];
	int d = mac[3];
	int e = mac[4];
	int f = mac[5];
    if(a<0)
    	a+=256;
    if(b<0)
    	b+=256;
    if(c<0)
    	c+=256;
	if(d<0)
    	d+=256;
	if(e<0)
    	e+=256;
	if(f<0)
    	f+=256;
	
	printf("Mac Address : %2x:%2x:%.2x:%.2x:%.2x:%.2x\n" , a, b, c, d, e,f);
	
}

