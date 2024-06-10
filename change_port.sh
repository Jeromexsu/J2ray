application_conf_path=conf/application.properties
nginx_conf_path=conf/server443.conf
last_port_path=last_port
last_pid_path=last_pid
jar_name=j2ray1225.jar

last_port=$(cat $last_port_path)
next_port=$((RANDOM % 64512 + 1024))
echo $next_port
echo $last_port

# modify j2ray conf
sed -i "" 's/^v2ray\.config\.port=.*/v2ray.config.port='"$next_port"'/' $application_conf_path
last_pid=$(cat $last_pid_path)
kill -9 $last_pid
nohup java -jar $jar_name 1>log/access.log 2>log/error.log &
echo $! > last_pid

# modify nginx conf
sed -i "" "s/$last_port/$next_port/g" $nginx_conf_path
systemctl restart nginx

echo $next_port>last_port
echo "new port: $next_port"
