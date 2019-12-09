#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
  
// Driver code 
int main() 
{ 
    int pid, pid1, pid2; 
  
    
    pid = fork(); 
  
    
    if (pid == 0) { 
  
        
        printf("child[1] --> pid = %d and ppid = %d\n", 
               getpid(), getppid()); 
        sleep(1);
        int gpid=fork();
        if(gpid==0){
         
         printf("child-grand[1] --> pid = %d and ppid = %d\n", 
               getpid(), getppid());
        }
         else{
         int gpid2=fork(); 
         if(gpid2==0){
      
         printf("child-grand[2] --> pid = %d and ppid = %d\n", 
               getpid(), getppid());
         }
        }
    } 
  
    else { 
        pid1 = fork(); 
        if (pid1 == 0) { 
             
            printf("child[2] --> pid = %d and ppid = %d\n", 
                   getpid(), getppid()); 
         sleep(2);
          int gpid=fork();
        if(gpid==0){
    
         printf("child-grand[3] --> pid = %d and ppid = %d\n", 
               getpid(), getppid());
        }
         else{
         int gpid2=fork(); 
         if(gpid2==0){
        
         printf("child-grand[4] --> pid = %d and ppid = %d\n", 
               getpid(), getppid());
         }
        }
          
        } 
            
            else { 
                     sleep(4);
                 
                printf("parent --> pid = %d\n", getpid()); 
            } 
    } 
  
    return 0; 
}