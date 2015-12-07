#change the path to mach your hbase log dir
logpath="/var/log/hbase/"

IFS=$'\n'
echo "timestamp,day,time,region,flushSize,timeSpent"
for j in `cat $logpath/hbase-hbase-regionserver*log | grep -i "Finished memstore flush"`
do
day=$(echo $j | cut -f1 -d ' ')
time=$(echo $j | cut -f2 -d ' '| cut -f1 -d ',')
region=$(echo $j | sed -e 's/^.*for region \([^ ,]*\).*$/\1/')
flushSize=$(echo $j | sed -e 's/^.*Finished memstore flush of \([^/,]*\).*$/\1/')
timeSpent=$(echo $j | sed -e 's/^.*in \([^,]*\).*$/\1/')
ts=$(date -d "$day $time" +%s)
echo "$ts,$day,$time,$region,$flushSize,$timeSpent"
done
~       
