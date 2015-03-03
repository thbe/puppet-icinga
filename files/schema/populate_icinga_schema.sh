#! /bin/sh
#
# Populate database schema for icinga and icinga_web
#

# Stop on error
set -e

# Set MySQL parameter
MYSQL_COMMAND="/usr/bin/mysql"
MYSQL_USER="root"
MYSQL_PASSWORD=${1:-0nly4install}

# Define schema
SCHEMA_IDO=$(ls -1 /usr/share/icinga2-ido-mysql/schema/mysql.sql)
SCHEMA_WEB=$(ls -1 /usr/share/doc/icinga-web-*/schema/mysql.sql)

# Populate icinga ido schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_icinga ]; then
  ${MYSQL_COMMAND} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} icinga < ${SCHEMA_IDO}
  if [ ${?} -eq 0 ]; then
    echo "database schema created" > /etc/sysconfig/mysqldb_icinga
  fi
fi

# Populate icinga web schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_icinga_web ]; then
  ${MYSQL_COMMAND} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} icinga_web < ${SCHEMA_WEB}
  if [ ${?} -eq 0 ]; then
    echo "database schema created" > /etc/sysconfig/mysqldb_icinga_web
  fi
fi
