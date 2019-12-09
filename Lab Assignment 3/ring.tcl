#Aman Jaiswal 17114008
#Create a simulator object
set ns [new Simulator]

#Routing Protocol used is Distance Vector
$ns rtproto DV
#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    #Close the trace file
    close $nf
    #Executenam on the trace file
    exec nam out.nam &
    exit 0
}

# Present a message
puts "Enter a No of Nodes: "

# Get input from standard input (keyboard) and store in $nodes
gets stdin nodes

puts  "enter no of pairs"
gets  stdin k
for {set i 0} {$i < $nodes} {incr i} {
            set n($i) [$ns node]
    }
for {set i 0} {$i < $k} {incr i} {
           gets  stdin a($i)
           gets  stdin b($i)
    }


#Create four nodes
#set n0 [$ns node]
# n1 [$ns node]
#set n2 [$ns node]
#set n3 [$ns node]
#set n4 [$ns node]
#set n5 [$ns node]
set j 1
#Create links between the nodes
for {set i 0} {$i < [expr $nodes-1]} {incr i} {
       $ns duplex-link $n($i) $n([expr $i+1]) 1Mb 10ms DropTail
    }
$ns duplex-link $n([expr $nodes-1]) $n(0) 1Mb 10ms DropTail

set time 0


for {set i 0} {$i < $k} {incr i} {
#Create a TCP agent and attach it to node n0
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n($a($i)) $tcp0
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node n3
set sink0 [new Agent/TCPSink]
$ns attach-agent $n($b($i)) $sink0
#Connect the traffic sources with the traffic sink
$ns connect $tcp0 $sink0


# Create a CBR traffic source and attach it to tcp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $tcp0

#Schedule events for the CBR agents
$ns at [expr $time+0.5] "$cbr0 start"

# Break link n2---n3 at 1.3ms 
$ns rtmodel-at [expr $time+1.3] down $n($a(0)) $n($b(0))
$ns at [expr $time+4.5] "$cbr0 stop"

incr time 
incr time 
incr time 
incr time 
incr time 
}

#Call the finish procedure after 5 seconds of simulation time
$ns at $time "finish"

#Run the simulation
$ns run