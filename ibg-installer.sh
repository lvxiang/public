#!/bin/sh

git clone git@gitlab.alibaba-inc.com:lvxiang.lx/Overspark.git
if [ -d Overspark ]; then
	cd Overspark/IBatisGenerator
	echo "packaging IBatisGenerator with maven"
	mvn package
	if [ -d target ]; then
		mv target/ibatis.generator-1.0-SNAPSHOT.jar /usr/local/bin/ibg.jar
		cd ../..
		rm -rf Overspark
		if [ -f /usr/local/bin/ibg ]; then
			rm -f /usr/local/bin/ibg
		fi		
		touch /usr/local/bin/ibg
		echo "#!/bin/sh\n" >> /usr/local/bin/ibg
		echo "java -jar /usr/local/bin/ibg.jar $*" >> /usr/local/bin/ibg
		chmod a+x /usr/local/bin/ibg
		echo "you have successfully installed IBatisGenerator!"
	else
		echo "mvn build failed..."
		exit 1	
	fi
else
	echo "failed to get IBatisGenerator source files..."
	exit 1
fi
