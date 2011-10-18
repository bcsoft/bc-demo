cd ..
cd bc-framework
echo "--------bc-framework"
git status
git pull origin master
mvn install -DskipTests=true
cd ..
cd bc-demo
echo "--------bc-demo"
git status
git pull origin master
ant build
cd src/main/webapp/bc
echo "--------bc-demo/src/main/webapp/bc"
git status
git pull origin master
cd ..
cd bc-test
echo "--------bc-demo/src/main/webapp/bc-test"
git status
git pull origin master
cd ..
cd ui-libs
echo "--------bc-demo/src/main/webapp/ui-libs"
git status
git pull origin master
cd ..
cd ui-libs-demo
echo "--------bc-demo/src/main/webapp/ui-libs-demo"
git status
git pull origin master
cd ..
cd ..
cd resources/db
echo "--------bc-demo/src/main/resources/db"
mysql -ubcdemo -pbcdemo bcdemo < db.mysql.drop.sql
mysql -ubcdemo -pbcdemo bcdemo < db.mysql.create.sql
mysql -ubcdemo -pbcdemo bcdemo < db.mysql.data.sql

cd ..
cd ..
cd ..
cd ..
echo "--------bc-demo"
mvn jetty:run -Dapp.debug=true