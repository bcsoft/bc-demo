BC平台演示

浏览地址： https://github.com/rongjihuang/bc-demo
源码检出： git@github.com:rongjihuang/bc-demo.git

一) 浏览器兼容性：
Chrome11、Firefox4、Safari5、Opera11、IE9、IE8

二) 源码编译运行步骤：
1) 检出本工程
   检出地址： git@github.com:rongjihuang/bc-demo.git
2) 检出ui-libs工程到本工程的src/main/webapp目录下
   检出地址： git@github.com:rongjihuang/ui-libs.git
3) 检出bc-framework工程并编译发布
   检出地址： git@github.com:rongjihuang/bc-framework.git
   编译发布:  >mvn clean install -Dmaven.test.skip=true
   部署测试数据库(mysql): 
       >cd bc-framework
       >ant
       >cd build
       >使用mysql命令行创建名为bcdemo的数据库，分配用户bcdemo，密码也设置为bcdemo
       >mysql -ubcdemo -pbcdemo bcdemo < db.mysql.drop.sql
       >mysql -ubcdemo -pbcdemo bcdemo < db.mysql.create.sql
       >mysql -ubcdemo -pbcdemo bcdemo < db.mysql.data.sql
4) 编译运行
   >mvn jetty:run
5) 浏览器访问
   http://localhost:8082
