
# dk_jjys
docker of jiajiamuying(php+nodejs+java+golang+elastic search)


2019年3月23日 11:16:49
家家母婴集团,线上一体化封装,
云映像基于ubuntu16.64,
同时包含golang+php+nodejs+java+elastric search. 
线上有涉及的业务都支持了,
整包的大小才1.12G,
现用于全站的docker-compose与k8s与docker swarm等集群管理 
感谢docker团队的付出与贡献.
by 锋锋


ubuntu=16.04
php=PHP 7.0.32-0ubuntu0.16.04.1 (cli)


测试镜像
dokcer run --rm -it dk_jjys
会进入到子容器运行

#以服务启动
docker run --itd dk_jjys

#测试golang
go get github.com/Masterminds/glide


2017年12月27日 15:50:36
tzselect
选择491
修改系统时间
echo $(date)检查时区是否正确


gopath在/usr/gopath里面.


#dev环境:ddys_run为php运行时的数据目录ddys_run/elasticsearch为es数据目录
docker run --name dev -v /home/:/home/ -v /home/ddys_run/elasticsearch/:/var/lib/elasticsearch/ -p 3011:80 -itd dk_jjys

#tester环境
docker run --name tester -v /data/tester/:/home/ -v /data/tester/ddys_run/elasticsearch/:/var/lib/elasticsearch/ -p 4010:80 -itd dk_jjys

#online环境
docker run --name online -v /data/htdoc/:/home/ -v /data/htdoc/ddys_run/elasticsearch/:/var/lib/elasticsearch/ -p 6010:80 -itd dk_jjys


