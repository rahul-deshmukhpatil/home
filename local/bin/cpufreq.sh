epoch=`date +%s`
count=`cat /proc/cpuinfo | grep MHz | wc -l`
cpuno=`expr $epoch % $count + 1`
freq=`cat /proc/cpuinfo | grep MHz | head -$cpuno | tail -1 |  tr -s " " | cut -d ' ' -f 3`
cpuno=`expr $epoch % $count`
echo "cpu$cpuno : $freq "
