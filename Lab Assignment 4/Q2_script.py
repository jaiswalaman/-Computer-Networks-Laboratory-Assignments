import os
import matplotlib.pyplot as plt

num = int(input("Enter the number of test cases: "))
for _ in range(0, num):
	os.system("ns q2.tcl")

arr = []
for i in range(13):
    arr.append([])
print(arr)

for i in range(0, num):
    drop = 0
    file = open("param_" + str(i) + ".txt", "r").read().split()
    print(file)
    for j in range(12):
        arr[j].append(file[j])
    file = open("q2_" + str(i) + ".tr", "r").read().split("\n")
    for line in file:
        ele = line.split()
        if len(ele) < 1:
            continue
        if ele[0] is 'd':
            drop = drop  + 1
    arr[12].append(drop)

import plotly.graph_objects as go

fig = go.Figure(data=[go.Table(header=dict(values=['packets', 'queue length 0-2', 'queue length 2-3', 'queue length 3-4', 'queue length 5-3','queue length 3-2','queue length 2-1' ,'bandwidth 0-2', 'bandwidth 2-3', 'bandwidth 3-4','bandwidth 5-3','bandwidth 2-1' ,'drops']),
                 cells=dict(values=arr))
                     ])
fig.show()