#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libtiff${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/graphics/libtiff.lha" -o /tmp/libtiff.lha && \
		lha -xfq2 libtiff.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;