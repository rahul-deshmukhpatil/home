epoch=`date +%s`
count=`sensors | grep crit | wc -l`
cpuno=`expr $epoch % $count + 1`
temp=`sensors | grep "Core" | head -$cpuno | tail -1 | tr -s " " | cut -d " " -f 3`
cpuno=`expr $epoch % $count`
echo "cpu$cpuno : $temp"

