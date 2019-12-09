# Aman Jaiswal
# Enrolment Number : 17114008

#——-Event scheduler object creation——–#
set ns [new Simulator]

puts "Enter the test number: "
gets stdin fileNo

puts "Enter the number of packets: "
gets stdin pack
puts "Enter the queue length of 0-2"
gets stdin qLen_0_2
puts "Enter the queue length of 2-3"
gets stdin qLen_2_3
puts "Enter the queue length of 3-4: "
gets stdin qLen_3_4
puts "Enter the queue length of 5-3: "
gets stdin qLen_5_3
puts "Enter the queue length of 3-2: "
gets stdin qLen_3_2
puts "Enter the queue length of 2-1: "
gets stdin qLen_2_1

puts "Enter the bandwidth of 0-2:"
gets stdin band_0_2
puts "Enter the bandwidth of 2-3: "
gets stdin band_2_3
puts "Enter the bandwidth of 3-4: "
gets stdin band_3_4
puts "Enter the bandwidth of 5-3:"
gets stdin band_5_3
puts "Enter the bandwidth of 2-1: "
gets stdin band_2_1

#———-creating nam objects—————-#

set nf [open q2.nam w]
$ns namtrace-all $nf

set nt [open q2_$fileNo.tr w]
$ns trace-all $nt

#———- Creating Network—————-#

set node_(0) [$ns node]
set node_(1) [$ns node]
set node_(2) [$ns node]
set node_(3) [$ns node]
set node_(4) [$ns node]
set node_(5) [$ns node]

set totalNodes 6

for {set i 0} {$i < $totalNodes} {incr i} {
$node_($i) shape circle
$node_($i) color blue
}

# setting bandwidth
set bandwidth 1Mb

$ns duplex-link $node_(0) $node_(2) $band_0_2 50ms DropTail
$ns duplex-link $node_(1) $node_(2) $band_2_1 50ms DropTail
$ns duplex-link $node_(2) $node_(3) $band_2_3 50ms DropTail
$ns duplex-link $node_(3) $node_(4) $band_3_4 50ms DropTail
$ns duplex-link $node_(5) $node_(3) $band_5_3 50ms DropTail

Agent/Ping instproc recv {from rtt} {
        $self instvar node_
        puts "node [$node_ id] received ping answer from \
              $from with round-trip-time $rtt ms."
}
set p0 [new Agent/Ping]
set p1 [new Agent/Ping]
set p2 [new Agent/Ping]
set p3 [new Agent/Ping]
set p4 [new Agent/Ping]
set p5 [new Agent/Ping]

$ns attach-agent $node_(0) $p0
$ns attach-agent $node_(1) $p1
$ns attach-agent $node_(2) $p2 
$ns attach-agent $node_(3) $p3 
$ns attach-agent $node_(4) $p4
$ns attach-agent $node_(5) $p5

$ns queue-limit $node_(0) $node_(2) $qLen_0_2
$ns queue-limit $node_(2) $node_(3) $qLen_2_3
$ns queue-limit $node_(3) $node_(4) $qLen_3_4
$ns queue-limit $node_(5) $node_(3) $qLen_5_3
$ns queue-limit $node_(3) $node_(2) $qLen_3_2
$ns queue-limit $node_(2) $node_(1) $qLen_2_1

$p0 set packetSize_ 5000
$p0 set interval_ 0.0001
$p5 set packetSize_ 6000
$p5 set interval_ 0.0001
$p0 set class_ 1
$p5 set class_ 2

$ns connect $p0 $p4
$ns connect $p5 $p1


for {set i 1} {$i <= $pack} {incr i} {
$ns at 0.1 "$p0 send" 
$ns at 0.1 "$p5 send"
}



#———finish procedure——–#

proc finish {} {
global fileNo pack qLen_0_2 qLen_2_3 qLen_3_4 qLen_5_3 qLen_3_2 qLen_2_1 band_0_2 band_2_3 band_3_4 band_5_3 band_2_1
global ns nf nt
$ns flush-trace
close $nt
puts "running nam…"
set param_file [ open "param_$fileNo.txt" w]
puts $param_file "$pack $qLen_0_2 $qLen_2_3 $qLen_3_4 $qLen_5_3 $qLen_3_2 $qLen_2_1 $band_0_2 $band_2_3 $band_3_4 $band_5_3 $band_2_1\n"
close $param_file
exec nam q2.nam &
exit 0
}

#Calling finish procedure
$ns at 12.0 "finish"
$ns run