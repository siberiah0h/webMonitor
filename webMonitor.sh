#bin/sh
#Powered by siberia
#定义网站路径
webDir="/home/weaver/oa"

#定义日志存储路径
path="/tmp/webMonitor"

#时间戳
nowDate=`date "+%Y-%m-%d %H:%M:%S"`

#初始化路径模块
if [ ! -d ${path} ];
    then
        mkdir -p ${path}
        echo "[ ${nowDate} ] 初始化日志存储路径完成 ${path} " >> ${path}/runLogs.log
    else
        echo "[ ${nowDate} ] 数据${path}路径不需要初始化" >> ${path}/runLogs.log
fi

#初始化MD5数据
if [ ! -f ${path}/initMd5sumLogs.log ] ;
    then
        touch ${path}/initMd5sumLogs.log
        #echo `find webDir -type f > ${path}/initMd5sumLogs.log`
        find ${webDir} -name "*.jsp" | xargs md5sum > ${path}/initMd5sumLogs.log
        echo "[ ${nowDate} ] 初始化WEB网站MD5数据完成 ${path}/initMd5sumLogs.log" >> ${path}/runLogs.log
    else
        echo "[ ${nowDate} ] 数据存在不需要初始化" >> ${path}/runLogs.log
fi

#初始化文件数量        
if [ ! -f ${path}/initFileLogs.log  ] ;
    then
        touch ${path}/initFileLogs.log
        find ${webDir} -name "*.jsp" > ${path}/initFileLogs.log 
        echo "[ ${nowDate} ] 初始化WEB网页数据完成 ${path}/initFileLogs.log" >> ${path}/runLogs.log
    else
        echo "[ ${nowDate} ] 数据存在不需要初始化" >> ${path}/runLogs.log
fi

#监控MD5数据模块
md5Failed=`md5sum -c ${path}/initMd5sumLogs.log 2> /dev/null | egrep -i "failed"` 
if [ "${md5Failed}" ]
    then
        echo "[ ${nowDate} ] [md5Failed_INFO] 被篡改文件 ${md5Failed}" >> ${path}/runLogs.log
        echo "[ ${nowDate} ] [md5Failed_INFO] 被篡改文件 ${md5Failed}" | mail -s "网页防篡改安全提示" xxx@xxx.com
    else
        echo "[ ${nowDate} ] 未发生篡改情况" >> ${path}/runLogs.log
fi

#监控文件增加模块 #邮件模块
find ${webDir} -name "*.jsp" > ${path}/monitorFileLogs.log
diffFaild=`diff ${path}/initFileLogs.log ${path}/monitorFileLogs.log`
if [ "${diffFaild}" ]
    then
        echo "[ ${nowDate} ] [diffFaild_INFO] 网站文件存在增加 ${diffFaild}" >> ${path}/runLogs.log
        echo "[ ${nowDate} ] [diffFaild_INFO] 网站文件存在增加 ${diffFaild}" | mail -s "网页防篡改安全提示" xxx@xxx.com
    else
        echo "[ ${nowDate} ]  未发生文件增加" >> ${path}/runLogs.log
fi






