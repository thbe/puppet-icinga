#! /bin/sh
#
# Populate database schema for icinga and icinga_web
#

# Stop on error
set -e

# Set MySQL parameter
MYSQL_COMMAND="/usr/bin/mysql"

# Define schema
SCHEMA_IDO=$(ls -1 /usr/share/doc/icinga2-ido-mysql-*/schema/mysql.sql)
SCHMEA_WEB=$(ls -1 /usr/share/doc/icinga-web-*/schema/mysql.sql)

# Populate icinga ido schema
if [ ! -f /etc/sysconfig/mysqldb_icinga ]; then
  ${MYSQL_COMMAND} icinga < ${SCHEMA_IDO}
  if [ ${} -eq 0 ]; then
    echo "true" > /etc/sysconfig/mysqldb_icinga
  fi
fi

# Populate icinga web schema
if [ ! -f /etc/sysconfig/mysqldb_icinga ]; then
  ${MYSQL_COMMAND} icinga_web < ${SCHEMA_WEB}
  if [ ${} -eq 0 ]; then
    echo "true" > /etc/sysconfig/mysqldb_icinga_web
  fi
fi
