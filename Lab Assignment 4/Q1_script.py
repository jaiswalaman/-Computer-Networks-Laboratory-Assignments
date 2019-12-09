import os
import matplotlib.pyplot as plt

num = int(input("Enter the number of test cases: "))
for _ in range(0, num):
	os.system("ns q1.tcl")


print("Enter the inputs to plot the Graphs -- ")

check = int(input("What did you vary : \n 1.Queue Size     2.Bandwidth\n"))
if(check==1) :
	r1 = int(input("Enter starting queue length: "))
	r2 = int(input("Enter max queue length: "))
else :
	r1 = int(input("Enter starting bandwidth: "))
	r2 = int(input("Enter max bandwidth: "))

qu=[]
for i in range(r1,r2+1):
	qu.append(i) 

drop_arr = [0]*num
for i in range(num):
	arr = open("CodeQ1_" + str(i) + ".tr", "r").read().split("\n")
	for line in arr:
		ele = line.split()
		if len(ele) < 1:
			continue
		if ele[0] is 'd':
			drop_arr[i] = drop_arr[i] + 1
print("Drops : "+str(drop_arr))
print("Queue-lengths : "+str(qu))

plt.bar(qu, drop_arr)
plt.show()