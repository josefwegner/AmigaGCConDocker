#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
		lha -xfq2 liblua.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;