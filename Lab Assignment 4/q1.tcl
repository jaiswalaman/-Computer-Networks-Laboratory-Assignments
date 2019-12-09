# Aman Jaiswal
# Enrolment Number : 17114008

#——-Event scheduler object creation——–#
set ns [new Simulator]

#———-creating nam objects—————-#

puts "varying entity -- "
puts "1.Queue Size     2.Bandwidth"
gets stdin ans

puts "Enter the test number: "
gets stdin fileNo

if {$ans == 1} {
	puts "Enter the queue length the links : "
	gets stdin qLen
	set bandwidth23 1Mb
} else {
	puts "Enter the bandwidth for link 2-3 : "
	gets stdin bandwidth23
	set qLen 3
}


set nf [open CodeQ1.nam w]
$ns namtrace-all $nf

set nt [open CodeQ1_$fileNo.tr w]
$ns trace-all $nt

#———- Creating Network—————-#

set node_(1) [$ns node]
set node_(2) [$ns node]
set node_(3) [$ns node]

set totalNodes 3

for {set i 1} {$i <= $totalNodes} {incr i} {
$node_($i) shape circle
$node_($i) color blue
}

# setting bandwidth
set bandwidth12 3Mb

$ns duplex-link $node_(2) $node_(1) $bandwidth12 10ms DropTail
$ns duplex-link $node_(2) $node_(3) $bandwidth23 10ms DropTail


#Attach a Queue of size N Packets between the nodes
$ns queue-limit $node_(1) $node_(2) $qLen
$ns queue-limit $node_(2) $node_(3) $qLen


#————Data Transfer between Nodes—————-#

#Create a TCP agent and attach it to node node_(1)
set tcp(1) [new Agent/TCP]
$ns attach-agent $node_(1) $tcp(1)
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node node_(2)
set sink(1) [new Agent/TCPSink]
$ns attach-agent $node_(2) $sink(1)
#Connect the traffic sources with the traffic sink
$ns connect $tcp(1) $sink(1)

#Create a TCP agent and attach it to node node_(3)
set tcp(2) [new Agent/TCP]
$ns attach-agent $node_(2) $tcp(2)
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node node_(2)
set sink(2) [new Agent/TCPSink]
$ns attach-agent $node_(3) $sink(2)
#Connect the traffic sources with the traffic sink
$ns connect $tcp(2) $sink(2)


# Setting flow color
$ns color 1 red
$ns color 2 blue

$tcp(1) set fid_ 1
$tcp(2) set fid_ 2

set cbr(1) [new Application/Traffic/CBR]
$cbr(1) set packetSize_ 1000 # in Bytes
$cbr(1) set interval_ 0.01
$cbr(1) attach-agent $tcp(1)

set cbr(2) [new Application/Traffic/CBR]
$cbr(2) set packetSize_ 1000 # in Bytes
$cbr(2) set interval_ 0.01
$cbr(2) attach-agent $tcp(2)


#———finish procedure——–#

proc finish {} {
global ns nf nt
$ns flush-trace
close $nt
puts "running nam…"
exec nam CodeQ1.nam &
exit 0
}

# data packet generation starting time
$ns at 0.5 "$cbr(1) start"
$ns at 1.0 "$cbr(2) start"

# data packet generation ending time
$ns at 5.0 "$cbr(1) stop"
$ns at 4.5 "$cbr(2) stop"

#Calling finish procedure
$ns at 6.0 "finish"
$ns run