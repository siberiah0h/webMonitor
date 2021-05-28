# webMonitor
简单的网站防篡改监控脚本

主要原理：对比文件MD5值，若发送变化就判断为被异常篡改

定义网站路径
webDir="/home/weaver/oa"

定义日志存储路径
path="/tmp/webMonitor"

若添加邮件发送，需要安装mail

运行方式：
在定时任务中加入运行即可，定时一小时发送一次或者一天发送一次，频率自己调节
所有存储的数据都放在/tmp/webMonitor
