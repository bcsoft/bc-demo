BC平台演示

浏览： https://github.com/rongjihuang/bc-demo
源码： [内网]git@[serverIp]:bc-demo.git 或 [外网]git@github.com:rongjihuang/bc-demo.git
打包：http://code.google.com/p/dragon-bc/

一) 浏览器兼容性
Chrome11、Firefox4、Safari5、Opera11、IE9、IE8

二) 目录结构及主要文件说明
bc-demo
  |--src
  |  |--main
  |  |  |--java
  |  |  |--resources
  |  |  |  |--db
  |  |  |  |  |--db.[dbType].drop.sql    ->数据库删表脚本
  |  |  |  |  |--db.[dbType].create.sql  ->数据库建表脚本
  |  |  |  |  |--db.[dbType].data.sql    ->数据库初始化数据导入脚本
  |  |  |  |--META-INF
  |  |  |  |  |--persistence.xml      ->JPA配置文件
  |  |  |  |--log4j.xml               ->log4j日志配置文件
  |  |  |  |--global.properties       ->struts全局国际化配置文件
  |  |  |  |--db.properties           ->数据库连接配置文件
  |  |  |  |--spring.xml              ->spring主配置文件
  |  |  |  |--spring-db.xml           ->spring子配置文件：数据库连接配置，与db.properties配合
  |  |  |  |--struts.xml              ->struts主配置文件
  |  |  |  |--...
  |  |  |--webapp
  |  |  |  |--bc                      ->bc平台的页面文件，对应bc-framework-webapp.git仓库
  |  |  |  |--bc-test                 ->bc平台测试和设计用的页面文件，对应bc-test-webapp.git仓库
  |  |  |  |--ui-libs                 ->开源UI组件库，对应ui-libs.git仓库
  |  |  |  |--ui-libs-demo            ->开源UI组件库的demo，对应ui-libs-demo.git仓库
  |  |  |  |--WEB-INF
  |  |  |  |  |--web.xml              ->web主体配置文件
  |  |  |  |--...
  |  |--test
  |  |  |--java
  |  |  |--resources
  |--.gitignore                       ->git仓库配置文件
  |--build.xml                        ->ant脚本，用于合并sql脚本，清空临时文件等
  |--pom.xml                          ->maven配置文件
  |--readme.txt                       ->项目说明文件

三) 源码编译运行步骤：
1) 检出本工程
   地址： [内网]git@[serverIp]:bc-demo.git 或 [外网]git@github.com:rongjihuang/bc-demo.git
2) 检出ui-libs工程到本工程的src/main/webapp目录下
   地址： [内网]git@[serverIp]:ui-libs.git 或 [外网]git@github.com:rongjihuang/ui-libs.git
3) 检出ui-libs-demo工程到本工程的src/main/webapp目录下
   地址： [内网]git@[serverIp]:ui-libs-demo.git 或 [外网]git@github.com:rongjihuang/ui-libs-demo.git
4) 检出bc-framework工程到与本工程同级的目录
   地址： [内网]git@[serverIp]:bc-framework.git 或 [外网]git@github.com:rongjihuang/bc-framework.git
   执行编译发布:  >mvn clean install -Dmaven.test.skip=true
5) 检出bc-framework-webapp工程到本工程的src/main/webapp目录下
   地址： [内网]git@[serverIp]:bc-framework-webapp.git 或 [外网]git@github.com:rongjihuang/bc-framework-webapp.git
   注：检出的目录名必须为bc
6) 部署数据库
6-1)使用 postgresql (9.1.2)
    打开 pgAdmin III，创建用户bcdemo，密码也设为bcdemo，创建UTF8数据库bcdemo(属主设为用户bcdemo)
	(如有异，可修改src/main/resource/db.properties文件)；
	按顺序执行如下脚本：
    db.postgresql.drop.sql --> 删表(首次不需运行)
    db.postgresql.create.sql --> 建表
    db.postgresql.data.sql --> 导入初始化数据
6-2)使用 mysql (5.5.9 MySQL Community Server)
    >cd bc-demo
    >ant build
    >cd src/main/resources/db
    * 使用mysql命令行创建名为bcdemo的数据库(数据库编码须使用UTF-8)，分配用户bcdemo，密码也设置为bcdemo
	* (如有异，可修改src/main/resource/db.properties文件)
	* 按顺序运行如下脚本
    >mysql -ubcdemo -pbcdemo bcdemo < db.mysql.drop.sql --> 删表(首次不需运行)
    >mysql -ubcdemo -pbcdemo bcdemo < db.mysql.create.sql --> 建表
    >mysql -ubcdemo -pbcdemo bcdemo < db.mysql.data.sql --> 导入初始化数据
6-3)使用 oracle (11.2.0.1)
    >cd bc-demo
    >ant build
    >cd src/main/resources/db
    * 给数据库(数据库编码须使用ZHS16GBK)创建用户bcdemo，密码也设置为bcdemo，并假设数据库的本地连接服务名为orcl，如下登录sqlplus
	* (如有异，可修改src/main/resource/db.properties文件)
    >sqlplus bcdemo/bcdemo@orcl
	* 按顺序运行如下脚本
    SQL>set serveroutput on --> 设置控制台输出更多信息
    SQL>start db.oracle.drop.sql --> 删表(首次不需运行)
    SQL>start db.oracle.create.sql --> 建表
    SQL>start db.oracle.data.sql --> 导入初始化数据
    SQL>commit; --> 提交事务
7) 编译运行
7-1)使用mysql(默认)
   >mvn jetty:run
   或
   >mvn jetty:run -Djetty.path=/bcdemo
7-2)使用oracle 
   >mvn jetty:run -Poracle -Ddb.name=[数据库的SID] -Ddb.ip=[数据库服务器的IP]
   或
   >mvn jetty:run -Djetty.path=/bcdemo -Poracle -Ddb.name=[数据库的SID] -Ddb.ip=[数据库服务器的IP]
8) 浏览器访问
   http://localhost:8082
   或
   http://localhost:8082/bcdemo
   
四) 部署文档转换服务
如果要使用系统在线查看Office文档的功能，需要在服务器部署OpenOffice的文档转换服务：
1) 下载安装OpenOffice3
到 http://www.openoffice.org 下载 OpenOffice3，并安装到服务器；
如果是Windows版的服务器操作系统，安装完毕后先行打开openoffice一次并关闭，然后杀掉soffice.bin和soffice.exe两个进程。 
2) 用命令行启动文档转换服务
打开命令行，进入openoffice安装目录下的program目录，输入如下命令：
>soffice -headless -accept="socket,port=8100;urp;"
注：如果附件文档为xls、xlsx、doc、docx格式，系统自动将其转换为pdf格式在线查看，客户端不需要安装Office软件了，
但需要浏览器支持直接查看pdf文件的功能。Chrome原生支持pdf查看，无须插件；Firefox、Safari等其他浏览器需安装pdf插件，
一般安装Adobe Reader软件会自动安装相应的浏览器插件。
   
五) 其他注意问题
由于项目依赖的一些包在标准maven仓库内没有，对于这些包需要自己手动将其deploy到你的nexus仓库(如果你使用nexus的话)，这些包包括：
1) apache的batik，版本1.7
用于将svg导出为图片、pdf文件等；标准maven仓库内有1.6版的，但经过测试其导出的质量不如1.7版，且常会报错。
官方网站：http://xmlgraphics.apache.org/batik/
下载：http://mirror.bjtu.edu.cn/apache//xmlgraphics/batik/batik-1.7.zip
2) jodconverter，版本2.2.2
用于转换office文档为pdf文件在线查看等；标准maven仓库内有2.2.1版的，但其不支持office2010格式文件的转换。
官方网站：http://www.artofsolving.com/opensource/jodconverter
下载：http://nchc.dl.sourceforge.net/project/jodconverter/JODConverter/2.2.2/jodconverter-2.2.2.zip
3)对于不支持html5上传文件的浏览器，如IE等，附件上传使用了SWFUpload组件实现多文件选择上传功能，
这个组件需要flash插件的支持，因此这些浏览器需要安装flash才能正常使用。当前测试通过的flash版本为13.0。

六）测试发布注意事项：
1)备份原有数据库
2)发布测试系统
>mvn clean package -Pmysql -Ddb.type=mysql -Ddb.name=bcdemo -Ddb.ip=127.0.0.1 -Dapp.debug=false -Ddb.username=bcdemo -Ddb.password=bcdemo -Dapp.data.realPath=/bcdata4demo -Dapp.ts=20111102
修改WEB-INF/web.xml文件，将appRealDir参数的值修改为/bcdata4demo。
修改classess/log4j.xml，将日志级别统一设为ERROR,修改日志的文件名为bcdemo_vxx.log。
修改classess/db.properties，确认数据库连接参数正确：测试系统使用帐号bcdemo/bcdemo。
修改classess/global.properties，确认如下参数正确：
    app.debug=false
    app.ts=20111220
    app.data.realPath=/bcdata4demo
