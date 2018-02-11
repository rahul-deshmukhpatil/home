epoch=`date +%s`
count=4	# display first 4 processes alternatley
line=`top -n 1 -b | head -8 | tail -1 | tr -s " "`
PID=`echo $line | cut -d " " -f 1`
USER=`echo $line | cut -d " " -f 2`
PR=`echo $line | cut -d " " -f 3`
NI=`echo $line | cut -d " " -f 4`
VIRT=`echo $line | cut -d " " -f 5`
RES=`echo $line | cut -d " " -f 6`
SHR=`echo $line | cut -d " " -f 7`
S=`echo $line | cut -d " " -f 8`
CPU=`echo $line | cut -d " " -f 9`
MEM=`echo $line | cut -d " " -f 10`
TIME=`echo $line | cut -d " " -f 11`
COMMAND=`echo $line | cut -d " " -f 12`

printf "VIRT:%-8s CPU:%-4s MEM:%-4s USR=%-8s CMD=%s" $VIRT $CPU $MEM $USER $COMMAND

#PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                       
#6492 jcrawfo+  20   0 1299468  84664  24488 S   7.3  1.4   4:56.17 deluge-gtk    
