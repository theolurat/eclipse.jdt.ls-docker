#!/bin/bash

launcher_file_name=$(find ./plugins -name "org.eclipse.equinox.launcher_*.jar" | sort | head -n 1)

# -DCLIENT_HOST=0.0.0.0 --> to change with conf of your deployment !!!

java \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
	-Dlog.level=ALL \
	-Dosgi.dev \
 	-Dsocket.stream.debug=true \
	-Xmx1G \
	-DCLIENT_PORT=5036 \
	-DCLIENT_HOST=0.0.0.0 \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	-jar $launcher_file_name \
	-configuration ./config_linux \
	-data $ECLIPSE_WORKSPACE \